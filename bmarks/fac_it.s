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
	.file	"fac_it.c"
	.text
	.align	2
	.global	fac
	.type	fac, %function
fac:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	mov	r3, #1
	str	r3, [fp, #-8]
	b	.L2
.L3:
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-16]
	mul	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-16]
	sub	r3, r3, #1
	str	r3, [fp, #-16]
.L2:
	ldr	r3, [fp, #-16]
	cmp	r3, #1
	bne	.L3
	ldr	r3, [fp, #-8]
	mov	r0, r3
	sub	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	fac, .-fac
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r0, #10
	bl	fac
	str	r0, [fp, #-8]
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	ldmfd	sp!, {fp, pc}
	.size	main, .-main
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
