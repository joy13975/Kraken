	.text
	.file	"br.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	sub	sp, sp, #32             // =32
	movz	w8, #0
	movz	w9, #0x5
	orr	w10, wzr, #0x3
	orr	w11, wzr, #0x1
	str	w8, [sp, #28]
	str	w11, [sp, #24]
	str	w10, [sp, #20]
	str	w9, [sp, #16]
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #24]
	cmp	 w8, w9
	b.lt	.LBB0_1
	b	.LBB0_2
.LBB0_1:                                // %if.then
	ldr	w8, [sp, #12]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #12]
.LBB0_2:                                // %if.end
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #24]
	cmp	 w8, w9
	b.gt	.LBB0_3
	b	.LBB0_4
.LBB0_3:                                // %if.then2
	ldr	w8, [sp, #12]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #12]
.LBB0_4:                                // %if.end4
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #20]
	cmp	 w8, w9
	b.ne	.LBB0_5
	b	.LBB0_6
.LBB0_5:                                // %if.then6
	ldr	w8, [sp, #12]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #12]
.LBB0_6:                                // %if.end8
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #16]
	cmp	 w8, w9
	b.lt	.LBB0_7
	b	.LBB0_8
.LBB0_7:                                // %if.then10
	ldr	w8, [sp, #12]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #12]
.LBB0_8:                                // %if.end12
	ldr	w0, [sp, #12]
	add	sp, sp, #32             // =32
	ret
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "
