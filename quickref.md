## s- quickref

- (Chinese 中文) [mouseos](http://www.mouseos.com/x64)
- [x86 Assembly Guide][2]
- [x86 Instruction Set Reference][3]
- [325383][0]

### How to read reference table

**Intel's operand order is in contrast to AT&T (machine code).**

<style>table{font-family:monospace}table strong{color:red}</style>

Take [PUSH][4] for example:

| Opcode | Machine code (s-)        | AT&T      | Description      |
| ------ | ------------------------ | --------- | ---------------- |
| FF /6  | **FF** 0**6**5 d42,0,0,0 | push 42   | 5 = [disp32]     |
| 50+rd  | 51 (**50**+**1**)        | push %ecx | r(eg)d(word)     |
| 6A ib  | **6A** d42               | push $42  | i(mm)b(yte)      |

Easy, let's see [MOV][5]:

| Opcode    | Machine code (s-)        | AT&T           | Description      |
| --------- | ------------------------ | -------------- | ---------------- |
| 89 /r     | **89** 0**3**45          | mov %esp,%ebp  | /r = 03          |
| 8B /r     | **8B** 0**3**54          | mov %esp,%ebp  | Aha! reversed 89 |
| B8+rd id  | **B9** d42,0,0,0         | mov $42,%ecx   | B9 = B8 + 1      |
| C7 /0 id  | **C7** 0**0**1,d42,0,0,0 | mov $42,(%ecx) | B9 = B8 + 1      |

### Spell the Rhythm

From 325383's Appendix B. Order is important.

#### Table B-4 regs

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| - | - | - | - | - | - | - | - |
| A | C | D | B | S | B | S | D |

#### Table B-10 tttn

| 0 | 2 | 4 | 6  | 8 | A | C | E  |
| - | - | - | -- | - | - | - | -- |
| O | B | E | BE | S | P | L | LE |
| X | < | = | <= | + | 2 | < | <= |

    O: Overflow
    P: Even/Odd
    diff B L: B(unsigned) L(signed)

### Other

[![][1]][1]

[0]: https://software.intel.com/sites/default/files/managed/a4/60/325383-sdm-vol-2abcd.pdf
[1]: https://i.stack.imgur.com/VTxd0.jpg
[2]: https://www.cs.virginia.edu/~evans/cs216/guides/x86.html
[3]: http://www.felixcloutier.com/x86
[4]: http://www.felixcloutier.com/x86/PUSH.html
[5]: http://www.felixcloutier.com/x86/MOV.html
