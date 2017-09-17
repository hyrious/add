# s-

## Overview

    ; comments (use AT&T syntax because it's
    ; order is the same as machine code)
    55                    ; push %ebp
    89 0345               ; mov  %esp,%ebp
    68 "Hello world\n\0"  ; push str
    e8 _puts              ; call _puts
    83 0304 4             ; add  $4  ,%esp
    31 0300               ; xor  %eax,%eax
    83 0300 d42           ; add  $42 ,%eax
    c9                    ; leave
    c3                    ; ret

## Valid Input

The upper will be used if there is ambiguity, which is to say,
`c3` is `Hex` instead of `Ident`. If you really need, use `[c3]`.

    Comments  -> ';' (!EndOfLine .)+ EndOfLine
    EndOfLine -> '\n' | '\r\n' | '\r'
    Hex       -> [0-9a-fA-F] | [1-9a-fA-F] [0-9a-fA-F]+ | [xX] [0-9a-fA-F]+
    Octal     -> 0[0-3][0-7][0-7] | [oO] [0-7]+
    Digit     -> [dD] [0-9]+
    Binary    -> [bB] [01]+ 
    Ident     -> [_a-zA-Z] [0-9a-zA-Z]+ | '[' [0-9a-zA-Z]+ ']'

## Output

- gas: `.byte 0x8b, 0354` (how to do this in masm?)
- string: `"\x8b\354"`

## Future (if I know how to do)

Macro.

## FAQ

### How to view my C code's assembly/machine code?

    gcc -g -c a.c -o a.o
    objdump -Ss [-M intel] a.o

### Why machine code instead of ASM?

Just for fun(?!)

Seriously, it's aimed to prove that machine code is
able to be read and to be written by hand, just need some formula (spell?).

For example, if we remember **ACDBSBSD** (and give them numbers 0-7).
Then if we know that `push reg = 0x50 + reg`, we can *immediately* write
down `0x55`, which is `push %ebp` (ACDBS**B**SI, the e**b**p was given **5**).

Sometimes(usually) octal numbers are necessary as well.
if we learnt *ModR/M*, we will know that `0345` just means
  1. `3` from reg to reg
  2. `4` e**s**p `5` e**b**p.

### Where's my *$* (or *()*)?

Please go learn *ModR/M*.

### How do I link external functions like `_puts` into s-?

It depends.

If output gas style, you can add `-l <library path>` when compiling.

If output string, which means you probably want to
`CallWindowProc(string.addr)`, then please also put `LoadLibrary`
and `GetProcAddress` into that call (`CWP(str.addr, LL.addr, GPA.addr)`).

I'm not familiar with Linux/MacOS, look forward for your help.

### Can you give a cheatsheet? or How to spell such terrible numbers?

There are many cheatsheets online, please google it.

But I will recommend you to look at (9.45M)
[325383.pdf](https://software.intel.com/sites/default/files/managed/a4/60/325383-sdm-vol-2abcd.pdf)'s Appendix-B.
