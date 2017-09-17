module Ssub
  module_function
  def lex str
    str.lines.map { |l| scan l.chomp }.delete_if &:empty?
  end
  def scan line
    ans = []
    until line.empty?
      case
      when raw = line.slice!(/^\;.+$/)             then ans.push [:comment, raw]
      when raw = line.slice!(/^0[0-3][0-7][0-7]/)  then ans.push [:octal  , raw]
      when raw = line.slice!(/^[xX]\h+/)           then ans.push [:hex    , raw]
      when raw = line.slice!(/^[oO][0-7]+/)        then ans.push [:octal  , raw]
      when raw = line.slice!(/^[dD]\d+/)           then ans.push [:digit  , raw]
      when raw = line.slice!(/^[bB][01]+/)         then ans.push [:binary , raw]
      when raw = line.slice!(/^[1-9a-fA-F]\h+/)    then ans.push [:hex    , raw]
      when raw = line.slice!(/^\h/)                then ans.push [:hex    , raw]
      when raw = line.slice!(/^\w+|\[\w+\]/)       then ans.push [:ident  , raw]
      when raw = line.slice!(/^"([^"]|\\\")+"/)    then ans.push [:string , raw]
      when raw = line.slice!(/^\s+/)
      end
    end
    ans
  end
  def gas lexed
    sid = 0
    strings = []
    max_width = 0
    text = ".text\n.global _main\n_main:\n" + lexed.map do |l|
      comment = nil
      ans = '.byte ' + l.map do |type, raw|
        case type
        when :comment then comment = raw; nil
        when :binary  then raw
        when :octal   then raw
        when :digit   then raw[1..-1]
        when :hex     then 'xX'.include?(raw[0]) ? "0#{raw}" : "0x#{raw}"
        when :ident   then raw
        when :string  then strings.push [sid += 1, raw]; "$s#{sid}"
        end
      end.compact.join(',')
      max_width = ans.length if max_width < ans.length
      [ans, comment]
    end.map do |ans, comment|
      ans = format("%-#{max_width+1}s", ans)
      "  #{ans}#{comment}"
    end.join("\n")
    unless strings.empty?
      text += <<~EOD

        .data
        #{strings.map { |i, s| "  s#{i}: #{s}" }.join("\n")}
      EOD
    end
    text
  end
end

require 'ap'
puts Ssub.gas Ssub.lex <<-EOF
; comments (use AT&T syntax because it's
; order is the same as machine code)
55                    ; push %ebp
89 0345               ; mov  %esp,%ebp
68 "Hello world\\n\\0"  ; push str
e8 _puts              ; call _puts
83 0304 4             ; add  $4  ,%esp
31 0300               ; xor  %eax,%eax
83 0300 d42           ; add  $42 ,%eax
c9                    ; leave
c3                    ; ret
EOF
