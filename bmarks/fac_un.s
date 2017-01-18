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
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_1
	b	.LBB0_2
.LBB0_1:                                // %if.then
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_2:                                // %if.end
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_3
	b	.LBB0_4
.LBB0_3:                                // %if.then2
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_4:                                // %if.end5
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_5
	b	.LBB0_6
.LBB0_5:                                // %if.then7
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_6:                                // %if.end10
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_7
	b	.LBB0_8
.LBB0_7:                                // %if.then12
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_8:                                // %if.end15
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_9
	b	.LBB0_10
.LBB0_9:                                // %if.then17
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_10:                               // %if.end20
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_11
	b	.LBB0_12
.LBB0_11:                               // %if.then22
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_12:                               // %if.end25
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_13
	b	.LBB0_14
.LBB0_13:                               // %if.then27
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_14:                               // %if.end30
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_15
	b	.LBB0_16
.LBB0_15:                               // %if.then32
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_16:                               // %if.end35
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_17
	b	.LBB0_18
.LBB0_17:                               // %if.then37
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_18:                               // %if.end40
	ldr	w8, [sp, #4]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_19
	b	.LBB0_20
.LBB0_19:                               // %if.then42
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #4]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #4]
.LBB0_20:                               // %if.end45
	ldr	w0, [sp, #8]
	add	sp, sp, #16             // =16
	ret
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "
