# A--: ASM dec dec

A lower way of writing assembly code -- just write machine code.

_Privous Works_ : [s-.rb](s-.rb)

## FAQ

### How to view my C code's assembly/machine code?

[Compiler Explorer](https://godbolt.org), or

```
gcc -g -c a.c -o a.o
objdump -Ss [-M intel] a.o
```

### Can you provide a cheatsheet? How to spell such terrible numbers?

There are many cheatsheets online, please google it.

I will recommend you to have a look at (9.45M)
[325383.pdf](https://software.intel.com/sites/default/files/managed/a4/60/325383-sdm-vol-2abcd.pdf)'s Appendix-B first.

## Ref.

- (中文) [mouseos/x64](https://web.archive.org/web/20171007052840/http://www.mouseos.com/) (web archive)
- [x86 Assembly Guide][2]
- [x86 Instruction Set Reference][3]
- [325383][0]

_Table B-4 regs_ : ACDBSBSD

```
0 1 2 3 4 5 6 7
A C D B S B S D
```

_Table B-10 tttn_ : OBEBESPLLE

```
0 | 2 | 4 |  6 | 8 | A | C |  E
O | B | E | BE | S | P | L | LE
X | < | = | <= | + | 2 | < | <=

O: Overflow
B: Below (unsigned)
E: Equal
S: Signed
P: Even
L: Less (signed)
```

### Cheatsheet

[![][1]][1]

[0]: https://software.intel.com/sites/default/files/managed/a4/60/325383-sdm-vol-2abcd.pdf
[1]: https://i.stack.imgur.com/VTxd0.jpg
[2]: https://www.cs.virginia.edu/~evans/cs216/guides/x86.html
[3]: http://www.felixcloutier.com/x86
