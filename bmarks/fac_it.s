	.syntax unified
	.arch armv7-a
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
	.thumb
	.syntax unified
	.file	"fac_it.c"
	.text
	.align	2
	.global	fac
	.thumb
	.thumb_func
	.type	fac, %function
fac:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]
	movs	r3, #1
	str	r3, [r7, #12]
	b	.L2
.L3:
	ldr	r3, [r7, #12]
	ldr	r2, [r7, #4]
	mul	r3, r2, r3
	str	r3, [r7, #12]
	ldr	r3, [r7, #4]
	subs	r3, r3, #1
	str	r3, [r7, #4]
.L2:
	ldr	r3, [r7, #4]
	cmp	r3, #1
	bne	.L3
	ldr	r3, [r7, #12]
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	fac, .-fac
	.align	2
	.global	main
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	movs	r0, #10
	bl	fac(PLT)
	str	r0, [r7, #4]
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.size	main, .-main
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
