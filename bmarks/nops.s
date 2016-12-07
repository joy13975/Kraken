	.arch armv8-a
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.arm
	.syntax divided
	.file	"nops.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	.syntax divided
@ 4 "nops.c" 1
	nop
@ 0 "" 2
@ 5 "nops.c" 1
	nop
@ 0 "" 2
@ 6 "nops.c" 1
	nop
@ 0 "" 2
@ 7 "nops.c" 1
	nop
@ 0 "" 2
@ 8 "nops.c" 1
	nop
@ 0 "" 2
@ 9 "nops.c" 1
	nop
@ 0 "" 2
@ 10 "nops.c" 1
	nop
@ 0 "" 2
@ 11 "nops.c" 1
	nop
@ 0 "" 2
@ 13 "nops.c" 1
	nop
@ 0 "" 2
@ 14 "nops.c" 1
	nop
@ 0 "" 2
@ 15 "nops.c" 1
	nop
@ 0 "" 2
@ 16 "nops.c" 1
	nop
@ 0 "" 2
@ 17 "nops.c" 1
	nop
@ 0 "" 2
@ 18 "nops.c" 1
	nop
@ 0 "" 2
@ 19 "nops.c" 1
	nop
@ 0 "" 2
@ 20 "nops.c" 1
	nop
@ 0 "" 2
@ 22 "nops.c" 1
	nop
@ 0 "" 2
@ 23 "nops.c" 1
	nop
@ 0 "" 2
@ 24 "nops.c" 1
	nop
@ 0 "" 2
@ 25 "nops.c" 1
	nop
@ 0 "" 2
@ 26 "nops.c" 1
	nop
@ 0 "" 2
@ 27 "nops.c" 1
	nop
@ 0 "" 2
@ 28 "nops.c" 1
	nop
@ 0 "" 2
@ 29 "nops.c" 1
	nop
@ 0 "" 2
@ 31 "nops.c" 1
	nop
@ 0 "" 2
@ 32 "nops.c" 1
	nop
@ 0 "" 2
@ 33 "nops.c" 1
	nop
@ 0 "" 2
@ 34 "nops.c" 1
	nop
@ 0 "" 2
@ 35 "nops.c" 1
	nop
@ 0 "" 2
@ 36 "nops.c" 1
	nop
@ 0 "" 2
@ 37 "nops.c" 1
	nop
@ 0 "" 2
@ 38 "nops.c" 1
	nop
@ 0 "" 2
@ 39 "nops.c" 1
	nop
@ 0 "" 2
@ 40 "nops.c" 1
	nop
@ 0 "" 2
@ 41 "nops.c" 1
	nop
@ 0 "" 2
@ 42 "nops.c" 1
	nop
@ 0 "" 2
@ 43 "nops.c" 1
	nop
@ 0 "" 2
@ 44 "nops.c" 1
	nop
@ 0 "" 2
@ 45 "nops.c" 1
	nop
@ 0 "" 2
@ 46 "nops.c" 1
	nop
@ 0 "" 2
@ 48 "nops.c" 1
	nop
@ 0 "" 2
@ 49 "nops.c" 1
	nop
@ 0 "" 2
@ 50 "nops.c" 1
	nop
@ 0 "" 2
@ 51 "nops.c" 1
	nop
@ 0 "" 2
@ 52 "nops.c" 1
	nop
@ 0 "" 2
@ 53 "nops.c" 1
	nop
@ 0 "" 2
@ 54 "nops.c" 1
	nop
@ 0 "" 2
@ 55 "nops.c" 1
	nop
@ 0 "" 2
@ 57 "nops.c" 1
	nop
@ 0 "" 2
@ 58 "nops.c" 1
	nop
@ 0 "" 2
@ 59 "nops.c" 1
	nop
@ 0 "" 2
@ 60 "nops.c" 1
	nop
@ 0 "" 2
@ 61 "nops.c" 1
	nop
@ 0 "" 2
@ 62 "nops.c" 1
	nop
@ 0 "" 2
@ 63 "nops.c" 1
	nop
@ 0 "" 2
@ 64 "nops.c" 1
	nop
@ 0 "" 2
@ 66 "nops.c" 1
	nop
@ 0 "" 2
@ 67 "nops.c" 1
	nop
@ 0 "" 2
@ 68 "nops.c" 1
	nop
@ 0 "" 2
@ 69 "nops.c" 1
	nop
@ 0 "" 2
@ 70 "nops.c" 1
	nop
@ 0 "" 2
@ 71 "nops.c" 1
	nop
@ 0 "" 2
@ 72 "nops.c" 1
	nop
@ 0 "" 2
@ 73 "nops.c" 1
	nop
@ 0 "" 2
	.arm
	.syntax divided
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	main, .-main
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
