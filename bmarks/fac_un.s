	.text
	.file	"fac_un.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	movz	w8, #0xa
	orr	w9, wzr, #0x1
	movz	w10, #0
	str	w10, [sp, #12]
	str	w9, [sp, #8]
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
	ldr	w0, [sp, #8]
	add	sp, sp, #16             // =16
	ret
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "
