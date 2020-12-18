# Assembly-Projects

Simple assembly programs written with the Netwide Assembler (NASM).

These programs are written for the Intel x86-64 architecture on Linux. They must be assembled in 64-bit mode (32-bit is not compatible). 

This repository is meant to be a compilation of all the programs I've written as learning exercises.

## Assembling

- `nasm src_file.asm -f elf64`
- `ld src_file.o -o executable_file`

## License

Code and documentation Copyright (c) 2020-2021 Keith Leonardo

Code released under the [MIT License](https://choosealicense.com/licenses/mit/).
