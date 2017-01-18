	.text
	.file	"fib.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	sub	sp, sp, #32             // =32
	movz	w8, #0
	orr	w9, wzr, #0x1
	movz	w10, #0x28
	str	w8, [sp, #28]
	str	w10, [sp, #24]
	str	w8, [sp, #20]
	str	w9, [sp, #16]
	str	w8, [sp, #8]
.LBB0_1:                                // %for.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #8]
	ldr	w9, [sp, #24]
	cmp	 w8, w9
	b.lt	.LBB0_2
	b	.LBB0_7
.LBB0_2:                                // %for.body
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #8]
	cmp	 w8, #1                 // =1
	b.le	.LBB0_3
	b	.LBB0_4
.LBB0_3:                                // %if.then
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #8]
	str	w8, [sp, #12]
	b	.LBB0_5
.LBB0_4:                                // %if.else
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #20]
	ldr	w9, [sp, #16]
	add	 w8, w8, w9
	str	w8, [sp, #12]
	ldr	w8, [sp, #16]
	str	w8, [sp, #20]
	ldr	w8, [sp, #12]
	str	w8, [sp, #16]
.LBB0_5:                                // %if.end
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #12]
	mov	 w9, w8
	sxtw	x9, w9
	str	 x9, [sp]
// BB#6:                                // %for.inc
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #8]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #8]
	b	.LBB0_1
.LBB0_7:                                // %for.end
	ldr	 x8, [sp]
	mov	 w0, w8
	add	sp, sp, #32             // =32
	ret
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "
