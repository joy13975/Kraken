	.text
	.file	"pi_int.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x28, x27, [sp, #-16]!
	sub	sp, sp, #2, lsl #12     // =8192
	sub	sp, sp, #3040           // =3040
	movz	w8, #0
	str	w8, [sp, #11228]
	str	w8, [sp, #4]
	str	w8, [sp, #20]
.LBB0_1:                                // %for.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #20]
	cmp	 w8, #2800              // =2800
	b.lt	.LBB0_2
	b	.LBB0_4
.LBB0_2:                                // %for.body
                                        //   in Loop: Header=BB0_1 Depth=1
	movz	w8, #0x7d0
	add	x9, sp, #24             // =24
	ldr	w10, [sp, #20]
	mov	 w11, w10
	sxtw	x11, w11
	orr	x12, xzr, #0x2
	lsl	x11, x11, x12
	add	 x9, x9, x11
	str	 w8, [x9]
// BB#3:                                // %for.inc
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #20]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #20]
	b	.LBB0_1
.LBB0_4:                                // %for.end
	movz	w8, #0xaf0
	str	w8, [sp, #16]
.LBB0_5:                                // %for.cond1
                                        // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_7 Depth 2
	ldr	w8, [sp, #16]
	cmp	 w8, #0                 // =0
	b.gt	.LBB0_6
	b	.LBB0_12
.LBB0_6:                                // %for.body3
                                        //   in Loop: Header=BB0_5 Depth=1
	movz	w8, #0
	str	w8, [sp, #8]
	ldr	w8, [sp, #16]
	str	w8, [sp, #20]
.LBB0_7:                                // %for.cond4
                                        //   Parent Loop BB0_5 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	add	x8, sp, #24             // =24
	orr	w9, wzr, #0x2
	movz	w10, #0x2710
	ldr	w11, [sp, #20]
	mov	 w12, w11
	sxtw	x12, w12
	orr	x13, xzr, #0x2
	lsl	x12, x12, x13
	add	 x12, x8, x12
	ldr	 w11, [x12]
	mul	 w10, w11, w10
	ldr	w11, [sp, #8]
	add	 w10, w11, w10
	str	w10, [sp, #8]
	ldr	w10, [sp, #20]
	mul	 w9, w9, w10
	orr	w10, wzr, #0x1
	subs	 w9, w9, w10
	str	w9, [sp, #12]
	ldr	w9, [sp, #8]
	ldr	w10, [sp, #12]
	sdiv	w11, w9, w10
	msub	w9, w11, w10, w9
	ldr	w10, [sp, #20]
	mov	 w12, w10
	sxtw	x12, w12
	orr	x13, xzr, #0x2
	lsl	x12, x12, x13
	add	 x8, x8, x12
	str	 w9, [x8]
	ldr	w9, [sp, #12]
	ldr	w10, [sp, #8]
	sdiv	w9, w10, w9
	str	w9, [sp, #8]
	ldr	w9, [sp, #20]
	movn	w10, #0
	add	 w9, w9, w10
	str	w9, [sp, #20]
	ldr	w9, [sp, #20]
	cmp	 w9, #0                 // =0
	b.eq	.LBB0_8
	b	.LBB0_9
.LBB0_8:                                // %if.then
                                        //   in Loop: Header=BB0_5 Depth=1
	b	.LBB0_10
.LBB0_9:                                // %if.end
                                        //   in Loop: Header=BB0_7 Depth=2
	ldr	w8, [sp, #20]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	b	.LBB0_7
.LBB0_10:                               // %for.end12
                                        //   in Loop: Header=BB0_5 Depth=1
	movz	w8, #0x2710
	ldr	w9, [sp, #4]
	ldr	w10, [sp, #8]
	movz	w11, #0x2710
	sdiv	w10, w10, w11
	add	 w9, w9, w10
	str	 w9, [sp]
	ldr	w9, [sp, #8]
	sdiv	w10, w9, w8
	msub	w8, w10, w8, w9
	str	w8, [sp, #4]
// BB#11:                               // %for.inc16
                                        //   in Loop: Header=BB0_5 Depth=1
	ldr	w8, [sp, #16]
	orr	w9, wzr, #0xe
	subs	 w8, w8, w9
	str	w8, [sp, #16]
	b	.LBB0_5
.LBB0_12:                               // %for.end18
	ldr	 w0, [sp]
	add	sp, sp, #2, lsl #12     // =8192
	add	sp, sp, #3040           // =3040
	ldp	x28, x27, [sp], #16
	ret
.Ltmp0:
	.size	main, .Ltmp0-main


	.ident	"clang version 3.5.0 "
