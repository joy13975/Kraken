	.text
	.file	"fac_un.c"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	orr	w8, wzr, #0x1
	str	w0, [sp, #12]
	str	w8, [sp, #8]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w0, [sp, #8]
	mul	 w0, w0, w8
	str	w0, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w0, #0
	add	 w8, w8, w0
	str	w8, [sp, #12]
	ldr	w0, [sp, #8]
	add	sp, sp, #16             // =16
	ret
.Ltmp1:
	.size	fac, .Ltmp1-fac

	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	movz	w0, #0x64
	movz	w8, #0
	stur	w8, [x29, #-4]
	bl	fac
	str	w0, [sp, #8]
	ldr	w0, [sp, #8]
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp2:
	.size	main, .Ltmp2-main


	.ident	"clang version 3.5.0 "
