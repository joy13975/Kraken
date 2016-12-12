
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

	.text
	.file	"fac_it.c"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	orr	w8, wzr, #0x1
	str	w0, [sp, #12]
	str	w8, [sp, #8]
.LBB0_1:                                // %while.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_2
	b	.LBB0_3
.LBB0_2:                                // %while.body
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #12]
	b	.LBB0_1
.LBB0_3:                                // %while.end
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
	movz	w0, #0xa
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

	.text
	.file	"fac_rec.c"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	stur	w0, [x29, #-4]
	ldur	w0, [x29, #-4]
	cmp	 w0, #1                 // =1
	b.gt	.LBB0_1
	b	.LBB0_2
.LBB0_1:                                // %cond.true
	ldur	w8, [x29, #-4]
	ldur	w9, [x29, #-4]
	orr	w10, wzr, #0x1
	subs	 w0, w9, w10
	str	w8, [sp, #8]            // 4-byte Folded Spill
	bl	fac
	ldr	w8, [sp, #8]            // 4-byte Folded Reload
	mul	 w0, w8, w0
	str	w0, [sp, #4]            // 4-byte Folded Spill
	b	.LBB0_3
.LBB0_2:                                // %cond.false
	orr	w8, wzr, #0x1
	str	w8, [sp, #4]            // 4-byte Folded Spill
	b	.LBB0_3
.LBB0_3:                                // %cond.end
	ldr	w0, [sp, #4]            // 4-byte Folded Reload
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp0:
	.size	fac, .Ltmp0-fac

	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	movz	w0, #0xa
	movz	w8, #0
	stur	w8, [x29, #-4]
	bl	fac
	str	w0, [sp, #8]
	ldr	w0, [sp, #8]
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "

	.text
	.file	"nops.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	nop
	//NO_APP
	movz	w0, #0
	ret
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "

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
	ldr	w9, [sp, #8]
	sdiv	w0, w9, w8
	msub	w0, w0, w8, w9
	str	w0, [sp, #4]
// BB#11:                               // %for.inc14
                                        //   in Loop: Header=BB0_5 Depth=1
	ldr	w8, [sp, #16]
	orr	w9, wzr, #0xe
	subs	 w8, w8, w9
	str	w8, [sp, #16]
	b	.LBB0_5
.LBB0_12:                               // %for.end16
	movz	w0, #0
	add	sp, sp, #2, lsl #12     // =8192
	add	sp, sp, #3040           // =3040
	ldp	x28, x27, [sp], #16
	ret
.Ltmp0:
	.size	main, .Ltmp0-main


	.ident	"clang version 3.5.0 "

	.text
	.file	"qsort.c"
	.globl	swap
	.align	2
	.type	swap,@function
swap:                                   // @swap
// BB#0:                                // %entry
	sub	sp, sp, #32             // =32
	str	x0, [sp, #24]
	str	x1, [sp, #16]
	ldr	x0, [sp, #24]
	ldr	 w8, [x0]
	str	w8, [sp, #12]
	ldr	x0, [sp, #16]
	ldr	 w8, [x0]
	ldr	x0, [sp, #24]
	str	 w8, [x0]
	ldr	w8, [sp, #12]
	ldr	x0, [sp, #16]
	str	 w8, [x0]
	add	sp, sp, #32             // =32
	ret
.Ltmp1:
	.size	swap, .Ltmp1-swap

	.globl	sort
	.align	2
	.type	sort,@function
sort:                                   // @sort
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #32             // =32
	stur	x0, [x29, #-8]
	stur	w1, [x29, #-12]
	str	w2, [sp, #16]
	ldr	w1, [sp, #16]
	ldur	w2, [x29, #-12]
	orr	w8, wzr, #0x1
	add	 w8, w2, w8
	cmp	 w1, w8
	b.gt	.LBB1_1
	b	.LBB1_8
.LBB1_1:                                // %if.then
	ldur	w8, [x29, #-12]
	mov	 w9, w8
	sxtw	x9, w9
	ldur	x10, [x29, #-8]
	orr	x11, xzr, #0x2
	lsl	x9, x9, x11
	add	 x9, x10, x9
	ldr	 w8, [x9]
	str	w8, [sp, #12]
	ldur	w8, [x29, #-12]
	orr	w12, wzr, #0x1
	add	 w8, w8, w12
	str	w8, [sp, #8]
	ldr	w8, [sp, #16]
	str	w8, [sp, #4]
.LBB1_2:                                // %while.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #8]
	ldr	w9, [sp, #4]
	cmp	 w8, w9
	b.lt	.LBB1_3
	b	.LBB1_7
.LBB1_3:                                // %while.body
                                        //   in Loop: Header=BB1_2 Depth=1
	ldr	w8, [sp, #8]
	mov	 w9, w8
	sxtw	x9, w9
	ldur	x10, [x29, #-8]
	orr	x11, xzr, #0x2
	lsl	x9, x9, x11
	add	 x9, x10, x9
	ldr	 w8, [x9]
	ldr	w12, [sp, #12]
	cmp	 w8, w12
	b.le	.LBB1_4
	b	.LBB1_5
.LBB1_4:                                // %if.then6
                                        //   in Loop: Header=BB1_2 Depth=1
	ldr	w8, [sp, #8]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #8]
	b	.LBB1_6
.LBB1_5:                                // %if.else
                                        //   in Loop: Header=BB1_2 Depth=1
	ldr	w8, [sp, #8]
	mov	 w9, w8
	sxtw	x9, w9
	ldur	x10, [x29, #-8]
	orr	x11, xzr, #0x2
	lsl	x9, x9, x11
	add	 x0, x10, x9
	ldr	w8, [sp, #4]
	movn	w12, #0
	add	 w8, w8, w12
	str	w8, [sp, #4]
	mov	 w9, w8
	sxtw	x9, w9
	ldur	x10, [x29, #-8]
	orr	x11, xzr, #0x2
	lsl	x9, x9, x11
	add	 x1, x10, x9
	bl	swap
.LBB1_6:                                // %if.end
                                        //   in Loop: Header=BB1_2 Depth=1
	b	.LBB1_2
.LBB1_7:                                // %while.end
	ldr	w8, [sp, #8]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #8]
	mov	 w10, w8
	sxtw	x10, w10
	ldur	x11, [x29, #-8]
	orr	x12, xzr, #0x2
	lsl	x10, x10, x12
	add	 x0, x11, x10
	ldur	w8, [x29, #-12]
	mov	 w10, w8
	sxtw	x10, w10
	ldur	x11, [x29, #-8]
	orr	x12, xzr, #0x2
	lsl	x10, x10, x12
	add	 x1, x11, x10
	bl	swap
	ldur	x0, [x29, #-8]
	ldur	w1, [x29, #-12]
	ldr	w2, [sp, #8]
	bl	sort
	ldur	x0, [x29, #-8]
	ldr	w1, [sp, #4]
	ldr	w2, [sp, #16]
	bl	sort
.LBB1_8:                                // %if.end16
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp2:
	.size	sort, .Ltmp2-sort

	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	adrp	x8, nums1k1
	add	x0, x8, :lo12:nums1k1
	movz	w1, #0
	orr	w2, wzr, #0x400
	bl	sort
	movz	w0, #0
	ldp	x29, x30, [sp], #16
	ret
.Ltmp3:
	.size	main, .Ltmp3-main

	.type	nums1k1,@object         // @nums1k1
	.data
	.globl	nums1k1
	.align	2
nums1k1:
	.word	364                     // 0x16c
	.word	286                     // 0x11e
	.word	278                     // 0x116
	.word	283                     // 0x11b
	.word	154                     // 0x9a
	.word	477                     // 0x1dd
	.word	369                     // 0x171
	.word	480                     // 0x1e0
	.word	40                      // 0x28
	.word	382                     // 0x17e
	.word	153                     // 0x99
	.word	293                     // 0x125
	.word	488                     // 0x1e8
	.word	35                      // 0x23
	.word	225                     // 0xe1
	.word	172                     // 0xac
	.word	4                       // 0x4
	.word	443                     // 0x1bb
	.word	411                     // 0x19b
	.word	429                     // 0x1ad
	.word	131                     // 0x83
	.word	490                     // 0x1ea
	.word	91                      // 0x5b
	.word	89                      // 0x59
	.word	495                     // 0x1ef
	.word	426                     // 0x1aa
	.word	290                     // 0x122
	.word	411                     // 0x19b
	.word	423                     // 0x1a7
	.word	493                     // 0x1ed
	.word	139                     // 0x8b
	.word	414                     // 0x19e
	.word	303                     // 0x12f
	.word	485                     // 0x1e5
	.word	327                     // 0x147
	.word	44                      // 0x2c
	.word	430                     // 0x1ae
	.word	129                     // 0x81
	.word	153                     // 0x99
	.word	331                     // 0x14b
	.word	138                     // 0x8a
	.word	206                     // 0xce
	.word	284                     // 0x11c
	.word	461                     // 0x1cd
	.word	428                     // 0x1ac
	.word	473                     // 0x1d9
	.word	297                     // 0x129
	.word	90                      // 0x5a
	.word	260                     // 0x104
	.word	317                     // 0x13d
	.word	241                     // 0xf1
	.word	135                     // 0x87
	.word	297                     // 0x129
	.word	386                     // 0x182
	.word	83                      // 0x53
	.word	481                     // 0x1e1
	.word	456                     // 0x1c8
	.word	116                     // 0x74
	.word	95                      // 0x5f
	.word	47                      // 0x2f
	.word	317                     // 0x13d
	.word	31                      // 0x1f
	.word	337                     // 0x151
	.word	29                      // 0x1d
	.word	383                     // 0x17f
	.word	417                     // 0x1a1
	.word	268                     // 0x10c
	.word	134                     // 0x86
	.word	277                     // 0x115
	.word	402                     // 0x192
	.word	432                     // 0x1b0
	.word	493                     // 0x1ed
	.word	119                     // 0x77
	.word	352                     // 0x160
	.word	70                      // 0x46
	.word	459                     // 0x1cb
	.word	188                     // 0xbc
	.word	329                     // 0x149
	.word	249                     // 0xf9
	.word	287                     // 0x11f
	.word	165                     // 0xa5
	.word	384                     // 0x180
	.word	149                     // 0x95
	.word	371                     // 0x173
	.word	89                      // 0x59
	.word	285                     // 0x11d
	.word	179                     // 0xb3
	.word	133                     // 0x85
	.word	134                     // 0x86
	.word	219                     // 0xdb
	.word	20                      // 0x14
	.word	11                      // 0xb
	.word	379                     // 0x17b
	.word	295                     // 0x127
	.word	36                      // 0x24
	.word	380                     // 0x17c
	.word	158                     // 0x9e
	.word	80                      // 0x50
	.word	440                     // 0x1b8
	.word	335                     // 0x14f
	.word	47                      // 0x2f
	.word	182                     // 0xb6
	.word	415                     // 0x19f
	.word	452                     // 0x1c4
	.word	340                     // 0x154
	.word	57                      // 0x39
	.word	468                     // 0x1d4
	.word	182                     // 0xb6
	.word	249                     // 0xf9
	.word	106                     // 0x6a
	.word	259                     // 0x103
	.word	276                     // 0x114
	.word	487                     // 0x1e7
	.word	175                     // 0xaf
	.word	510                     // 0x1fe
	.word	63                      // 0x3f
	.word	6                       // 0x6
	.word	122                     // 0x7a
	.word	68                      // 0x44
	.word	34                      // 0x22
	.word	271                     // 0x10f
	.word	74                      // 0x4a
	.word	18                      // 0x12
	.word	126                     // 0x7e
	.word	331                     // 0x14b
	.word	435                     // 0x1b3
	.word	329                     // 0x149
	.word	60                      // 0x3c
	.word	193                     // 0xc1
	.word	75                      // 0x4b
	.word	94                      // 0x5e
	.word	128                     // 0x80
	.word	143                     // 0x8f
	.word	143                     // 0x8f
	.word	242                     // 0xf2
	.word	423                     // 0x1a7
	.word	360                     // 0x168
	.word	249                     // 0xf9
	.word	92                      // 0x5c
	.word	342                     // 0x156
	.word	14                      // 0xe
	.word	270                     // 0x10e
	.word	417                     // 0x1a1
	.word	110                     // 0x6e
	.word	27                      // 0x1b
	.word	160                     // 0xa0
	.word	500                     // 0x1f4
	.word	428                     // 0x1ac
	.word	146                     // 0x92
	.word	103                     // 0x67
	.word	403                     // 0x193
	.word	304                     // 0x130
	.word	362                     // 0x16a
	.word	331                     // 0x14b
	.word	35                      // 0x23
	.word	392                     // 0x188
	.word	320                     // 0x140
	.word	330                     // 0x14a
	.word	369                     // 0x171
	.word	34                      // 0x22
	.word	508                     // 0x1fc
	.word	405                     // 0x195
	.word	306                     // 0x132
	.word	338                     // 0x152
	.word	177                     // 0xb1
	.word	220                     // 0xdc
	.word	451                     // 0x1c3
	.word	369                     // 0x171
	.word	278                     // 0x116
	.word	37                      // 0x25
	.word	151                     // 0x97
	.word	378                     // 0x17a
	.word	468                     // 0x1d4
	.word	486                     // 0x1e6
	.word	85                      // 0x55
	.word	206                     // 0xce
	.word	258                     // 0x102
	.word	169                     // 0xa9
	.word	496                     // 0x1f0
	.word	505                     // 0x1f9
	.word	99                      // 0x63
	.word	216                     // 0xd8
	.word	367                     // 0x16f
	.word	99                      // 0x63
	.word	455                     // 0x1c7
	.word	301                     // 0x12d
	.word	386                     // 0x182
	.word	447                     // 0x1bf
	.word	354                     // 0x162
	.word	430                     // 0x1ae
	.word	6                       // 0x6
	.word	266                     // 0x10a
	.word	204                     // 0xcc
	.word	59                      // 0x3b
	.word	276                     // 0x114
	.word	11                      // 0xb
	.word	148                     // 0x94
	.word	506                     // 0x1fa
	.word	486                     // 0x1e6
	.word	459                     // 0x1cb
	.word	391                     // 0x187
	.word	36                      // 0x24
	.word	428                     // 0x1ac
	.word	54                      // 0x36
	.word	53                      // 0x35
	.word	453                     // 0x1c5
	.word	221                     // 0xdd
	.word	503                     // 0x1f7
	.word	399                     // 0x18f
	.word	330                     // 0x14a
	.word	347                     // 0x15b
	.word	487                     // 0x1e7
	.word	1                       // 0x1
	.word	278                     // 0x116
	.word	155                     // 0x9b
	.word	221                     // 0xdd
	.word	278                     // 0x116
	.word	328                     // 0x148
	.word	371                     // 0x173
	.word	150                     // 0x96
	.word	159                     // 0x9f
	.word	228                     // 0xe4
	.word	406                     // 0x196
	.word	101                     // 0x65
	.word	126                     // 0x7e
	.word	215                     // 0xd7
	.word	128                     // 0x80
	.word	26                      // 0x1a
	.word	487                     // 0x1e7
	.word	339                     // 0x153
	.word	146                     // 0x92
	.word	24                      // 0x18
	.word	402                     // 0x192
	.word	97                      // 0x61
	.word	281                     // 0x119
	.word	320                     // 0x140
	.word	214                     // 0xd6
	.word	151                     // 0x97
	.word	271                     // 0x10f
	.word	363                     // 0x16b
	.word	300                     // 0x12c
	.word	501                     // 0x1f5
	.word	274                     // 0x112
	.word	41                      // 0x29
	.word	112                     // 0x70
	.word	306                     // 0x132
	.word	507                     // 0x1fb
	.word	293                     // 0x125
	.word	342                     // 0x156
	.word	282                     // 0x11a
	.word	173                     // 0xad
	.word	477                     // 0x1dd
	.word	317                     // 0x13d
	.word	176                     // 0xb0
	.word	271                     // 0x10f
	.word	327                     // 0x147
	.word	436                     // 0x1b4
	.word	117                     // 0x75
	.word	199                     // 0xc7
	.word	276                     // 0x114
	.word	414                     // 0x19e
	.word	485                     // 0x1e5
	.word	273                     // 0x111
	.word	76                      // 0x4c
	.word	307                     // 0x133
	.word	267                     // 0x10b
	.word	215                     // 0xd7
	.word	327                     // 0x147
	.word	379                     // 0x17b
	.word	315                     // 0x13b
	.word	431                     // 0x1af
	.word	313                     // 0x139
	.word	377                     // 0x179
	.word	261                     // 0x105
	.word	117                     // 0x75
	.word	195                     // 0xc3
	.word	245                     // 0xf5
	.word	153                     // 0x99
	.word	54                      // 0x36
	.word	427                     // 0x1ab
	.word	340                     // 0x154
	.word	485                     // 0x1e5
	.word	414                     // 0x19e
	.word	318                     // 0x13e
	.word	213                     // 0xd5
	.word	491                     // 0x1eb
	.word	159                     // 0x9f
	.word	511                     // 0x1ff
	.word	128                     // 0x80
	.word	312                     // 0x138
	.word	463                     // 0x1cf
	.word	297                     // 0x129
	.word	35                      // 0x23
	.word	273                     // 0x111
	.word	31                      // 0x1f
	.word	272                     // 0x110
	.word	239                     // 0xef
	.word	101                     // 0x65
	.word	235                     // 0xeb
	.word	234                     // 0xea
	.word	238                     // 0xee
	.word	308                     // 0x134
	.word	325                     // 0x145
	.word	397                     // 0x18d
	.word	155                     // 0x9b
	.word	163                     // 0xa3
	.word	146                     // 0x92
	.word	499                     // 0x1f3
	.word	273                     // 0x111
	.word	28                      // 0x1c
	.word	280                     // 0x118
	.word	374                     // 0x176
	.word	32                      // 0x20
	.word	400                     // 0x190
	.word	314                     // 0x13a
	.word	21                      // 0x15
	.word	340                     // 0x154
	.word	7                       // 0x7
	.word	231                     // 0xe7
	.word	390                     // 0x186
	.word	258                     // 0x102
	.word	431                     // 0x1af
	.word	192                     // 0xc0
	.word	469                     // 0x1d5
	.word	14                      // 0xe
	.word	293                     // 0x125
	.word	418                     // 0x1a2
	.word	140                     // 0x8c
	.word	481                     // 0x1e1
	.word	302                     // 0x12e
	.word	440                     // 0x1b8
	.word	68                      // 0x44
	.word	303                     // 0x12f
	.word	499                     // 0x1f3
	.word	387                     // 0x183
	.word	169                     // 0xa9
	.word	4                       // 0x4
	.word	166                     // 0xa6
	.word	363                     // 0x16b
	.word	388                     // 0x184
	.word	160                     // 0xa0
	.word	428                     // 0x1ac
	.word	469                     // 0x1d5
	.word	361                     // 0x169
	.word	66                      // 0x42
	.word	458                     // 0x1ca
	.word	92                      // 0x5c
	.word	315                     // 0x13b
	.word	90                      // 0x5a
	.word	331                     // 0x14b
	.word	422                     // 0x1a6
	.word	249                     // 0xf9
	.word	344                     // 0x158
	.word	496                     // 0x1f0
	.word	151                     // 0x97
	.word	295                     // 0x127
	.word	167                     // 0xa7
	.word	297                     // 0x129
	.word	430                     // 0x1ae
	.word	309                     // 0x135
	.word	391                     // 0x187
	.word	158                     // 0x9e
	.word	185                     // 0xb9
	.word	91                      // 0x5b
	.word	440                     // 0x1b8
	.word	275                     // 0x113
	.word	477                     // 0x1dd
	.word	362                     // 0x16a
	.word	283                     // 0x11b
	.word	88                      // 0x58
	.word	487                     // 0x1e7
	.word	341                     // 0x155
	.word	423                     // 0x1a7
	.word	96                      // 0x60
	.word	391                     // 0x187
	.word	419                     // 0x1a3
	.word	106                     // 0x6a
	.word	110                     // 0x6e
	.word	143                     // 0x8f
	.word	319                     // 0x13f
	.word	197                     // 0xc5
	.word	330                     // 0x14a
	.word	212                     // 0xd4
	.word	403                     // 0x193
	.word	505                     // 0x1f9
	.word	1                       // 0x1
	.word	147                     // 0x93
	.word	223                     // 0xdf
	.word	343                     // 0x157
	.word	41                      // 0x29
	.word	24                      // 0x18
	.word	357                     // 0x165
	.word	457                     // 0x1c9
	.word	90                      // 0x5a
	.word	318                     // 0x13e
	.word	21                      // 0x15
	.word	263                     // 0x107
	.word	371                     // 0x173
	.word	434                     // 0x1b2
	.word	82                      // 0x52
	.word	242                     // 0xf2
	.word	7                       // 0x7
	.word	394                     // 0x18a
	.word	245                     // 0xf5
	.word	329                     // 0x149
	.word	352                     // 0x160
	.word	290                     // 0x122
	.word	241                     // 0xf1
	.word	134                     // 0x86
	.word	35                      // 0x23
	.word	143                     // 0x8f
	.word	429                     // 0x1ad
	.word	132                     // 0x84
	.word	328                     // 0x148
	.word	22                      // 0x16
	.word	298                     // 0x12a
	.word	424                     // 0x1a8
	.word	258                     // 0x102
	.word	219                     // 0xdb
	.word	355                     // 0x163
	.word	273                     // 0x111
	.word	101                     // 0x65
	.word	119                     // 0x77
	.word	55                      // 0x37
	.word	264                     // 0x108
	.word	188                     // 0xbc
	.word	363                     // 0x16b
	.word	413                     // 0x19d
	.word	263                     // 0x107
	.word	11                      // 0xb
	.word	392                     // 0x188
	.word	285                     // 0x11d
	.word	433                     // 0x1b1
	.word	322                     // 0x142
	.word	443                     // 0x1bb
	.word	502                     // 0x1f6
	.word	153                     // 0x99
	.word	304                     // 0x130
	.word	293                     // 0x125
	.word	42                      // 0x2a
	.word	273                     // 0x111
	.word	450                     // 0x1c2
	.word	400                     // 0x190
	.word	147                     // 0x93
	.word	466                     // 0x1d2
	.word	61                      // 0x3d
	.word	311                     // 0x137
	.word	204                     // 0xcc
	.word	107                     // 0x6b
	.word	233                     // 0xe9
	.word	206                     // 0xce
	.word	373                     // 0x175
	.word	430                     // 0x1ae
	.word	374                     // 0x176
	.word	242                     // 0xf2
	.word	498                     // 0x1f2
	.word	301                     // 0x12d
	.word	391                     // 0x187
	.word	247                     // 0xf7
	.word	120                     // 0x78
	.word	286                     // 0x11e
	.word	261                     // 0x105
	.word	299                     // 0x12b
	.word	395                     // 0x18b
	.word	117                     // 0x75
	.word	457                     // 0x1c9
	.word	428                     // 0x1ac
	.word	386                     // 0x182
	.word	492                     // 0x1ec
	.word	213                     // 0xd5
	.word	28                      // 0x1c
	.word	231                     // 0xe7
	.word	80                      // 0x50
	.word	181                     // 0xb5
	.word	30                      // 0x1e
	.word	498                     // 0x1f2
	.word	197                     // 0xc5
	.word	71                      // 0x47
	.word	301                     // 0x12d
	.word	144                     // 0x90
	.word	27                      // 0x1b
	.word	209                     // 0xd1
	.word	124                     // 0x7c
	.word	82                      // 0x52
	.word	397                     // 0x18d
	.word	22                      // 0x16
	.word	358                     // 0x166
	.word	296                     // 0x128
	.word	341                     // 0x155
	.word	468                     // 0x1d4
	.word	184                     // 0xb8
	.word	140                     // 0x8c
	.word	265                     // 0x109
	.word	448                     // 0x1c0
	.word	408                     // 0x198
	.word	185                     // 0xb9
	.word	396                     // 0x18c
	.word	193                     // 0xc1
	.word	444                     // 0x1bc
	.word	439                     // 0x1b7
	.word	456                     // 0x1c8
	.word	152                     // 0x98
	.word	422                     // 0x1a6
	.word	32                      // 0x20
	.word	505                     // 0x1f9
	.word	46                      // 0x2e
	.word	351                     // 0x15f
	.word	67                      // 0x43
	.word	89                      // 0x59
	.word	136                     // 0x88
	.word	261                     // 0x105
	.word	64                      // 0x40
	.word	469                     // 0x1d5
	.word	174                     // 0xae
	.word	252                     // 0xfc
	.word	431                     // 0x1af
	.word	504                     // 0x1f8
	.word	486                     // 0x1e6
	.word	260                     // 0x104
	.word	7                       // 0x7
	.word	283                     // 0x11b
	.word	313                     // 0x139
	.word	201                     // 0xc9
	.word	226                     // 0xe2
	.word	183                     // 0xb7
	.word	396                     // 0x18c
	.word	212                     // 0xd4
	.word	340                     // 0x154
	.word	342                     // 0x156
	.word	178                     // 0xb2
	.word	255                     // 0xff
	.word	78                      // 0x4e
	.word	25                      // 0x19
	.word	18                      // 0x12
	.word	250                     // 0xfa
	.word	57                      // 0x39
	.word	67                      // 0x43
	.word	96                      // 0x60
	.word	88                      // 0x58
	.word	477                     // 0x1dd
	.word	16                      // 0x10
	.word	379                     // 0x17b
	.word	476                     // 0x1dc
	.word	241                     // 0xf1
	.word	428                     // 0x1ac
	.word	124                     // 0x7c
	.word	220                     // 0xdc
	.word	6                       // 0x6
	.word	230                     // 0xe6
	.word	34                      // 0x22
	.word	226                     // 0xe2
	.word	409                     // 0x199
	.word	304                     // 0x130
	.word	501                     // 0x1f5
	.word	99                      // 0x63
	.word	265                     // 0x109
	.word	257                     // 0x101
	.word	351                     // 0x15f
	.word	237                     // 0xed
	.word	326                     // 0x146
	.word	137                     // 0x89
	.word	312                     // 0x138
	.word	272                     // 0x110
	.word	471                     // 0x1d7
	.word	218                     // 0xda
	.word	154                     // 0x9a
	.word	199                     // 0xc7
	.word	212                     // 0xd4
	.word	141                     // 0x8d
	.word	93                      // 0x5d
	.word	433                     // 0x1b1
	.word	210                     // 0xd2
	.word	370                     // 0x172
	.word	506                     // 0x1fa
	.word	117                     // 0x75
	.word	499                     // 0x1f3
	.word	328                     // 0x148
	.word	357                     // 0x165
	.word	141                     // 0x8d
	.word	27                      // 0x1b
	.word	144                     // 0x90
	.word	162                     // 0xa2
	.word	54                      // 0x36
	.word	435                     // 0x1b3
	.word	361                     // 0x169
	.word	447                     // 0x1bf
	.word	478                     // 0x1de
	.word	400                     // 0x190
	.word	434                     // 0x1b2
	.word	2                       // 0x2
	.word	77                      // 0x4d
	.word	401                     // 0x191
	.word	79                      // 0x4f
	.word	313                     // 0x139
	.word	454                     // 0x1c6
	.word	177                     // 0xb1
	.word	164                     // 0xa4
	.word	415                     // 0x19f
	.word	100                     // 0x64
	.word	87                      // 0x57
	.word	36                      // 0x24
	.word	101                     // 0x65
	.word	190                     // 0xbe
	.word	294                     // 0x126
	.word	378                     // 0x17a
	.word	471                     // 0x1d7
	.word	230                     // 0xe6
	.word	49                      // 0x31
	.word	231                     // 0xe7
	.word	56                      // 0x38
	.word	238                     // 0xee
	.word	45                      // 0x2d
	.word	1                       // 0x1
	.word	73                      // 0x49
	.word	372                     // 0x174
	.word	322                     // 0x142
	.word	229                     // 0xe5
	.word	336                     // 0x150
	.word	338                     // 0x152
	.word	53                      // 0x35
	.word	144                     // 0x90
	.word	491                     // 0x1eb
	.word	233                     // 0xe9
	.word	440                     // 0x1b8
	.word	200                     // 0xc8
	.word	35                      // 0x23
	.word	74                      // 0x4a
	.word	108                     // 0x6c
	.word	106                     // 0x6a
	.word	448                     // 0x1c0
	.word	313                     // 0x139
	.word	324                     // 0x144
	.word	126                     // 0x7e
	.word	157                     // 0x9d
	.word	283                     // 0x11b
	.word	405                     // 0x195
	.word	305                     // 0x131
	.word	237                     // 0xed
	.word	177                     // 0xb1
	.word	354                     // 0x162
	.word	386                     // 0x182
	.word	318                     // 0x13e
	.word	60                      // 0x3c
	.word	145                     // 0x91
	.word	299                     // 0x12b
	.word	468                     // 0x1d4
	.word	23                      // 0x17
	.word	314                     // 0x13a
	.word	6                       // 0x6
	.word	145                     // 0x91
	.word	103                     // 0x67
	.word	482                     // 0x1e2
	.word	129                     // 0x81
	.word	98                      // 0x62
	.word	220                     // 0xdc
	.word	67                      // 0x43
	.word	114                     // 0x72
	.word	211                     // 0xd3
	.word	265                     // 0x109
	.word	83                      // 0x53
	.word	398                     // 0x18e
	.word	168                     // 0xa8
	.word	92                      // 0x5c
	.word	200                     // 0xc8
	.word	55                      // 0x37
	.word	71                      // 0x47
	.word	39                      // 0x27
	.word	459                     // 0x1cb
	.word	146                     // 0x92
	.word	252                     // 0xfc
	.word	277                     // 0x115
	.word	376                     // 0x178
	.word	240                     // 0xf0
	.word	232                     // 0xe8
	.word	475                     // 0x1db
	.word	297                     // 0x129
	.word	375                     // 0x177
	.word	385                     // 0x181
	.word	253                     // 0xfd
	.word	388                     // 0x184
	.word	299                     // 0x12b
	.word	174                     // 0xae
	.word	216                     // 0xd8
	.word	243                     // 0xf3
	.word	42                      // 0x2a
	.word	144                     // 0x90
	.word	61                      // 0x3d
	.word	336                     // 0x150
	.word	413                     // 0x19d
	.word	338                     // 0x152
	.word	138                     // 0x8a
	.word	133                     // 0x85
	.word	302                     // 0x12e
	.word	202                     // 0xca
	.word	138                     // 0x8a
	.word	78                      // 0x4e
	.word	167                     // 0xa7
	.word	101                     // 0x65
	.word	486                     // 0x1e6
	.word	131                     // 0x83
	.word	476                     // 0x1dc
	.word	282                     // 0x11a
	.word	29                      // 0x1d
	.word	402                     // 0x192
	.word	46                      // 0x2e
	.word	57                      // 0x39
	.word	510                     // 0x1fe
	.word	418                     // 0x1a2
	.word	432                     // 0x1b0
	.word	78                      // 0x4e
	.word	214                     // 0xd6
	.word	224                     // 0xe0
	.word	243                     // 0xf3
	.word	121                     // 0x79
	.word	78                      // 0x4e
	.word	378                     // 0x17a
	.word	259                     // 0x103
	.word	314                     // 0x13a
	.word	246                     // 0xf6
	.word	291                     // 0x123
	.word	346                     // 0x15a
	.word	239                     // 0xef
	.word	5                       // 0x5
	.word	162                     // 0xa2
	.word	288                     // 0x120
	.word	42                      // 0x2a
	.word	32                      // 0x20
	.word	286                     // 0x11e
	.word	267                     // 0x10b
	.word	67                      // 0x43
	.word	103                     // 0x67
	.word	244                     // 0xf4
	.word	476                     // 0x1dc
	.word	172                     // 0xac
	.word	288                     // 0x120
	.word	124                     // 0x7c
	.word	511                     // 0x1ff
	.word	226                     // 0xe2
	.word	63                      // 0x3f
	.word	103                     // 0x67
	.word	485                     // 0x1e5
	.word	488                     // 0x1e8
	.word	153                     // 0x99
	.word	453                     // 0x1c5
	.word	422                     // 0x1a6
	.word	461                     // 0x1cd
	.word	240                     // 0xf0
	.word	169                     // 0xa9
	.word	312                     // 0x138
	.word	290                     // 0x122
	.word	300                     // 0x12c
	.word	99                      // 0x63
	.word	276                     // 0x114
	.word	102                     // 0x66
	.word	500                     // 0x1f4
	.word	300                     // 0x12c
	.word	386                     // 0x182
	.word	247                     // 0xf7
	.word	148                     // 0x94
	.word	120                     // 0x78
	.word	497                     // 0x1f1
	.word	17                      // 0x11
	.word	469                     // 0x1d5
	.word	441                     // 0x1b9
	.word	116                     // 0x74
	.word	357                     // 0x165
	.word	98                      // 0x62
	.word	31                      // 0x1f
	.word	162                     // 0xa2
	.word	213                     // 0xd5
	.word	312                     // 0x138
	.word	100                     // 0x64
	.word	280                     // 0x118
	.word	89                      // 0x59
	.word	293                     // 0x125
	.word	324                     // 0x144
	.word	284                     // 0x11c
	.word	205                     // 0xcd
	.word	245                     // 0xf5
	.word	317                     // 0x13d
	.word	279                     // 0x117
	.word	95                      // 0x5f
	.word	58                      // 0x3a
	.word	3                       // 0x3
	.word	356                     // 0x164
	.word	36                      // 0x24
	.word	279                     // 0x117
	.word	499                     // 0x1f3
	.word	104                     // 0x68
	.word	240                     // 0xf0
	.word	55                      // 0x37
	.word	61                      // 0x3d
	.word	447                     // 0x1bf
	.word	441                     // 0x1b9
	.word	372                     // 0x174
	.word	176                     // 0xb0
	.word	31                      // 0x1f
	.word	165                     // 0xa5
	.word	137                     // 0x89
	.word	498                     // 0x1f2
	.word	417                     // 0x1a1
	.word	54                      // 0x36
	.word	282                     // 0x11a
	.word	288                     // 0x120
	.word	451                     // 0x1c3
	.word	367                     // 0x16f
	.word	237                     // 0xed
	.word	23                      // 0x17
	.word	483                     // 0x1e3
	.word	164                     // 0xa4
	.word	71                      // 0x47
	.word	430                     // 0x1ae
	.word	292                     // 0x124
	.word	136                     // 0x88
	.word	208                     // 0xd0
	.word	415                     // 0x19f
	.word	472                     // 0x1d8
	.word	376                     // 0x178
	.word	327                     // 0x147
	.word	195                     // 0xc3
	.word	219                     // 0xdb
	.word	419                     // 0x1a3
	.word	312                     // 0x138
	.word	14                      // 0xe
	.word	198                     // 0xc6
	.word	347                     // 0x15b
	.word	219                     // 0xdb
	.word	358                     // 0x166
	.word	401                     // 0x191
	.word	159                     // 0x9f
	.word	216                     // 0xd8
	.word	94                      // 0x5e
	.word	406                     // 0x196
	.word	349                     // 0x15d
	.word	6                       // 0x6
	.word	340                     // 0x154
	.word	206                     // 0xce
	.word	35                      // 0x23
	.word	456                     // 0x1c8
	.word	363                     // 0x16b
	.word	12                      // 0xc
	.word	37                      // 0x25
	.word	392                     // 0x188
	.word	178                     // 0xb2
	.word	250                     // 0xfa
	.word	142                     // 0x8e
	.word	329                     // 0x149
	.word	389                     // 0x185
	.word	245                     // 0xf5
	.word	327                     // 0x147
	.word	262                     // 0x106
	.word	81                      // 0x51
	.word	78                      // 0x4e
	.word	62                      // 0x3e
	.word	508                     // 0x1fc
	.word	512                     // 0x200
	.word	500                     // 0x1f4
	.word	122                     // 0x7a
	.word	206                     // 0xce
	.word	77                      // 0x4d
	.word	249                     // 0xf9
	.word	377                     // 0x179
	.word	320                     // 0x140
	.word	209                     // 0xd1
	.word	123                     // 0x7b
	.word	416                     // 0x1a0
	.word	237                     // 0xed
	.word	253                     // 0xfd
	.word	185                     // 0xb9
	.word	154                     // 0x9a
	.word	184                     // 0xb8
	.word	353                     // 0x161
	.word	405                     // 0x195
	.word	143                     // 0x8f
	.word	323                     // 0x143
	.word	132                     // 0x84
	.word	317                     // 0x13d
	.word	155                     // 0x9b
	.word	142                     // 0x8e
	.word	250                     // 0xfa
	.word	477                     // 0x1dd
	.word	250                     // 0xfa
	.word	307                     // 0x133
	.word	417                     // 0x1a1
	.word	326                     // 0x146
	.word	190                     // 0xbe
	.word	397                     // 0x18d
	.word	71                      // 0x47
	.word	73                      // 0x49
	.word	326                     // 0x146
	.word	45                      // 0x2d
	.word	192                     // 0xc0
	.word	510                     // 0x1fe
	.word	376                     // 0x178
	.word	473                     // 0x1d9
	.word	61                      // 0x3d
	.word	20                      // 0x14
	.word	286                     // 0x11e
	.word	482                     // 0x1e2
	.word	178                     // 0xb2
	.word	507                     // 0x1fb
	.word	301                     // 0x12d
	.word	306                     // 0x132
	.word	319                     // 0x13f
	.word	90                      // 0x5a
	.word	197                     // 0xc5
	.word	334                     // 0x14e
	.word	119                     // 0x77
	.word	402                     // 0x192
	.word	66                      // 0x42
	.word	323                     // 0x143
	.word	445                     // 0x1bd
	.word	506                     // 0x1fa
	.word	473                     // 0x1d9
	.word	309                     // 0x135
	.word	236                     // 0xec
	.word	404                     // 0x194
	.word	245                     // 0xf5
	.word	354                     // 0x162
	.word	325                     // 0x145
	.word	188                     // 0xbc
	.word	387                     // 0x183
	.word	240                     // 0xf0
	.word	86                      // 0x56
	.word	84                      // 0x54
	.word	223                     // 0xdf
	.word	186                     // 0xba
	.word	14                      // 0xe
	.word	478                     // 0x1de
	.word	251                     // 0xfb
	.word	382                     // 0x17e
	.word	444                     // 0x1bc
	.word	151                     // 0x97
	.word	417                     // 0x1a1
	.word	163                     // 0xa3
	.word	490                     // 0x1ea
	.word	323                     // 0x143
	.word	253                     // 0xfd
	.word	368                     // 0x170
	.word	187                     // 0xbb
	.word	271                     // 0x10f
	.word	445                     // 0x1bd
	.word	473                     // 0x1d9
	.word	19                      // 0x13
	.word	222                     // 0xde
	.word	290                     // 0x122
	.word	350                     // 0x15e
	.word	285                     // 0x11d
	.word	372                     // 0x174
	.word	421                     // 0x1a5
	.word	30                      // 0x1e
	.word	380                     // 0x17c
	.word	250                     // 0xfa
	.word	75                      // 0x4b
	.word	476                     // 0x1dc
	.word	168                     // 0xa8
	.word	245                     // 0xf5
	.word	390                     // 0x186
	.word	86                      // 0x56
	.word	20                      // 0x14
	.word	363                     // 0x16b
	.word	165                     // 0xa5
	.word	151                     // 0x97
	.word	423                     // 0x1a7
	.word	117                     // 0x75
	.word	163                     // 0xa3
	.word	300                     // 0x12c
	.word	82                      // 0x52
	.word	173                     // 0xad
	.word	237                     // 0xed
	.word	87                      // 0x57
	.word	208                     // 0xd0
	.word	282                     // 0x11a
	.word	87                      // 0x57
	.word	181                     // 0xb5
	.word	481                     // 0x1e1
	.word	187                     // 0xbb
	.word	112                     // 0x70
	.word	169                     // 0xa9
	.word	69                      // 0x45
	.word	56                      // 0x38
	.word	131                     // 0x83
	.word	257                     // 0x101
	.word	24                      // 0x18
	.word	238                     // 0xee
	.word	78                      // 0x4e
	.word	470                     // 0x1d6
	.word	154                     // 0x9a
	.word	310                     // 0x136
	.word	197                     // 0xc5
	.word	481                     // 0x1e1
	.word	398                     // 0x18e
	.word	167                     // 0xa7
	.word	386                     // 0x182
	.word	366                     // 0x16e
	.word	49                      // 0x31
	.word	337                     // 0x151
	.word	66                      // 0x42
	.word	119                     // 0x77
	.word	490                     // 0x1ea
	.word	203                     // 0xcb
	.word	39                      // 0x27
	.word	317                     // 0x13d
	.word	97                      // 0x61
	.word	33                      // 0x21
	.word	414                     // 0x19e
	.word	464                     // 0x1d0
	.word	210                     // 0xd2
	.word	336                     // 0x150
	.word	489                     // 0x1e9
	.word	335                     // 0x14f
	.word	378                     // 0x17a
	.word	116                     // 0x74
	.word	363                     // 0x16b
	.word	328                     // 0x148
	.word	191                     // 0xbf
	.word	101                     // 0x65
	.word	407                     // 0x197
	.word	408                     // 0x198
	.word	259                     // 0x103
	.word	483                     // 0x1e3
	.word	51                      // 0x33
	.word	377                     // 0x179
	.word	223                     // 0xdf
	.size	nums1k1, 4096

	.type	nums1k2,@object         // @nums1k2
	.globl	nums1k2
	.align	2
nums1k2:
	.word	348                     // 0x15c
	.word	348                     // 0x15c
	.word	4                       // 0x4
	.word	379                     // 0x17b
	.word	124                     // 0x7c
	.word	157                     // 0x9d
	.word	325                     // 0x145
	.word	427                     // 0x1ab
	.word	423                     // 0x1a7
	.word	337                     // 0x151
	.word	460                     // 0x1cc
	.word	131                     // 0x83
	.word	240                     // 0xf0
	.word	232                     // 0xe8
	.word	165                     // 0xa5
	.word	278                     // 0x116
	.word	158                     // 0x9e
	.word	490                     // 0x1ea
	.word	101                     // 0x65
	.word	250                     // 0xfa
	.word	109                     // 0x6d
	.word	506                     // 0x1fa
	.word	332                     // 0x14c
	.word	245                     // 0xf5
	.word	462                     // 0x1ce
	.word	253                     // 0xfd
	.word	165                     // 0xa5
	.word	254                     // 0xfe
	.word	321                     // 0x141
	.word	390                     // 0x186
	.word	107                     // 0x6b
	.word	444                     // 0x1bc
	.word	498                     // 0x1f2
	.word	8                       // 0x8
	.word	360                     // 0x168
	.word	220                     // 0xdc
	.word	79                      // 0x4f
	.word	141                     // 0x8d
	.word	474                     // 0x1da
	.word	171                     // 0xab
	.word	271                     // 0x10f
	.word	243                     // 0xf3
	.word	96                      // 0x60
	.word	348                     // 0x15c
	.word	297                     // 0x129
	.word	181                     // 0xb5
	.word	466                     // 0x1d2
	.word	65                      // 0x41
	.word	100                     // 0x64
	.word	174                     // 0xae
	.word	360                     // 0x168
	.word	453                     // 0x1c5
	.word	207                     // 0xcf
	.word	414                     // 0x19e
	.word	190                     // 0xbe
	.word	134                     // 0x86
	.word	92                      // 0x5c
	.word	279                     // 0x117
	.word	464                     // 0x1d0
	.word	503                     // 0x1f7
	.word	158                     // 0x9e
	.word	159                     // 0x9f
	.word	98                      // 0x62
	.word	158                     // 0x9e
	.word	302                     // 0x12e
	.word	25                      // 0x19
	.word	188                     // 0xbc
	.word	337                     // 0x151
	.word	8                       // 0x8
	.word	98                      // 0x62
	.word	393                     // 0x189
	.word	90                      // 0x5a
	.word	396                     // 0x18c
	.word	504                     // 0x1f8
	.word	205                     // 0xcd
	.word	425                     // 0x1a9
	.word	175                     // 0xaf
	.word	439                     // 0x1b7
	.word	58                      // 0x3a
	.word	343                     // 0x157
	.word	247                     // 0xf7
	.word	113                     // 0x71
	.word	249                     // 0xf9
	.word	150                     // 0x96
	.word	348                     // 0x15c
	.word	24                      // 0x18
	.word	174                     // 0xae
	.word	376                     // 0x178
	.word	331                     // 0x14b
	.word	302                     // 0x12e
	.word	280                     // 0x118
	.word	251                     // 0xfb
	.word	510                     // 0x1fe
	.word	113                     // 0x71
	.word	241                     // 0xf1
	.word	507                     // 0x1fb
	.word	9                       // 0x9
	.word	389                     // 0x185
	.word	172                     // 0xac
	.word	214                     // 0xd6
	.word	253                     // 0xfd
	.word	497                     // 0x1f1
	.word	401                     // 0x191
	.word	243                     // 0xf3
	.word	7                       // 0x7
	.word	80                      // 0x50
	.word	499                     // 0x1f3
	.word	133                     // 0x85
	.word	208                     // 0xd0
	.word	477                     // 0x1dd
	.word	456                     // 0x1c8
	.word	376                     // 0x178
	.word	350                     // 0x15e
	.word	53                      // 0x35
	.word	466                     // 0x1d2
	.word	84                      // 0x54
	.word	261                     // 0x105
	.word	193                     // 0xc1
	.word	215                     // 0xd7
	.word	9                       // 0x9
	.word	509                     // 0x1fd
	.word	462                     // 0x1ce
	.word	378                     // 0x17a
	.word	363                     // 0x16b
	.word	154                     // 0x9a
	.word	482                     // 0x1e2
	.word	72                      // 0x48
	.word	266                     // 0x10a
	.word	465                     // 0x1d1
	.word	73                      // 0x49
	.word	460                     // 0x1cc
	.word	406                     // 0x196
	.word	454                     // 0x1c6
	.word	478                     // 0x1de
	.word	447                     // 0x1bf
	.word	94                      // 0x5e
	.word	283                     // 0x11b
	.word	107                     // 0x6b
	.word	483                     // 0x1e3
	.word	404                     // 0x194
	.word	48                      // 0x30
	.word	297                     // 0x129
	.word	207                     // 0xcf
	.word	47                      // 0x2f
	.word	435                     // 0x1b3
	.word	56                      // 0x38
	.word	416                     // 0x1a0
	.word	362                     // 0x16a
	.word	181                     // 0xb5
	.word	327                     // 0x147
	.word	36                      // 0x24
	.word	231                     // 0xe7
	.word	273                     // 0x111
	.word	48                      // 0x30
	.word	123                     // 0x7b
	.word	455                     // 0x1c7
	.word	319                     // 0x13f
	.word	358                     // 0x166
	.word	21                      // 0x15
	.word	153                     // 0x99
	.word	161                     // 0xa1
	.word	178                     // 0xb2
	.word	382                     // 0x17e
	.word	415                     // 0x19f
	.word	362                     // 0x16a
	.word	2                       // 0x2
	.word	116                     // 0x74
	.word	420                     // 0x1a4
	.word	197                     // 0xc5
	.word	60                      // 0x3c
	.word	205                     // 0xcd
	.word	16                      // 0x10
	.word	506                     // 0x1fa
	.word	109                     // 0x6d
	.word	60                      // 0x3c
	.word	135                     // 0x87
	.word	491                     // 0x1eb
	.word	414                     // 0x19e
	.word	150                     // 0x96
	.word	41                      // 0x29
	.word	342                     // 0x156
	.word	126                     // 0x7e
	.word	188                     // 0xbc
	.word	172                     // 0xac
	.word	348                     // 0x15c
	.word	383                     // 0x17f
	.word	475                     // 0x1db
	.word	454                     // 0x1c6
	.word	236                     // 0xec
	.word	461                     // 0x1cd
	.word	370                     // 0x172
	.word	113                     // 0x71
	.word	158                     // 0x9e
	.word	145                     // 0x91
	.word	157                     // 0x9d
	.word	17                      // 0x11
	.word	90                      // 0x5a
	.word	479                     // 0x1df
	.word	497                     // 0x1f1
	.word	384                     // 0x180
	.word	18                      // 0x12
	.word	92                      // 0x5c
	.word	471                     // 0x1d7
	.word	300                     // 0x12c
	.word	137                     // 0x89
	.word	230                     // 0xe6
	.word	105                     // 0x69
	.word	68                      // 0x44
	.word	128                     // 0x80
	.word	487                     // 0x1e7
	.word	125                     // 0x7d
	.word	9                       // 0x9
	.word	158                     // 0x9e
	.word	105                     // 0x69
	.word	4                       // 0x4
	.word	374                     // 0x176
	.word	202                     // 0xca
	.word	315                     // 0x13b
	.word	295                     // 0x127
	.word	11                      // 0xb
	.word	512                     // 0x200
	.word	247                     // 0xf7
	.word	276                     // 0x114
	.word	55                      // 0x37
	.word	52                      // 0x34
	.word	507                     // 0x1fb
	.word	390                     // 0x186
	.word	74                      // 0x4a
	.word	470                     // 0x1d6
	.word	16                      // 0x10
	.word	332                     // 0x14c
	.word	235                     // 0xeb
	.word	455                     // 0x1c7
	.word	374                     // 0x176
	.word	175                     // 0xaf
	.word	361                     // 0x169
	.word	414                     // 0x19e
	.word	143                     // 0x8f
	.word	481                     // 0x1e1
	.word	193                     // 0xc1
	.word	409                     // 0x199
	.word	212                     // 0xd4
	.word	361                     // 0x169
	.word	179                     // 0xb3
	.word	189                     // 0xbd
	.word	243                     // 0xf3
	.word	330                     // 0x14a
	.word	356                     // 0x164
	.word	503                     // 0x1f7
	.word	385                     // 0x181
	.word	397                     // 0x18d
	.word	110                     // 0x6e
	.word	486                     // 0x1e6
	.word	157                     // 0x9d
	.word	169                     // 0xa9
	.word	31                      // 0x1f
	.word	276                     // 0x114
	.word	455                     // 0x1c7
	.word	499                     // 0x1f3
	.word	161                     // 0xa1
	.word	43                      // 0x2b
	.word	315                     // 0x13b
	.word	264                     // 0x108
	.word	441                     // 0x1b9
	.word	242                     // 0xf2
	.word	145                     // 0x91
	.word	204                     // 0xcc
	.word	181                     // 0xb5
	.word	206                     // 0xce
	.word	83                      // 0x53
	.word	354                     // 0x162
	.word	446                     // 0x1be
	.word	86                      // 0x56
	.word	150                     // 0x96
	.word	338                     // 0x152
	.word	18                      // 0x12
	.word	488                     // 0x1e8
	.word	483                     // 0x1e3
	.word	297                     // 0x129
	.word	213                     // 0xd5
	.word	479                     // 0x1df
	.word	314                     // 0x13a
	.word	439                     // 0x1b7
	.word	353                     // 0x161
	.word	272                     // 0x110
	.word	4                       // 0x4
	.word	75                      // 0x4b
	.word	420                     // 0x1a4
	.word	143                     // 0x8f
	.word	413                     // 0x19d
	.word	153                     // 0x99
	.word	105                     // 0x69
	.word	376                     // 0x178
	.word	158                     // 0x9e
	.word	101                     // 0x65
	.word	327                     // 0x147
	.word	396                     // 0x18c
	.word	81                      // 0x51
	.word	427                     // 0x1ab
	.word	227                     // 0xe3
	.word	404                     // 0x194
	.word	48                      // 0x30
	.word	302                     // 0x12e
	.word	458                     // 0x1ca
	.word	446                     // 0x1be
	.word	422                     // 0x1a6
	.word	134                     // 0x86
	.word	42                      // 0x2a
	.word	132                     // 0x84
	.word	473                     // 0x1d9
	.word	197                     // 0xc5
	.word	258                     // 0x102
	.word	146                     // 0x92
	.word	99                      // 0x63
	.word	220                     // 0xdc
	.word	434                     // 0x1b2
	.word	381                     // 0x17d
	.word	489                     // 0x1e9
	.word	365                     // 0x16d
	.word	315                     // 0x13b
	.word	280                     // 0x118
	.word	437                     // 0x1b5
	.word	284                     // 0x11c
	.word	99                      // 0x63
	.word	388                     // 0x184
	.word	247                     // 0xf7
	.word	494                     // 0x1ee
	.word	477                     // 0x1dd
	.word	122                     // 0x7a
	.word	470                     // 0x1d6
	.word	42                      // 0x2a
	.word	47                      // 0x2f
	.word	130                     // 0x82
	.word	17                      // 0x11
	.word	484                     // 0x1e4
	.word	421                     // 0x1a5
	.word	268                     // 0x10c
	.word	390                     // 0x186
	.word	490                     // 0x1ea
	.word	317                     // 0x13d
	.word	417                     // 0x1a1
	.word	205                     // 0xcd
	.word	220                     // 0xdc
	.word	242                     // 0xf2
	.word	477                     // 0x1dd
	.word	508                     // 0x1fc
	.word	196                     // 0xc4
	.word	415                     // 0x19f
	.word	5                       // 0x5
	.word	144                     // 0x90
	.word	479                     // 0x1df
	.word	34                      // 0x22
	.word	117                     // 0x75
	.word	472                     // 0x1d8
	.word	309                     // 0x135
	.word	456                     // 0x1c8
	.word	72                      // 0x48
	.word	393                     // 0x189
	.word	51                      // 0x33
	.word	295                     // 0x127
	.word	407                     // 0x197
	.word	155                     // 0x9b
	.word	128                     // 0x80
	.word	47                      // 0x2f
	.word	400                     // 0x190
	.word	42                      // 0x2a
	.word	424                     // 0x1a8
	.word	168                     // 0xa8
	.word	231                     // 0xe7
	.word	468                     // 0x1d4
	.word	24                      // 0x18
	.word	467                     // 0x1d3
	.word	226                     // 0xe2
	.word	389                     // 0x185
	.word	68                      // 0x44
	.word	403                     // 0x193
	.word	502                     // 0x1f6
	.word	253                     // 0xfd
	.word	409                     // 0x199
	.word	505                     // 0x1f9
	.word	333                     // 0x14d
	.word	142                     // 0x8e
	.word	203                     // 0xcb
	.word	161                     // 0xa1
	.word	426                     // 0x1aa
	.word	322                     // 0x142
	.word	329                     // 0x149
	.word	130                     // 0x82
	.word	114                     // 0x72
	.word	398                     // 0x18e
	.word	302                     // 0x12e
	.word	306                     // 0x132
	.word	268                     // 0x10c
	.word	282                     // 0x11a
	.word	168                     // 0xa8
	.word	35                      // 0x23
	.word	214                     // 0xd6
	.word	28                      // 0x1c
	.word	355                     // 0x163
	.word	366                     // 0x16e
	.word	208                     // 0xd0
	.word	320                     // 0x140
	.word	418                     // 0x1a2
	.word	20                      // 0x14
	.word	239                     // 0xef
	.word	216                     // 0xd8
	.word	277                     // 0x115
	.word	343                     // 0x157
	.word	33                      // 0x21
	.word	250                     // 0xfa
	.word	28                      // 0x1c
	.word	339                     // 0x153
	.word	151                     // 0x97
	.word	232                     // 0xe8
	.word	336                     // 0x150
	.word	124                     // 0x7c
	.word	36                      // 0x24
	.word	203                     // 0xcb
	.word	376                     // 0x178
	.word	225                     // 0xe1
	.word	114                     // 0x72
	.word	390                     // 0x186
	.word	241                     // 0xf1
	.word	408                     // 0x198
	.word	246                     // 0xf6
	.word	21                      // 0x15
	.word	246                     // 0xf6
	.word	412                     // 0x19c
	.word	421                     // 0x1a5
	.word	419                     // 0x1a3
	.word	472                     // 0x1d8
	.word	454                     // 0x1c6
	.word	239                     // 0xef
	.word	162                     // 0xa2
	.word	482                     // 0x1e2
	.word	262                     // 0x106
	.word	132                     // 0x84
	.word	506                     // 0x1fa
	.word	305                     // 0x131
	.word	239                     // 0xef
	.word	341                     // 0x155
	.word	247                     // 0xf7
	.word	253                     // 0xfd
	.word	338                     // 0x152
	.word	200                     // 0xc8
	.word	37                      // 0x25
	.word	86                      // 0x56
	.word	66                      // 0x42
	.word	49                      // 0x31
	.word	458                     // 0x1ca
	.word	21                      // 0x15
	.word	89                      // 0x59
	.word	54                      // 0x36
	.word	299                     // 0x12b
	.word	86                      // 0x56
	.word	26                      // 0x1a
	.word	417                     // 0x1a1
	.word	143                     // 0x8f
	.word	275                     // 0x113
	.word	226                     // 0xe2
	.word	325                     // 0x145
	.word	56                      // 0x38
	.word	183                     // 0xb7
	.word	435                     // 0x1b3
	.word	262                     // 0x106
	.word	506                     // 0x1fa
	.word	181                     // 0xb5
	.word	228                     // 0xe4
	.word	197                     // 0xc5
	.word	270                     // 0x10e
	.word	339                     // 0x153
	.word	153                     // 0x99
	.word	364                     // 0x16c
	.word	471                     // 0x1d7
	.word	283                     // 0x11b
	.word	508                     // 0x1fc
	.word	510                     // 0x1fe
	.word	167                     // 0xa7
	.word	337                     // 0x151
	.word	462                     // 0x1ce
	.word	41                      // 0x29
	.word	338                     // 0x152
	.word	388                     // 0x184
	.word	106                     // 0x6a
	.word	162                     // 0xa2
	.word	439                     // 0x1b7
	.word	473                     // 0x1d9
	.word	505                     // 0x1f9
	.word	16                      // 0x10
	.word	87                      // 0x57
	.word	338                     // 0x152
	.word	48                      // 0x30
	.word	504                     // 0x1f8
	.word	402                     // 0x192
	.word	261                     // 0x105
	.word	376                     // 0x178
	.word	317                     // 0x13d
	.word	117                     // 0x75
	.word	345                     // 0x159
	.word	388                     // 0x184
	.word	374                     // 0x176
	.word	109                     // 0x6d
	.word	272                     // 0x110
	.word	301                     // 0x12d
	.word	398                     // 0x18e
	.word	435                     // 0x1b3
	.word	348                     // 0x15c
	.word	482                     // 0x1e2
	.word	438                     // 0x1b6
	.word	239                     // 0xef
	.word	272                     // 0x110
	.word	52                      // 0x34
	.word	85                      // 0x55
	.word	454                     // 0x1c6
	.word	349                     // 0x15d
	.word	475                     // 0x1db
	.word	46                      // 0x2e
	.word	188                     // 0xbc
	.word	85                      // 0x55
	.word	92                      // 0x5c
	.word	246                     // 0xf6
	.word	432                     // 0x1b0
	.word	398                     // 0x18e
	.word	169                     // 0xa9
	.word	477                     // 0x1dd
	.word	126                     // 0x7e
	.word	291                     // 0x123
	.word	158                     // 0x9e
	.word	141                     // 0x8d
	.word	143                     // 0x8f
	.word	199                     // 0xc7
	.word	415                     // 0x19f
	.word	144                     // 0x90
	.word	152                     // 0x98
	.word	329                     // 0x149
	.word	67                      // 0x43
	.word	286                     // 0x11e
	.word	347                     // 0x15b
	.word	126                     // 0x7e
	.word	290                     // 0x122
	.word	148                     // 0x94
	.word	421                     // 0x1a5
	.word	273                     // 0x111
	.word	342                     // 0x156
	.word	13                      // 0xd
	.word	205                     // 0xcd
	.word	424                     // 0x1a8
	.word	269                     // 0x10d
	.word	117                     // 0x75
	.word	155                     // 0x9b
	.word	42                      // 0x2a
	.word	99                      // 0x63
	.word	262                     // 0x106
	.word	343                     // 0x157
	.word	359                     // 0x167
	.word	16                      // 0x10
	.word	320                     // 0x140
	.word	466                     // 0x1d2
	.word	182                     // 0xb6
	.word	443                     // 0x1bb
	.word	412                     // 0x19c
	.word	435                     // 0x1b3
	.word	335                     // 0x14f
	.word	70                      // 0x46
	.word	494                     // 0x1ee
	.word	373                     // 0x175
	.word	463                     // 0x1cf
	.word	506                     // 0x1fa
	.word	66                      // 0x42
	.word	476                     // 0x1dc
	.word	338                     // 0x152
	.word	261                     // 0x105
	.word	223                     // 0xdf
	.word	505                     // 0x1f9
	.word	432                     // 0x1b0
	.word	400                     // 0x190
	.word	478                     // 0x1de
	.word	408                     // 0x198
	.word	99                      // 0x63
	.word	470                     // 0x1d6
	.word	331                     // 0x14b
	.word	202                     // 0xca
	.word	272                     // 0x110
	.word	362                     // 0x16a
	.word	430                     // 0x1ae
	.word	292                     // 0x124
	.word	243                     // 0xf3
	.word	158                     // 0x9e
	.word	499                     // 0x1f3
	.word	266                     // 0x10a
	.word	200                     // 0xc8
	.word	413                     // 0x19d
	.word	94                      // 0x5e
	.word	142                     // 0x8e
	.word	451                     // 0x1c3
	.word	231                     // 0xe7
	.word	414                     // 0x19e
	.word	151                     // 0x97
	.word	294                     // 0x126
	.word	154                     // 0x9a
	.word	264                     // 0x108
	.word	478                     // 0x1de
	.word	10                      // 0xa
	.word	28                      // 0x1c
	.word	150                     // 0x96
	.word	352                     // 0x160
	.word	390                     // 0x186
	.word	337                     // 0x151
	.word	67                      // 0x43
	.word	185                     // 0xb9
	.word	30                      // 0x1e
	.word	137                     // 0x89
	.word	410                     // 0x19a
	.word	113                     // 0x71
	.word	258                     // 0x102
	.word	332                     // 0x14c
	.word	174                     // 0xae
	.word	508                     // 0x1fc
	.word	296                     // 0x128
	.word	94                      // 0x5e
	.word	132                     // 0x84
	.word	202                     // 0xca
	.word	306                     // 0x132
	.word	452                     // 0x1c4
	.word	185                     // 0xb9
	.word	113                     // 0x71
	.word	409                     // 0x199
	.word	193                     // 0xc1
	.word	364                     // 0x16c
	.word	29                      // 0x1d
	.word	210                     // 0xd2
	.word	206                     // 0xce
	.word	127                     // 0x7f
	.word	244                     // 0xf4
	.word	177                     // 0xb1
	.word	394                     // 0x18a
	.word	282                     // 0x11a
	.word	329                     // 0x149
	.word	317                     // 0x13d
	.word	482                     // 0x1e2
	.word	384                     // 0x180
	.word	450                     // 0x1c2
	.word	150                     // 0x96
	.word	450                     // 0x1c2
	.word	295                     // 0x127
	.word	346                     // 0x15a
	.word	191                     // 0xbf
	.word	99                      // 0x63
	.word	63                      // 0x3f
	.word	362                     // 0x16a
	.word	59                      // 0x3b
	.word	50                      // 0x32
	.word	470                     // 0x1d6
	.word	235                     // 0xeb
	.word	360                     // 0x168
	.word	443                     // 0x1bb
	.word	352                     // 0x160
	.word	392                     // 0x188
	.word	134                     // 0x86
	.word	510                     // 0x1fe
	.word	511                     // 0x1ff
	.word	318                     // 0x13e
	.word	303                     // 0x12f
	.word	113                     // 0x71
	.word	79                      // 0x4f
	.word	84                      // 0x54
	.word	170                     // 0xaa
	.word	143                     // 0x8f
	.word	135                     // 0x87
	.word	266                     // 0x10a
	.word	326                     // 0x146
	.word	69                      // 0x45
	.word	12                      // 0xc
	.word	330                     // 0x14a
	.word	82                      // 0x52
	.word	504                     // 0x1f8
	.word	492                     // 0x1ec
	.word	174                     // 0xae
	.word	455                     // 0x1c7
	.word	228                     // 0xe4
	.word	175                     // 0xaf
	.word	446                     // 0x1be
	.word	61                      // 0x3d
	.word	405                     // 0x195
	.word	444                     // 0x1bc
	.word	451                     // 0x1c3
	.word	97                      // 0x61
	.word	241                     // 0xf1
	.word	498                     // 0x1f2
	.word	239                     // 0xef
	.word	278                     // 0x116
	.word	478                     // 0x1de
	.word	401                     // 0x191
	.word	154                     // 0x9a
	.word	223                     // 0xdf
	.word	231                     // 0xe7
	.word	445                     // 0x1bd
	.word	251                     // 0xfb
	.word	83                      // 0x53
	.word	374                     // 0x176
	.word	121                     // 0x79
	.word	506                     // 0x1fa
	.word	16                      // 0x10
	.word	291                     // 0x123
	.word	202                     // 0xca
	.word	104                     // 0x68
	.word	456                     // 0x1c8
	.word	124                     // 0x7c
	.word	445                     // 0x1bd
	.word	104                     // 0x68
	.word	223                     // 0xdf
	.word	312                     // 0x138
	.word	437                     // 0x1b5
	.word	462                     // 0x1ce
	.word	491                     // 0x1eb
	.word	403                     // 0x193
	.word	229                     // 0xe5
	.word	89                      // 0x59
	.word	466                     // 0x1d2
	.word	41                      // 0x29
	.word	427                     // 0x1ab
	.word	274                     // 0x112
	.word	380                     // 0x17c
	.word	27                      // 0x1b
	.word	484                     // 0x1e4
	.word	328                     // 0x148
	.word	341                     // 0x155
	.word	344                     // 0x158
	.word	5                       // 0x5
	.word	479                     // 0x1df
	.word	137                     // 0x89
	.word	127                     // 0x7f
	.word	86                      // 0x56
	.word	271                     // 0x10f
	.word	94                      // 0x5e
	.word	442                     // 0x1ba
	.word	140                     // 0x8c
	.word	466                     // 0x1d2
	.word	431                     // 0x1af
	.word	485                     // 0x1e5
	.word	427                     // 0x1ab
	.word	324                     // 0x144
	.word	297                     // 0x129
	.word	150                     // 0x96
	.word	237                     // 0xed
	.word	43                      // 0x2b
	.word	271                     // 0x10f
	.word	255                     // 0xff
	.word	24                      // 0x18
	.word	470                     // 0x1d6
	.word	10                      // 0xa
	.word	503                     // 0x1f7
	.word	344                     // 0x158
	.word	488                     // 0x1e8
	.word	511                     // 0x1ff
	.word	431                     // 0x1af
	.word	490                     // 0x1ea
	.word	270                     // 0x10e
	.word	317                     // 0x13d
	.word	180                     // 0xb4
	.word	334                     // 0x14e
	.word	434                     // 0x1b2
	.word	254                     // 0xfe
	.word	203                     // 0xcb
	.word	110                     // 0x6e
	.word	426                     // 0x1aa
	.word	450                     // 0x1c2
	.word	175                     // 0xaf
	.word	145                     // 0x91
	.word	220                     // 0xdc
	.word	411                     // 0x19b
	.word	478                     // 0x1de
	.word	156                     // 0x9c
	.word	271                     // 0x10f
	.word	483                     // 0x1e3
	.word	319                     // 0x13f
	.word	81                      // 0x51
	.word	149                     // 0x95
	.word	175                     // 0xaf
	.word	424                     // 0x1a8
	.word	165                     // 0xa5
	.word	326                     // 0x146
	.word	512                     // 0x200
	.word	53                      // 0x35
	.word	108                     // 0x6c
	.word	432                     // 0x1b0
	.word	217                     // 0xd9
	.word	146                     // 0x92
	.word	107                     // 0x6b
	.word	108                     // 0x6c
	.word	401                     // 0x191
	.word	339                     // 0x153
	.word	412                     // 0x19c
	.word	336                     // 0x150
	.word	211                     // 0xd3
	.word	68                      // 0x44
	.word	120                     // 0x78
	.word	153                     // 0x99
	.word	415                     // 0x19f
	.word	314                     // 0x13a
	.word	307                     // 0x133
	.word	26                      // 0x1a
	.word	374                     // 0x176
	.word	458                     // 0x1ca
	.word	8                       // 0x8
	.word	226                     // 0xe2
	.word	49                      // 0x31
	.word	458                     // 0x1ca
	.word	8                       // 0x8
	.word	369                     // 0x171
	.word	43                      // 0x2b
	.word	205                     // 0xcd
	.word	241                     // 0xf1
	.word	471                     // 0x1d7
	.word	73                      // 0x49
	.word	363                     // 0x16b
	.word	203                     // 0xcb
	.word	443                     // 0x1bb
	.word	457                     // 0x1c9
	.word	186                     // 0xba
	.word	102                     // 0x66
	.word	405                     // 0x195
	.word	343                     // 0x157
	.word	190                     // 0xbe
	.word	84                      // 0x54
	.word	43                      // 0x2b
	.word	13                      // 0xd
	.word	379                     // 0x17b
	.word	89                      // 0x59
	.word	43                      // 0x2b
	.word	435                     // 0x1b3
	.word	164                     // 0xa4
	.word	89                      // 0x59
	.word	111                     // 0x6f
	.word	135                     // 0x87
	.word	446                     // 0x1be
	.word	186                     // 0xba
	.word	120                     // 0x78
	.word	149                     // 0x95
	.word	165                     // 0xa5
	.word	264                     // 0x108
	.word	23                      // 0x17
	.word	15                      // 0xf
	.word	254                     // 0xfe
	.word	309                     // 0x135
	.word	376                     // 0x178
	.word	301                     // 0x12d
	.word	149                     // 0x95
	.word	93                      // 0x5d
	.word	415                     // 0x19f
	.word	205                     // 0xcd
	.word	245                     // 0xf5
	.word	74                      // 0x4a
	.word	304                     // 0x130
	.word	163                     // 0xa3
	.word	256                     // 0x100
	.word	7                       // 0x7
	.word	7                       // 0x7
	.word	188                     // 0xbc
	.word	182                     // 0xb6
	.word	316                     // 0x13c
	.word	11                      // 0xb
	.word	52                      // 0x34
	.word	380                     // 0x17c
	.word	246                     // 0xf6
	.word	305                     // 0x131
	.word	228                     // 0xe4
	.word	429                     // 0x1ad
	.word	87                      // 0x57
	.word	422                     // 0x1a6
	.word	368                     // 0x170
	.word	85                      // 0x55
	.word	28                      // 0x1c
	.word	271                     // 0x10f
	.word	423                     // 0x1a7
	.word	81                      // 0x51
	.word	44                      // 0x2c
	.word	128                     // 0x80
	.word	456                     // 0x1c8
	.word	365                     // 0x16d
	.word	353                     // 0x161
	.word	20                      // 0x14
	.word	75                      // 0x4b
	.word	131                     // 0x83
	.word	376                     // 0x178
	.word	40                      // 0x28
	.word	495                     // 0x1ef
	.word	273                     // 0x111
	.word	143                     // 0x8f
	.word	306                     // 0x132
	.word	352                     // 0x160
	.word	13                      // 0xd
	.word	491                     // 0x1eb
	.word	429                     // 0x1ad
	.word	391                     // 0x187
	.word	395                     // 0x18b
	.word	502                     // 0x1f6
	.word	72                      // 0x48
	.word	391                     // 0x187
	.word	71                      // 0x47
	.word	271                     // 0x10f
	.word	467                     // 0x1d3
	.word	397                     // 0x18d
	.word	95                      // 0x5f
	.word	438                     // 0x1b6
	.word	475                     // 0x1db
	.word	118                     // 0x76
	.word	485                     // 0x1e5
	.word	427                     // 0x1ab
	.word	160                     // 0xa0
	.word	34                      // 0x22
	.word	149                     // 0x95
	.word	165                     // 0xa5
	.word	90                      // 0x5a
	.word	377                     // 0x179
	.word	8                       // 0x8
	.word	405                     // 0x195
	.word	42                      // 0x2a
	.word	50                      // 0x32
	.word	160                     // 0xa0
	.word	501                     // 0x1f5
	.word	22                      // 0x16
	.word	24                      // 0x18
	.word	185                     // 0xb9
	.word	172                     // 0xac
	.word	402                     // 0x192
	.word	123                     // 0x7b
	.word	247                     // 0xf7
	.word	479                     // 0x1df
	.word	183                     // 0xb7
	.word	10                      // 0xa
	.word	440                     // 0x1b8
	.word	403                     // 0x193
	.word	43                      // 0x2b
	.word	103                     // 0x67
	.word	204                     // 0xcc
	.word	428                     // 0x1ac
	.word	300                     // 0x12c
	.word	253                     // 0xfd
	.word	312                     // 0x138
	.word	217                     // 0xd9
	.word	384                     // 0x180
	.word	254                     // 0xfe
	.word	16                      // 0x10
	.word	375                     // 0x177
	.word	212                     // 0xd4
	.word	418                     // 0x1a2
	.word	312                     // 0x138
	.word	301                     // 0x12d
	.word	214                     // 0xd6
	.word	55                      // 0x37
	.word	11                      // 0xb
	.word	509                     // 0x1fd
	.word	362                     // 0x16a
	.word	200                     // 0xc8
	.word	224                     // 0xe0
	.word	484                     // 0x1e4
	.word	136                     // 0x88
	.word	475                     // 0x1db
	.word	477                     // 0x1dd
	.word	266                     // 0x10a
	.word	410                     // 0x19a
	.word	244                     // 0xf4
	.word	256                     // 0x100
	.word	217                     // 0xd9
	.word	372                     // 0x174
	.word	460                     // 0x1cc
	.word	497                     // 0x1f1
	.word	3                       // 0x3
	.word	316                     // 0x13c
	.word	477                     // 0x1dd
	.word	474                     // 0x1da
	.word	61                      // 0x3d
	.word	462                     // 0x1ce
	.word	332                     // 0x14c
	.word	111                     // 0x6f
	.word	183                     // 0xb7
	.word	478                     // 0x1de
	.word	29                      // 0x1d
	.word	365                     // 0x16d
	.word	511                     // 0x1ff
	.word	421                     // 0x1a5
	.word	453                     // 0x1c5
	.word	287                     // 0x11f
	.word	141                     // 0x8d
	.word	177                     // 0xb1
	.word	100                     // 0x64
	.word	81                      // 0x51
	.word	266                     // 0x10a
	.word	451                     // 0x1c3
	.word	235                     // 0xeb
	.word	235                     // 0xeb
	.word	198                     // 0xc6
	.word	262                     // 0x106
	.word	409                     // 0x199
	.word	207                     // 0xcf
	.word	269                     // 0x10d
	.word	493                     // 0x1ed
	.word	192                     // 0xc0
	.word	482                     // 0x1e2
	.word	43                      // 0x2b
	.word	312                     // 0x138
	.word	492                     // 0x1ec
	.word	261                     // 0x105
	.word	10                      // 0xa
	.word	245                     // 0xf5
	.word	221                     // 0xdd
	.word	106                     // 0x6a
	.word	288                     // 0x120
	.word	58                      // 0x3a
	.word	444                     // 0x1bc
	.word	110                     // 0x6e
	.word	6                       // 0x6
	.word	10                      // 0xa
	.word	373                     // 0x175
	.word	211                     // 0xd3
	.word	323                     // 0x143
	.word	159                     // 0x9f
	.word	274                     // 0x112
	.word	210                     // 0xd2
	.word	209                     // 0xd1
	.word	314                     // 0x13a
	.word	78                      // 0x4e
	.word	75                      // 0x4b
	.size	nums1k2, 4096


	.ident	"clang version 3.5.0 "

	.text
	.file	"sqrt.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI0_0:
	.xword	4554050699414489        // double 2.25E-308
.LCPI0_1:
	.xword	-9218817986155361319    // double -2.25E-308
	.text
	.globl	sqroot
	.align	2
	.type	sqroot,@function
sqroot:                                 // @sqroot
// BB#0:                                // %entry
	sub	sp, sp, #32             // =32
	orr	x8, xzr, #0x1
	scvtf	s1, x8
	orr	x8, xzr, #0x3
	scvtf	s2, x8
	str	s0, [sp, #24]
	ldr	s0, [sp, #24]
	fdiv	s0, s0, s2
	str	s0, [sp, #20]
	str	s1, [sp, #12]
	ldr	s0, [sp, #24]
	fcmp	s0, #0.0
	b.ls	.LBB0_1
	b	.LBB0_2
.LBB0_1:                                // %if.then
	movz	x8, #0
	scvtf	s0, x8
	str	s0, [sp, #28]
	b	.LBB0_8
.LBB0_2:                                // %if.end
	b	.LBB0_3
.LBB0_3:                                // %do.body
                                        // =>This Inner Loop Header: Depth=1
	orr	x8, xzr, #0x2
	scvtf	s0, x8
	ldr	s1, [sp, #20]
	str	s1, [sp, #16]
	ldr	s1, [sp, #20]
	ldr	s2, [sp, #24]
	ldr	s3, [sp, #20]
	fdiv	s2, s2, s3
	fadd	s1, s1, s2
	fdiv	s0, s1, s0
	str	s0, [sp, #20]
	ldr	s0, [sp, #20]
	ldr	s1, [sp, #16]
	fsub	s0, s0, s1
	str	s0, [sp, #12]
// BB#4:                                // %do.cond
                                        //   in Loop: Header=BB0_3 Depth=1
	orr	w8, wzr, #0x1
	adrp	x9, .LCPI0_0
	ldr	d0, [x9, :lo12:.LCPI0_0]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fcmp	d2, d0
	str	w8, [sp, #8]            // 4-byte Folded Spill
	b.gt	.LBB0_6
// BB#5:                                // %lor.rhs
                                        //   in Loop: Header=BB0_3 Depth=1
	adrp	x8, .LCPI0_1
	ldr	d0, [x8, :lo12:.LCPI0_1]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fcmp	d2, d0
	cset	 w9, mi
	str	w9, [sp, #8]            // 4-byte Folded Spill
.LBB0_6:                                // %lor.end
                                        //   in Loop: Header=BB0_3 Depth=1
	ldr	w0, [sp, #8]            // 4-byte Folded Reload
	cmp	 w0, #0                 // =0
	b.ne	.LBB0_3
// BB#7:                                // %do.end
	ldr	s0, [sp, #20]
	str	s0, [sp, #28]
.LBB0_8:                                // %return
	ldr	s0, [sp, #28]
	add	sp, sp, #32             // =32
	ret
.Ltmp1:
	.size	sqroot, .Ltmp1-sqroot

	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI1_0:
	.word	1078529622              // float 3.1415
	.text
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	adrp	x8, .LCPI1_0
	ldr	s0, [x8, :lo12:.LCPI1_0]
	movz	w9, #0
	stur	w9, [x29, #-4]
	bl	sqroot
	bl	sqroot
	bl	sqroot
	movz	w0, #0
	str	s0, [sp, #8]
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp2:
	.size	main, .Ltmp2-main


	.ident	"clang version 3.5.0 "

	.text
	.file	"vadd.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x28, x27, [sp, #-16]!
	sub	sp, sp, #1, lsl #12     // =4096
	sub	sp, sp, #16             // =16
	movz	w8, #0
	str	w8, [sp, #4108]
	str	w8, [sp, #8]
.LBB0_1:                                // %for.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #8]
	cmp	 w8, #1024              // =1024
	b.lt	.LBB0_2
	b	.LBB0_4
.LBB0_2:                                // %for.body
                                        //   in Loop: Header=BB0_1 Depth=1
	add	x8, sp, #12             // =12
	adrp	x9, nums1k2
	add	x9, x9, :lo12:nums1k2
	adrp	x10, nums1k1
	add	x10, x10, :lo12:nums1k1
	ldr	w11, [sp, #8]
	mov	 w12, w11
	sxtw	x12, w12
	orr	x13, xzr, #0x2
	lsl	x12, x12, x13
	add	 x10, x10, x12
	ldr	 w11, [x10]
	ldr	w14, [sp, #8]
	mov	 w10, w14
	sxtw	x10, w10
	orr	x12, xzr, #0x2
	lsl	x10, x10, x12
	add	 x9, x9, x10
	ldr	 w14, [x9]
	add	 w11, w11, w14
	ldr	w14, [sp, #8]
	mov	 w9, w14
	sxtw	x9, w9
	orr	x10, xzr, #0x2
	lsl	x9, x9, x10
	add	 x8, x8, x9
	str	 w11, [x8]
// BB#3:                                // %for.inc
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #8]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #8]
	b	.LBB0_1
.LBB0_4:                                // %for.end
	movz	w0, #0
	add	sp, sp, #1, lsl #12     // =4096
	add	sp, sp, #16             // =16
	ldp	x28, x27, [sp], #16
	ret
.Ltmp0:
	.size	main, .Ltmp0-main

	.type	nums1k1,@object         // @nums1k1
	.data
	.globl	nums1k1
	.align	2
nums1k1:
	.word	364                     // 0x16c
	.word	286                     // 0x11e
	.word	278                     // 0x116
	.word	283                     // 0x11b
	.word	154                     // 0x9a
	.word	477                     // 0x1dd
	.word	369                     // 0x171
	.word	480                     // 0x1e0
	.word	40                      // 0x28
	.word	382                     // 0x17e
	.word	153                     // 0x99
	.word	293                     // 0x125
	.word	488                     // 0x1e8
	.word	35                      // 0x23
	.word	225                     // 0xe1
	.word	172                     // 0xac
	.word	4                       // 0x4
	.word	443                     // 0x1bb
	.word	411                     // 0x19b
	.word	429                     // 0x1ad
	.word	131                     // 0x83
	.word	490                     // 0x1ea
	.word	91                      // 0x5b
	.word	89                      // 0x59
	.word	495                     // 0x1ef
	.word	426                     // 0x1aa
	.word	290                     // 0x122
	.word	411                     // 0x19b
	.word	423                     // 0x1a7
	.word	493                     // 0x1ed
	.word	139                     // 0x8b
	.word	414                     // 0x19e
	.word	303                     // 0x12f
	.word	485                     // 0x1e5
	.word	327                     // 0x147
	.word	44                      // 0x2c
	.word	430                     // 0x1ae
	.word	129                     // 0x81
	.word	153                     // 0x99
	.word	331                     // 0x14b
	.word	138                     // 0x8a
	.word	206                     // 0xce
	.word	284                     // 0x11c
	.word	461                     // 0x1cd
	.word	428                     // 0x1ac
	.word	473                     // 0x1d9
	.word	297                     // 0x129
	.word	90                      // 0x5a
	.word	260                     // 0x104
	.word	317                     // 0x13d
	.word	241                     // 0xf1
	.word	135                     // 0x87
	.word	297                     // 0x129
	.word	386                     // 0x182
	.word	83                      // 0x53
	.word	481                     // 0x1e1
	.word	456                     // 0x1c8
	.word	116                     // 0x74
	.word	95                      // 0x5f
	.word	47                      // 0x2f
	.word	317                     // 0x13d
	.word	31                      // 0x1f
	.word	337                     // 0x151
	.word	29                      // 0x1d
	.word	383                     // 0x17f
	.word	417                     // 0x1a1
	.word	268                     // 0x10c
	.word	134                     // 0x86
	.word	277                     // 0x115
	.word	402                     // 0x192
	.word	432                     // 0x1b0
	.word	493                     // 0x1ed
	.word	119                     // 0x77
	.word	352                     // 0x160
	.word	70                      // 0x46
	.word	459                     // 0x1cb
	.word	188                     // 0xbc
	.word	329                     // 0x149
	.word	249                     // 0xf9
	.word	287                     // 0x11f
	.word	165                     // 0xa5
	.word	384                     // 0x180
	.word	149                     // 0x95
	.word	371                     // 0x173
	.word	89                      // 0x59
	.word	285                     // 0x11d
	.word	179                     // 0xb3
	.word	133                     // 0x85
	.word	134                     // 0x86
	.word	219                     // 0xdb
	.word	20                      // 0x14
	.word	11                      // 0xb
	.word	379                     // 0x17b
	.word	295                     // 0x127
	.word	36                      // 0x24
	.word	380                     // 0x17c
	.word	158                     // 0x9e
	.word	80                      // 0x50
	.word	440                     // 0x1b8
	.word	335                     // 0x14f
	.word	47                      // 0x2f
	.word	182                     // 0xb6
	.word	415                     // 0x19f
	.word	452                     // 0x1c4
	.word	340                     // 0x154
	.word	57                      // 0x39
	.word	468                     // 0x1d4
	.word	182                     // 0xb6
	.word	249                     // 0xf9
	.word	106                     // 0x6a
	.word	259                     // 0x103
	.word	276                     // 0x114
	.word	487                     // 0x1e7
	.word	175                     // 0xaf
	.word	510                     // 0x1fe
	.word	63                      // 0x3f
	.word	6                       // 0x6
	.word	122                     // 0x7a
	.word	68                      // 0x44
	.word	34                      // 0x22
	.word	271                     // 0x10f
	.word	74                      // 0x4a
	.word	18                      // 0x12
	.word	126                     // 0x7e
	.word	331                     // 0x14b
	.word	435                     // 0x1b3
	.word	329                     // 0x149
	.word	60                      // 0x3c
	.word	193                     // 0xc1
	.word	75                      // 0x4b
	.word	94                      // 0x5e
	.word	128                     // 0x80
	.word	143                     // 0x8f
	.word	143                     // 0x8f
	.word	242                     // 0xf2
	.word	423                     // 0x1a7
	.word	360                     // 0x168
	.word	249                     // 0xf9
	.word	92                      // 0x5c
	.word	342                     // 0x156
	.word	14                      // 0xe
	.word	270                     // 0x10e
	.word	417                     // 0x1a1
	.word	110                     // 0x6e
	.word	27                      // 0x1b
	.word	160                     // 0xa0
	.word	500                     // 0x1f4
	.word	428                     // 0x1ac
	.word	146                     // 0x92
	.word	103                     // 0x67
	.word	403                     // 0x193
	.word	304                     // 0x130
	.word	362                     // 0x16a
	.word	331                     // 0x14b
	.word	35                      // 0x23
	.word	392                     // 0x188
	.word	320                     // 0x140
	.word	330                     // 0x14a
	.word	369                     // 0x171
	.word	34                      // 0x22
	.word	508                     // 0x1fc
	.word	405                     // 0x195
	.word	306                     // 0x132
	.word	338                     // 0x152
	.word	177                     // 0xb1
	.word	220                     // 0xdc
	.word	451                     // 0x1c3
	.word	369                     // 0x171
	.word	278                     // 0x116
	.word	37                      // 0x25
	.word	151                     // 0x97
	.word	378                     // 0x17a
	.word	468                     // 0x1d4
	.word	486                     // 0x1e6
	.word	85                      // 0x55
	.word	206                     // 0xce
	.word	258                     // 0x102
	.word	169                     // 0xa9
	.word	496                     // 0x1f0
	.word	505                     // 0x1f9
	.word	99                      // 0x63
	.word	216                     // 0xd8
	.word	367                     // 0x16f
	.word	99                      // 0x63
	.word	455                     // 0x1c7
	.word	301                     // 0x12d
	.word	386                     // 0x182
	.word	447                     // 0x1bf
	.word	354                     // 0x162
	.word	430                     // 0x1ae
	.word	6                       // 0x6
	.word	266                     // 0x10a
	.word	204                     // 0xcc
	.word	59                      // 0x3b
	.word	276                     // 0x114
	.word	11                      // 0xb
	.word	148                     // 0x94
	.word	506                     // 0x1fa
	.word	486                     // 0x1e6
	.word	459                     // 0x1cb
	.word	391                     // 0x187
	.word	36                      // 0x24
	.word	428                     // 0x1ac
	.word	54                      // 0x36
	.word	53                      // 0x35
	.word	453                     // 0x1c5
	.word	221                     // 0xdd
	.word	503                     // 0x1f7
	.word	399                     // 0x18f
	.word	330                     // 0x14a
	.word	347                     // 0x15b
	.word	487                     // 0x1e7
	.word	1                       // 0x1
	.word	278                     // 0x116
	.word	155                     // 0x9b
	.word	221                     // 0xdd
	.word	278                     // 0x116
	.word	328                     // 0x148
	.word	371                     // 0x173
	.word	150                     // 0x96
	.word	159                     // 0x9f
	.word	228                     // 0xe4
	.word	406                     // 0x196
	.word	101                     // 0x65
	.word	126                     // 0x7e
	.word	215                     // 0xd7
	.word	128                     // 0x80
	.word	26                      // 0x1a
	.word	487                     // 0x1e7
	.word	339                     // 0x153
	.word	146                     // 0x92
	.word	24                      // 0x18
	.word	402                     // 0x192
	.word	97                      // 0x61
	.word	281                     // 0x119
	.word	320                     // 0x140
	.word	214                     // 0xd6
	.word	151                     // 0x97
	.word	271                     // 0x10f
	.word	363                     // 0x16b
	.word	300                     // 0x12c
	.word	501                     // 0x1f5
	.word	274                     // 0x112
	.word	41                      // 0x29
	.word	112                     // 0x70
	.word	306                     // 0x132
	.word	507                     // 0x1fb
	.word	293                     // 0x125
	.word	342                     // 0x156
	.word	282                     // 0x11a
	.word	173                     // 0xad
	.word	477                     // 0x1dd
	.word	317                     // 0x13d
	.word	176                     // 0xb0
	.word	271                     // 0x10f
	.word	327                     // 0x147
	.word	436                     // 0x1b4
	.word	117                     // 0x75
	.word	199                     // 0xc7
	.word	276                     // 0x114
	.word	414                     // 0x19e
	.word	485                     // 0x1e5
	.word	273                     // 0x111
	.word	76                      // 0x4c
	.word	307                     // 0x133
	.word	267                     // 0x10b
	.word	215                     // 0xd7
	.word	327                     // 0x147
	.word	379                     // 0x17b
	.word	315                     // 0x13b
	.word	431                     // 0x1af
	.word	313                     // 0x139
	.word	377                     // 0x179
	.word	261                     // 0x105
	.word	117                     // 0x75
	.word	195                     // 0xc3
	.word	245                     // 0xf5
	.word	153                     // 0x99
	.word	54                      // 0x36
	.word	427                     // 0x1ab
	.word	340                     // 0x154
	.word	485                     // 0x1e5
	.word	414                     // 0x19e
	.word	318                     // 0x13e
	.word	213                     // 0xd5
	.word	491                     // 0x1eb
	.word	159                     // 0x9f
	.word	511                     // 0x1ff
	.word	128                     // 0x80
	.word	312                     // 0x138
	.word	463                     // 0x1cf
	.word	297                     // 0x129
	.word	35                      // 0x23
	.word	273                     // 0x111
	.word	31                      // 0x1f
	.word	272                     // 0x110
	.word	239                     // 0xef
	.word	101                     // 0x65
	.word	235                     // 0xeb
	.word	234                     // 0xea
	.word	238                     // 0xee
	.word	308                     // 0x134
	.word	325                     // 0x145
	.word	397                     // 0x18d
	.word	155                     // 0x9b
	.word	163                     // 0xa3
	.word	146                     // 0x92
	.word	499                     // 0x1f3
	.word	273                     // 0x111
	.word	28                      // 0x1c
	.word	280                     // 0x118
	.word	374                     // 0x176
	.word	32                      // 0x20
	.word	400                     // 0x190
	.word	314                     // 0x13a
	.word	21                      // 0x15
	.word	340                     // 0x154
	.word	7                       // 0x7
	.word	231                     // 0xe7
	.word	390                     // 0x186
	.word	258                     // 0x102
	.word	431                     // 0x1af
	.word	192                     // 0xc0
	.word	469                     // 0x1d5
	.word	14                      // 0xe
	.word	293                     // 0x125
	.word	418                     // 0x1a2
	.word	140                     // 0x8c
	.word	481                     // 0x1e1
	.word	302                     // 0x12e
	.word	440                     // 0x1b8
	.word	68                      // 0x44
	.word	303                     // 0x12f
	.word	499                     // 0x1f3
	.word	387                     // 0x183
	.word	169                     // 0xa9
	.word	4                       // 0x4
	.word	166                     // 0xa6
	.word	363                     // 0x16b
	.word	388                     // 0x184
	.word	160                     // 0xa0
	.word	428                     // 0x1ac
	.word	469                     // 0x1d5
	.word	361                     // 0x169
	.word	66                      // 0x42
	.word	458                     // 0x1ca
	.word	92                      // 0x5c
	.word	315                     // 0x13b
	.word	90                      // 0x5a
	.word	331                     // 0x14b
	.word	422                     // 0x1a6
	.word	249                     // 0xf9
	.word	344                     // 0x158
	.word	496                     // 0x1f0
	.word	151                     // 0x97
	.word	295                     // 0x127
	.word	167                     // 0xa7
	.word	297                     // 0x129
	.word	430                     // 0x1ae
	.word	309                     // 0x135
	.word	391                     // 0x187
	.word	158                     // 0x9e
	.word	185                     // 0xb9
	.word	91                      // 0x5b
	.word	440                     // 0x1b8
	.word	275                     // 0x113
	.word	477                     // 0x1dd
	.word	362                     // 0x16a
	.word	283                     // 0x11b
	.word	88                      // 0x58
	.word	487                     // 0x1e7
	.word	341                     // 0x155
	.word	423                     // 0x1a7
	.word	96                      // 0x60
	.word	391                     // 0x187
	.word	419                     // 0x1a3
	.word	106                     // 0x6a
	.word	110                     // 0x6e
	.word	143                     // 0x8f
	.word	319                     // 0x13f
	.word	197                     // 0xc5
	.word	330                     // 0x14a
	.word	212                     // 0xd4
	.word	403                     // 0x193
	.word	505                     // 0x1f9
	.word	1                       // 0x1
	.word	147                     // 0x93
	.word	223                     // 0xdf
	.word	343                     // 0x157
	.word	41                      // 0x29
	.word	24                      // 0x18
	.word	357                     // 0x165
	.word	457                     // 0x1c9
	.word	90                      // 0x5a
	.word	318                     // 0x13e
	.word	21                      // 0x15
	.word	263                     // 0x107
	.word	371                     // 0x173
	.word	434                     // 0x1b2
	.word	82                      // 0x52
	.word	242                     // 0xf2
	.word	7                       // 0x7
	.word	394                     // 0x18a
	.word	245                     // 0xf5
	.word	329                     // 0x149
	.word	352                     // 0x160
	.word	290                     // 0x122
	.word	241                     // 0xf1
	.word	134                     // 0x86
	.word	35                      // 0x23
	.word	143                     // 0x8f
	.word	429                     // 0x1ad
	.word	132                     // 0x84
	.word	328                     // 0x148
	.word	22                      // 0x16
	.word	298                     // 0x12a
	.word	424                     // 0x1a8
	.word	258                     // 0x102
	.word	219                     // 0xdb
	.word	355                     // 0x163
	.word	273                     // 0x111
	.word	101                     // 0x65
	.word	119                     // 0x77
	.word	55                      // 0x37
	.word	264                     // 0x108
	.word	188                     // 0xbc
	.word	363                     // 0x16b
	.word	413                     // 0x19d
	.word	263                     // 0x107
	.word	11                      // 0xb
	.word	392                     // 0x188
	.word	285                     // 0x11d
	.word	433                     // 0x1b1
	.word	322                     // 0x142
	.word	443                     // 0x1bb
	.word	502                     // 0x1f6
	.word	153                     // 0x99
	.word	304                     // 0x130
	.word	293                     // 0x125
	.word	42                      // 0x2a
	.word	273                     // 0x111
	.word	450                     // 0x1c2
	.word	400                     // 0x190
	.word	147                     // 0x93
	.word	466                     // 0x1d2
	.word	61                      // 0x3d
	.word	311                     // 0x137
	.word	204                     // 0xcc
	.word	107                     // 0x6b
	.word	233                     // 0xe9
	.word	206                     // 0xce
	.word	373                     // 0x175
	.word	430                     // 0x1ae
	.word	374                     // 0x176
	.word	242                     // 0xf2
	.word	498                     // 0x1f2
	.word	301                     // 0x12d
	.word	391                     // 0x187
	.word	247                     // 0xf7
	.word	120                     // 0x78
	.word	286                     // 0x11e
	.word	261                     // 0x105
	.word	299                     // 0x12b
	.word	395                     // 0x18b
	.word	117                     // 0x75
	.word	457                     // 0x1c9
	.word	428                     // 0x1ac
	.word	386                     // 0x182
	.word	492                     // 0x1ec
	.word	213                     // 0xd5
	.word	28                      // 0x1c
	.word	231                     // 0xe7
	.word	80                      // 0x50
	.word	181                     // 0xb5
	.word	30                      // 0x1e
	.word	498                     // 0x1f2
	.word	197                     // 0xc5
	.word	71                      // 0x47
	.word	301                     // 0x12d
	.word	144                     // 0x90
	.word	27                      // 0x1b
	.word	209                     // 0xd1
	.word	124                     // 0x7c
	.word	82                      // 0x52
	.word	397                     // 0x18d
	.word	22                      // 0x16
	.word	358                     // 0x166
	.word	296                     // 0x128
	.word	341                     // 0x155
	.word	468                     // 0x1d4
	.word	184                     // 0xb8
	.word	140                     // 0x8c
	.word	265                     // 0x109
	.word	448                     // 0x1c0
	.word	408                     // 0x198
	.word	185                     // 0xb9
	.word	396                     // 0x18c
	.word	193                     // 0xc1
	.word	444                     // 0x1bc
	.word	439                     // 0x1b7
	.word	456                     // 0x1c8
	.word	152                     // 0x98
	.word	422                     // 0x1a6
	.word	32                      // 0x20
	.word	505                     // 0x1f9
	.word	46                      // 0x2e
	.word	351                     // 0x15f
	.word	67                      // 0x43
	.word	89                      // 0x59
	.word	136                     // 0x88
	.word	261                     // 0x105
	.word	64                      // 0x40
	.word	469                     // 0x1d5
	.word	174                     // 0xae
	.word	252                     // 0xfc
	.word	431                     // 0x1af
	.word	504                     // 0x1f8
	.word	486                     // 0x1e6
	.word	260                     // 0x104
	.word	7                       // 0x7
	.word	283                     // 0x11b
	.word	313                     // 0x139
	.word	201                     // 0xc9
	.word	226                     // 0xe2
	.word	183                     // 0xb7
	.word	396                     // 0x18c
	.word	212                     // 0xd4
	.word	340                     // 0x154
	.word	342                     // 0x156
	.word	178                     // 0xb2
	.word	255                     // 0xff
	.word	78                      // 0x4e
	.word	25                      // 0x19
	.word	18                      // 0x12
	.word	250                     // 0xfa
	.word	57                      // 0x39
	.word	67                      // 0x43
	.word	96                      // 0x60
	.word	88                      // 0x58
	.word	477                     // 0x1dd
	.word	16                      // 0x10
	.word	379                     // 0x17b
	.word	476                     // 0x1dc
	.word	241                     // 0xf1
	.word	428                     // 0x1ac
	.word	124                     // 0x7c
	.word	220                     // 0xdc
	.word	6                       // 0x6
	.word	230                     // 0xe6
	.word	34                      // 0x22
	.word	226                     // 0xe2
	.word	409                     // 0x199
	.word	304                     // 0x130
	.word	501                     // 0x1f5
	.word	99                      // 0x63
	.word	265                     // 0x109
	.word	257                     // 0x101
	.word	351                     // 0x15f
	.word	237                     // 0xed
	.word	326                     // 0x146
	.word	137                     // 0x89
	.word	312                     // 0x138
	.word	272                     // 0x110
	.word	471                     // 0x1d7
	.word	218                     // 0xda
	.word	154                     // 0x9a
	.word	199                     // 0xc7
	.word	212                     // 0xd4
	.word	141                     // 0x8d
	.word	93                      // 0x5d
	.word	433                     // 0x1b1
	.word	210                     // 0xd2
	.word	370                     // 0x172
	.word	506                     // 0x1fa
	.word	117                     // 0x75
	.word	499                     // 0x1f3
	.word	328                     // 0x148
	.word	357                     // 0x165
	.word	141                     // 0x8d
	.word	27                      // 0x1b
	.word	144                     // 0x90
	.word	162                     // 0xa2
	.word	54                      // 0x36
	.word	435                     // 0x1b3
	.word	361                     // 0x169
	.word	447                     // 0x1bf
	.word	478                     // 0x1de
	.word	400                     // 0x190
	.word	434                     // 0x1b2
	.word	2                       // 0x2
	.word	77                      // 0x4d
	.word	401                     // 0x191
	.word	79                      // 0x4f
	.word	313                     // 0x139
	.word	454                     // 0x1c6
	.word	177                     // 0xb1
	.word	164                     // 0xa4
	.word	415                     // 0x19f
	.word	100                     // 0x64
	.word	87                      // 0x57
	.word	36                      // 0x24
	.word	101                     // 0x65
	.word	190                     // 0xbe
	.word	294                     // 0x126
	.word	378                     // 0x17a
	.word	471                     // 0x1d7
	.word	230                     // 0xe6
	.word	49                      // 0x31
	.word	231                     // 0xe7
	.word	56                      // 0x38
	.word	238                     // 0xee
	.word	45                      // 0x2d
	.word	1                       // 0x1
	.word	73                      // 0x49
	.word	372                     // 0x174
	.word	322                     // 0x142
	.word	229                     // 0xe5
	.word	336                     // 0x150
	.word	338                     // 0x152
	.word	53                      // 0x35
	.word	144                     // 0x90
	.word	491                     // 0x1eb
	.word	233                     // 0xe9
	.word	440                     // 0x1b8
	.word	200                     // 0xc8
	.word	35                      // 0x23
	.word	74                      // 0x4a
	.word	108                     // 0x6c
	.word	106                     // 0x6a
	.word	448                     // 0x1c0
	.word	313                     // 0x139
	.word	324                     // 0x144
	.word	126                     // 0x7e
	.word	157                     // 0x9d
	.word	283                     // 0x11b
	.word	405                     // 0x195
	.word	305                     // 0x131
	.word	237                     // 0xed
	.word	177                     // 0xb1
	.word	354                     // 0x162
	.word	386                     // 0x182
	.word	318                     // 0x13e
	.word	60                      // 0x3c
	.word	145                     // 0x91
	.word	299                     // 0x12b
	.word	468                     // 0x1d4
	.word	23                      // 0x17
	.word	314                     // 0x13a
	.word	6                       // 0x6
	.word	145                     // 0x91
	.word	103                     // 0x67
	.word	482                     // 0x1e2
	.word	129                     // 0x81
	.word	98                      // 0x62
	.word	220                     // 0xdc
	.word	67                      // 0x43
	.word	114                     // 0x72
	.word	211                     // 0xd3
	.word	265                     // 0x109
	.word	83                      // 0x53
	.word	398                     // 0x18e
	.word	168                     // 0xa8
	.word	92                      // 0x5c
	.word	200                     // 0xc8
	.word	55                      // 0x37
	.word	71                      // 0x47
	.word	39                      // 0x27
	.word	459                     // 0x1cb
	.word	146                     // 0x92
	.word	252                     // 0xfc
	.word	277                     // 0x115
	.word	376                     // 0x178
	.word	240                     // 0xf0
	.word	232                     // 0xe8
	.word	475                     // 0x1db
	.word	297                     // 0x129
	.word	375                     // 0x177
	.word	385                     // 0x181
	.word	253                     // 0xfd
	.word	388                     // 0x184
	.word	299                     // 0x12b
	.word	174                     // 0xae
	.word	216                     // 0xd8
	.word	243                     // 0xf3
	.word	42                      // 0x2a
	.word	144                     // 0x90
	.word	61                      // 0x3d
	.word	336                     // 0x150
	.word	413                     // 0x19d
	.word	338                     // 0x152
	.word	138                     // 0x8a
	.word	133                     // 0x85
	.word	302                     // 0x12e
	.word	202                     // 0xca
	.word	138                     // 0x8a
	.word	78                      // 0x4e
	.word	167                     // 0xa7
	.word	101                     // 0x65
	.word	486                     // 0x1e6
	.word	131                     // 0x83
	.word	476                     // 0x1dc
	.word	282                     // 0x11a
	.word	29                      // 0x1d
	.word	402                     // 0x192
	.word	46                      // 0x2e
	.word	57                      // 0x39
	.word	510                     // 0x1fe
	.word	418                     // 0x1a2
	.word	432                     // 0x1b0
	.word	78                      // 0x4e
	.word	214                     // 0xd6
	.word	224                     // 0xe0
	.word	243                     // 0xf3
	.word	121                     // 0x79
	.word	78                      // 0x4e
	.word	378                     // 0x17a
	.word	259                     // 0x103
	.word	314                     // 0x13a
	.word	246                     // 0xf6
	.word	291                     // 0x123
	.word	346                     // 0x15a
	.word	239                     // 0xef
	.word	5                       // 0x5
	.word	162                     // 0xa2
	.word	288                     // 0x120
	.word	42                      // 0x2a
	.word	32                      // 0x20
	.word	286                     // 0x11e
	.word	267                     // 0x10b
	.word	67                      // 0x43
	.word	103                     // 0x67
	.word	244                     // 0xf4
	.word	476                     // 0x1dc
	.word	172                     // 0xac
	.word	288                     // 0x120
	.word	124                     // 0x7c
	.word	511                     // 0x1ff
	.word	226                     // 0xe2
	.word	63                      // 0x3f
	.word	103                     // 0x67
	.word	485                     // 0x1e5
	.word	488                     // 0x1e8
	.word	153                     // 0x99
	.word	453                     // 0x1c5
	.word	422                     // 0x1a6
	.word	461                     // 0x1cd
	.word	240                     // 0xf0
	.word	169                     // 0xa9
	.word	312                     // 0x138
	.word	290                     // 0x122
	.word	300                     // 0x12c
	.word	99                      // 0x63
	.word	276                     // 0x114
	.word	102                     // 0x66
	.word	500                     // 0x1f4
	.word	300                     // 0x12c
	.word	386                     // 0x182
	.word	247                     // 0xf7
	.word	148                     // 0x94
	.word	120                     // 0x78
	.word	497                     // 0x1f1
	.word	17                      // 0x11
	.word	469                     // 0x1d5
	.word	441                     // 0x1b9
	.word	116                     // 0x74
	.word	357                     // 0x165
	.word	98                      // 0x62
	.word	31                      // 0x1f
	.word	162                     // 0xa2
	.word	213                     // 0xd5
	.word	312                     // 0x138
	.word	100                     // 0x64
	.word	280                     // 0x118
	.word	89                      // 0x59
	.word	293                     // 0x125
	.word	324                     // 0x144
	.word	284                     // 0x11c
	.word	205                     // 0xcd
	.word	245                     // 0xf5
	.word	317                     // 0x13d
	.word	279                     // 0x117
	.word	95                      // 0x5f
	.word	58                      // 0x3a
	.word	3                       // 0x3
	.word	356                     // 0x164
	.word	36                      // 0x24
	.word	279                     // 0x117
	.word	499                     // 0x1f3
	.word	104                     // 0x68
	.word	240                     // 0xf0
	.word	55                      // 0x37
	.word	61                      // 0x3d
	.word	447                     // 0x1bf
	.word	441                     // 0x1b9
	.word	372                     // 0x174
	.word	176                     // 0xb0
	.word	31                      // 0x1f
	.word	165                     // 0xa5
	.word	137                     // 0x89
	.word	498                     // 0x1f2
	.word	417                     // 0x1a1
	.word	54                      // 0x36
	.word	282                     // 0x11a
	.word	288                     // 0x120
	.word	451                     // 0x1c3
	.word	367                     // 0x16f
	.word	237                     // 0xed
	.word	23                      // 0x17
	.word	483                     // 0x1e3
	.word	164                     // 0xa4
	.word	71                      // 0x47
	.word	430                     // 0x1ae
	.word	292                     // 0x124
	.word	136                     // 0x88
	.word	208                     // 0xd0
	.word	415                     // 0x19f
	.word	472                     // 0x1d8
	.word	376                     // 0x178
	.word	327                     // 0x147
	.word	195                     // 0xc3
	.word	219                     // 0xdb
	.word	419                     // 0x1a3
	.word	312                     // 0x138
	.word	14                      // 0xe
	.word	198                     // 0xc6
	.word	347                     // 0x15b
	.word	219                     // 0xdb
	.word	358                     // 0x166
	.word	401                     // 0x191
	.word	159                     // 0x9f
	.word	216                     // 0xd8
	.word	94                      // 0x5e
	.word	406                     // 0x196
	.word	349                     // 0x15d
	.word	6                       // 0x6
	.word	340                     // 0x154
	.word	206                     // 0xce
	.word	35                      // 0x23
	.word	456                     // 0x1c8
	.word	363                     // 0x16b
	.word	12                      // 0xc
	.word	37                      // 0x25
	.word	392                     // 0x188
	.word	178                     // 0xb2
	.word	250                     // 0xfa
	.word	142                     // 0x8e
	.word	329                     // 0x149
	.word	389                     // 0x185
	.word	245                     // 0xf5
	.word	327                     // 0x147
	.word	262                     // 0x106
	.word	81                      // 0x51
	.word	78                      // 0x4e
	.word	62                      // 0x3e
	.word	508                     // 0x1fc
	.word	512                     // 0x200
	.word	500                     // 0x1f4
	.word	122                     // 0x7a
	.word	206                     // 0xce
	.word	77                      // 0x4d
	.word	249                     // 0xf9
	.word	377                     // 0x179
	.word	320                     // 0x140
	.word	209                     // 0xd1
	.word	123                     // 0x7b
	.word	416                     // 0x1a0
	.word	237                     // 0xed
	.word	253                     // 0xfd
	.word	185                     // 0xb9
	.word	154                     // 0x9a
	.word	184                     // 0xb8
	.word	353                     // 0x161
	.word	405                     // 0x195
	.word	143                     // 0x8f
	.word	323                     // 0x143
	.word	132                     // 0x84
	.word	317                     // 0x13d
	.word	155                     // 0x9b
	.word	142                     // 0x8e
	.word	250                     // 0xfa
	.word	477                     // 0x1dd
	.word	250                     // 0xfa
	.word	307                     // 0x133
	.word	417                     // 0x1a1
	.word	326                     // 0x146
	.word	190                     // 0xbe
	.word	397                     // 0x18d
	.word	71                      // 0x47
	.word	73                      // 0x49
	.word	326                     // 0x146
	.word	45                      // 0x2d
	.word	192                     // 0xc0
	.word	510                     // 0x1fe
	.word	376                     // 0x178
	.word	473                     // 0x1d9
	.word	61                      // 0x3d
	.word	20                      // 0x14
	.word	286                     // 0x11e
	.word	482                     // 0x1e2
	.word	178                     // 0xb2
	.word	507                     // 0x1fb
	.word	301                     // 0x12d
	.word	306                     // 0x132
	.word	319                     // 0x13f
	.word	90                      // 0x5a
	.word	197                     // 0xc5
	.word	334                     // 0x14e
	.word	119                     // 0x77
	.word	402                     // 0x192
	.word	66                      // 0x42
	.word	323                     // 0x143
	.word	445                     // 0x1bd
	.word	506                     // 0x1fa
	.word	473                     // 0x1d9
	.word	309                     // 0x135
	.word	236                     // 0xec
	.word	404                     // 0x194
	.word	245                     // 0xf5
	.word	354                     // 0x162
	.word	325                     // 0x145
	.word	188                     // 0xbc
	.word	387                     // 0x183
	.word	240                     // 0xf0
	.word	86                      // 0x56
	.word	84                      // 0x54
	.word	223                     // 0xdf
	.word	186                     // 0xba
	.word	14                      // 0xe
	.word	478                     // 0x1de
	.word	251                     // 0xfb
	.word	382                     // 0x17e
	.word	444                     // 0x1bc
	.word	151                     // 0x97
	.word	417                     // 0x1a1
	.word	163                     // 0xa3
	.word	490                     // 0x1ea
	.word	323                     // 0x143
	.word	253                     // 0xfd
	.word	368                     // 0x170
	.word	187                     // 0xbb
	.word	271                     // 0x10f
	.word	445                     // 0x1bd
	.word	473                     // 0x1d9
	.word	19                      // 0x13
	.word	222                     // 0xde
	.word	290                     // 0x122
	.word	350                     // 0x15e
	.word	285                     // 0x11d
	.word	372                     // 0x174
	.word	421                     // 0x1a5
	.word	30                      // 0x1e
	.word	380                     // 0x17c
	.word	250                     // 0xfa
	.word	75                      // 0x4b
	.word	476                     // 0x1dc
	.word	168                     // 0xa8
	.word	245                     // 0xf5
	.word	390                     // 0x186
	.word	86                      // 0x56
	.word	20                      // 0x14
	.word	363                     // 0x16b
	.word	165                     // 0xa5
	.word	151                     // 0x97
	.word	423                     // 0x1a7
	.word	117                     // 0x75
	.word	163                     // 0xa3
	.word	300                     // 0x12c
	.word	82                      // 0x52
	.word	173                     // 0xad
	.word	237                     // 0xed
	.word	87                      // 0x57
	.word	208                     // 0xd0
	.word	282                     // 0x11a
	.word	87                      // 0x57
	.word	181                     // 0xb5
	.word	481                     // 0x1e1
	.word	187                     // 0xbb
	.word	112                     // 0x70
	.word	169                     // 0xa9
	.word	69                      // 0x45
	.word	56                      // 0x38
	.word	131                     // 0x83
	.word	257                     // 0x101
	.word	24                      // 0x18
	.word	238                     // 0xee
	.word	78                      // 0x4e
	.word	470                     // 0x1d6
	.word	154                     // 0x9a
	.word	310                     // 0x136
	.word	197                     // 0xc5
	.word	481                     // 0x1e1
	.word	398                     // 0x18e
	.word	167                     // 0xa7
	.word	386                     // 0x182
	.word	366                     // 0x16e
	.word	49                      // 0x31
	.word	337                     // 0x151
	.word	66                      // 0x42
	.word	119                     // 0x77
	.word	490                     // 0x1ea
	.word	203                     // 0xcb
	.word	39                      // 0x27
	.word	317                     // 0x13d
	.word	97                      // 0x61
	.word	33                      // 0x21
	.word	414                     // 0x19e
	.word	464                     // 0x1d0
	.word	210                     // 0xd2
	.word	336                     // 0x150
	.word	489                     // 0x1e9
	.word	335                     // 0x14f
	.word	378                     // 0x17a
	.word	116                     // 0x74
	.word	363                     // 0x16b
	.word	328                     // 0x148
	.word	191                     // 0xbf
	.word	101                     // 0x65
	.word	407                     // 0x197
	.word	408                     // 0x198
	.word	259                     // 0x103
	.word	483                     // 0x1e3
	.word	51                      // 0x33
	.word	377                     // 0x179
	.word	223                     // 0xdf
	.size	nums1k1, 4096

	.type	nums1k2,@object         // @nums1k2
	.globl	nums1k2
	.align	2
nums1k2:
	.word	348                     // 0x15c
	.word	348                     // 0x15c
	.word	4                       // 0x4
	.word	379                     // 0x17b
	.word	124                     // 0x7c
	.word	157                     // 0x9d
	.word	325                     // 0x145
	.word	427                     // 0x1ab
	.word	423                     // 0x1a7
	.word	337                     // 0x151
	.word	460                     // 0x1cc
	.word	131                     // 0x83
	.word	240                     // 0xf0
	.word	232                     // 0xe8
	.word	165                     // 0xa5
	.word	278                     // 0x116
	.word	158                     // 0x9e
	.word	490                     // 0x1ea
	.word	101                     // 0x65
	.word	250                     // 0xfa
	.word	109                     // 0x6d
	.word	506                     // 0x1fa
	.word	332                     // 0x14c
	.word	245                     // 0xf5
	.word	462                     // 0x1ce
	.word	253                     // 0xfd
	.word	165                     // 0xa5
	.word	254                     // 0xfe
	.word	321                     // 0x141
	.word	390                     // 0x186
	.word	107                     // 0x6b
	.word	444                     // 0x1bc
	.word	498                     // 0x1f2
	.word	8                       // 0x8
	.word	360                     // 0x168
	.word	220                     // 0xdc
	.word	79                      // 0x4f
	.word	141                     // 0x8d
	.word	474                     // 0x1da
	.word	171                     // 0xab
	.word	271                     // 0x10f
	.word	243                     // 0xf3
	.word	96                      // 0x60
	.word	348                     // 0x15c
	.word	297                     // 0x129
	.word	181                     // 0xb5
	.word	466                     // 0x1d2
	.word	65                      // 0x41
	.word	100                     // 0x64
	.word	174                     // 0xae
	.word	360                     // 0x168
	.word	453                     // 0x1c5
	.word	207                     // 0xcf
	.word	414                     // 0x19e
	.word	190                     // 0xbe
	.word	134                     // 0x86
	.word	92                      // 0x5c
	.word	279                     // 0x117
	.word	464                     // 0x1d0
	.word	503                     // 0x1f7
	.word	158                     // 0x9e
	.word	159                     // 0x9f
	.word	98                      // 0x62
	.word	158                     // 0x9e
	.word	302                     // 0x12e
	.word	25                      // 0x19
	.word	188                     // 0xbc
	.word	337                     // 0x151
	.word	8                       // 0x8
	.word	98                      // 0x62
	.word	393                     // 0x189
	.word	90                      // 0x5a
	.word	396                     // 0x18c
	.word	504                     // 0x1f8
	.word	205                     // 0xcd
	.word	425                     // 0x1a9
	.word	175                     // 0xaf
	.word	439                     // 0x1b7
	.word	58                      // 0x3a
	.word	343                     // 0x157
	.word	247                     // 0xf7
	.word	113                     // 0x71
	.word	249                     // 0xf9
	.word	150                     // 0x96
	.word	348                     // 0x15c
	.word	24                      // 0x18
	.word	174                     // 0xae
	.word	376                     // 0x178
	.word	331                     // 0x14b
	.word	302                     // 0x12e
	.word	280                     // 0x118
	.word	251                     // 0xfb
	.word	510                     // 0x1fe
	.word	113                     // 0x71
	.word	241                     // 0xf1
	.word	507                     // 0x1fb
	.word	9                       // 0x9
	.word	389                     // 0x185
	.word	172                     // 0xac
	.word	214                     // 0xd6
	.word	253                     // 0xfd
	.word	497                     // 0x1f1
	.word	401                     // 0x191
	.word	243                     // 0xf3
	.word	7                       // 0x7
	.word	80                      // 0x50
	.word	499                     // 0x1f3
	.word	133                     // 0x85
	.word	208                     // 0xd0
	.word	477                     // 0x1dd
	.word	456                     // 0x1c8
	.word	376                     // 0x178
	.word	350                     // 0x15e
	.word	53                      // 0x35
	.word	466                     // 0x1d2
	.word	84                      // 0x54
	.word	261                     // 0x105
	.word	193                     // 0xc1
	.word	215                     // 0xd7
	.word	9                       // 0x9
	.word	509                     // 0x1fd
	.word	462                     // 0x1ce
	.word	378                     // 0x17a
	.word	363                     // 0x16b
	.word	154                     // 0x9a
	.word	482                     // 0x1e2
	.word	72                      // 0x48
	.word	266                     // 0x10a
	.word	465                     // 0x1d1
	.word	73                      // 0x49
	.word	460                     // 0x1cc
	.word	406                     // 0x196
	.word	454                     // 0x1c6
	.word	478                     // 0x1de
	.word	447                     // 0x1bf
	.word	94                      // 0x5e
	.word	283                     // 0x11b
	.word	107                     // 0x6b
	.word	483                     // 0x1e3
	.word	404                     // 0x194
	.word	48                      // 0x30
	.word	297                     // 0x129
	.word	207                     // 0xcf
	.word	47                      // 0x2f
	.word	435                     // 0x1b3
	.word	56                      // 0x38
	.word	416                     // 0x1a0
	.word	362                     // 0x16a
	.word	181                     // 0xb5
	.word	327                     // 0x147
	.word	36                      // 0x24
	.word	231                     // 0xe7
	.word	273                     // 0x111
	.word	48                      // 0x30
	.word	123                     // 0x7b
	.word	455                     // 0x1c7
	.word	319                     // 0x13f
	.word	358                     // 0x166
	.word	21                      // 0x15
	.word	153                     // 0x99
	.word	161                     // 0xa1
	.word	178                     // 0xb2
	.word	382                     // 0x17e
	.word	415                     // 0x19f
	.word	362                     // 0x16a
	.word	2                       // 0x2
	.word	116                     // 0x74
	.word	420                     // 0x1a4
	.word	197                     // 0xc5
	.word	60                      // 0x3c
	.word	205                     // 0xcd
	.word	16                      // 0x10
	.word	506                     // 0x1fa
	.word	109                     // 0x6d
	.word	60                      // 0x3c
	.word	135                     // 0x87
	.word	491                     // 0x1eb
	.word	414                     // 0x19e
	.word	150                     // 0x96
	.word	41                      // 0x29
	.word	342                     // 0x156
	.word	126                     // 0x7e
	.word	188                     // 0xbc
	.word	172                     // 0xac
	.word	348                     // 0x15c
	.word	383                     // 0x17f
	.word	475                     // 0x1db
	.word	454                     // 0x1c6
	.word	236                     // 0xec
	.word	461                     // 0x1cd
	.word	370                     // 0x172
	.word	113                     // 0x71
	.word	158                     // 0x9e
	.word	145                     // 0x91
	.word	157                     // 0x9d
	.word	17                      // 0x11
	.word	90                      // 0x5a
	.word	479                     // 0x1df
	.word	497                     // 0x1f1
	.word	384                     // 0x180
	.word	18                      // 0x12
	.word	92                      // 0x5c
	.word	471                     // 0x1d7
	.word	300                     // 0x12c
	.word	137                     // 0x89
	.word	230                     // 0xe6
	.word	105                     // 0x69
	.word	68                      // 0x44
	.word	128                     // 0x80
	.word	487                     // 0x1e7
	.word	125                     // 0x7d
	.word	9                       // 0x9
	.word	158                     // 0x9e
	.word	105                     // 0x69
	.word	4                       // 0x4
	.word	374                     // 0x176
	.word	202                     // 0xca
	.word	315                     // 0x13b
	.word	295                     // 0x127
	.word	11                      // 0xb
	.word	512                     // 0x200
	.word	247                     // 0xf7
	.word	276                     // 0x114
	.word	55                      // 0x37
	.word	52                      // 0x34
	.word	507                     // 0x1fb
	.word	390                     // 0x186
	.word	74                      // 0x4a
	.word	470                     // 0x1d6
	.word	16                      // 0x10
	.word	332                     // 0x14c
	.word	235                     // 0xeb
	.word	455                     // 0x1c7
	.word	374                     // 0x176
	.word	175                     // 0xaf
	.word	361                     // 0x169
	.word	414                     // 0x19e
	.word	143                     // 0x8f
	.word	481                     // 0x1e1
	.word	193                     // 0xc1
	.word	409                     // 0x199
	.word	212                     // 0xd4
	.word	361                     // 0x169
	.word	179                     // 0xb3
	.word	189                     // 0xbd
	.word	243                     // 0xf3
	.word	330                     // 0x14a
	.word	356                     // 0x164
	.word	503                     // 0x1f7
	.word	385                     // 0x181
	.word	397                     // 0x18d
	.word	110                     // 0x6e
	.word	486                     // 0x1e6
	.word	157                     // 0x9d
	.word	169                     // 0xa9
	.word	31                      // 0x1f
	.word	276                     // 0x114
	.word	455                     // 0x1c7
	.word	499                     // 0x1f3
	.word	161                     // 0xa1
	.word	43                      // 0x2b
	.word	315                     // 0x13b
	.word	264                     // 0x108
	.word	441                     // 0x1b9
	.word	242                     // 0xf2
	.word	145                     // 0x91
	.word	204                     // 0xcc
	.word	181                     // 0xb5
	.word	206                     // 0xce
	.word	83                      // 0x53
	.word	354                     // 0x162
	.word	446                     // 0x1be
	.word	86                      // 0x56
	.word	150                     // 0x96
	.word	338                     // 0x152
	.word	18                      // 0x12
	.word	488                     // 0x1e8
	.word	483                     // 0x1e3
	.word	297                     // 0x129
	.word	213                     // 0xd5
	.word	479                     // 0x1df
	.word	314                     // 0x13a
	.word	439                     // 0x1b7
	.word	353                     // 0x161
	.word	272                     // 0x110
	.word	4                       // 0x4
	.word	75                      // 0x4b
	.word	420                     // 0x1a4
	.word	143                     // 0x8f
	.word	413                     // 0x19d
	.word	153                     // 0x99
	.word	105                     // 0x69
	.word	376                     // 0x178
	.word	158                     // 0x9e
	.word	101                     // 0x65
	.word	327                     // 0x147
	.word	396                     // 0x18c
	.word	81                      // 0x51
	.word	427                     // 0x1ab
	.word	227                     // 0xe3
	.word	404                     // 0x194
	.word	48                      // 0x30
	.word	302                     // 0x12e
	.word	458                     // 0x1ca
	.word	446                     // 0x1be
	.word	422                     // 0x1a6
	.word	134                     // 0x86
	.word	42                      // 0x2a
	.word	132                     // 0x84
	.word	473                     // 0x1d9
	.word	197                     // 0xc5
	.word	258                     // 0x102
	.word	146                     // 0x92
	.word	99                      // 0x63
	.word	220                     // 0xdc
	.word	434                     // 0x1b2
	.word	381                     // 0x17d
	.word	489                     // 0x1e9
	.word	365                     // 0x16d
	.word	315                     // 0x13b
	.word	280                     // 0x118
	.word	437                     // 0x1b5
	.word	284                     // 0x11c
	.word	99                      // 0x63
	.word	388                     // 0x184
	.word	247                     // 0xf7
	.word	494                     // 0x1ee
	.word	477                     // 0x1dd
	.word	122                     // 0x7a
	.word	470                     // 0x1d6
	.word	42                      // 0x2a
	.word	47                      // 0x2f
	.word	130                     // 0x82
	.word	17                      // 0x11
	.word	484                     // 0x1e4
	.word	421                     // 0x1a5
	.word	268                     // 0x10c
	.word	390                     // 0x186
	.word	490                     // 0x1ea
	.word	317                     // 0x13d
	.word	417                     // 0x1a1
	.word	205                     // 0xcd
	.word	220                     // 0xdc
	.word	242                     // 0xf2
	.word	477                     // 0x1dd
	.word	508                     // 0x1fc
	.word	196                     // 0xc4
	.word	415                     // 0x19f
	.word	5                       // 0x5
	.word	144                     // 0x90
	.word	479                     // 0x1df
	.word	34                      // 0x22
	.word	117                     // 0x75
	.word	472                     // 0x1d8
	.word	309                     // 0x135
	.word	456                     // 0x1c8
	.word	72                      // 0x48
	.word	393                     // 0x189
	.word	51                      // 0x33
	.word	295                     // 0x127
	.word	407                     // 0x197
	.word	155                     // 0x9b
	.word	128                     // 0x80
	.word	47                      // 0x2f
	.word	400                     // 0x190
	.word	42                      // 0x2a
	.word	424                     // 0x1a8
	.word	168                     // 0xa8
	.word	231                     // 0xe7
	.word	468                     // 0x1d4
	.word	24                      // 0x18
	.word	467                     // 0x1d3
	.word	226                     // 0xe2
	.word	389                     // 0x185
	.word	68                      // 0x44
	.word	403                     // 0x193
	.word	502                     // 0x1f6
	.word	253                     // 0xfd
	.word	409                     // 0x199
	.word	505                     // 0x1f9
	.word	333                     // 0x14d
	.word	142                     // 0x8e
	.word	203                     // 0xcb
	.word	161                     // 0xa1
	.word	426                     // 0x1aa
	.word	322                     // 0x142
	.word	329                     // 0x149
	.word	130                     // 0x82
	.word	114                     // 0x72
	.word	398                     // 0x18e
	.word	302                     // 0x12e
	.word	306                     // 0x132
	.word	268                     // 0x10c
	.word	282                     // 0x11a
	.word	168                     // 0xa8
	.word	35                      // 0x23
	.word	214                     // 0xd6
	.word	28                      // 0x1c
	.word	355                     // 0x163
	.word	366                     // 0x16e
	.word	208                     // 0xd0
	.word	320                     // 0x140
	.word	418                     // 0x1a2
	.word	20                      // 0x14
	.word	239                     // 0xef
	.word	216                     // 0xd8
	.word	277                     // 0x115
	.word	343                     // 0x157
	.word	33                      // 0x21
	.word	250                     // 0xfa
	.word	28                      // 0x1c
	.word	339                     // 0x153
	.word	151                     // 0x97
	.word	232                     // 0xe8
	.word	336                     // 0x150
	.word	124                     // 0x7c
	.word	36                      // 0x24
	.word	203                     // 0xcb
	.word	376                     // 0x178
	.word	225                     // 0xe1
	.word	114                     // 0x72
	.word	390                     // 0x186
	.word	241                     // 0xf1
	.word	408                     // 0x198
	.word	246                     // 0xf6
	.word	21                      // 0x15
	.word	246                     // 0xf6
	.word	412                     // 0x19c
	.word	421                     // 0x1a5
	.word	419                     // 0x1a3
	.word	472                     // 0x1d8
	.word	454                     // 0x1c6
	.word	239                     // 0xef
	.word	162                     // 0xa2
	.word	482                     // 0x1e2
	.word	262                     // 0x106
	.word	132                     // 0x84
	.word	506                     // 0x1fa
	.word	305                     // 0x131
	.word	239                     // 0xef
	.word	341                     // 0x155
	.word	247                     // 0xf7
	.word	253                     // 0xfd
	.word	338                     // 0x152
	.word	200                     // 0xc8
	.word	37                      // 0x25
	.word	86                      // 0x56
	.word	66                      // 0x42
	.word	49                      // 0x31
	.word	458                     // 0x1ca
	.word	21                      // 0x15
	.word	89                      // 0x59
	.word	54                      // 0x36
	.word	299                     // 0x12b
	.word	86                      // 0x56
	.word	26                      // 0x1a
	.word	417                     // 0x1a1
	.word	143                     // 0x8f
	.word	275                     // 0x113
	.word	226                     // 0xe2
	.word	325                     // 0x145
	.word	56                      // 0x38
	.word	183                     // 0xb7
	.word	435                     // 0x1b3
	.word	262                     // 0x106
	.word	506                     // 0x1fa
	.word	181                     // 0xb5
	.word	228                     // 0xe4
	.word	197                     // 0xc5
	.word	270                     // 0x10e
	.word	339                     // 0x153
	.word	153                     // 0x99
	.word	364                     // 0x16c
	.word	471                     // 0x1d7
	.word	283                     // 0x11b
	.word	508                     // 0x1fc
	.word	510                     // 0x1fe
	.word	167                     // 0xa7
	.word	337                     // 0x151
	.word	462                     // 0x1ce
	.word	41                      // 0x29
	.word	338                     // 0x152
	.word	388                     // 0x184
	.word	106                     // 0x6a
	.word	162                     // 0xa2
	.word	439                     // 0x1b7
	.word	473                     // 0x1d9
	.word	505                     // 0x1f9
	.word	16                      // 0x10
	.word	87                      // 0x57
	.word	338                     // 0x152
	.word	48                      // 0x30
	.word	504                     // 0x1f8
	.word	402                     // 0x192
	.word	261                     // 0x105
	.word	376                     // 0x178
	.word	317                     // 0x13d
	.word	117                     // 0x75
	.word	345                     // 0x159
	.word	388                     // 0x184
	.word	374                     // 0x176
	.word	109                     // 0x6d
	.word	272                     // 0x110
	.word	301                     // 0x12d
	.word	398                     // 0x18e
	.word	435                     // 0x1b3
	.word	348                     // 0x15c
	.word	482                     // 0x1e2
	.word	438                     // 0x1b6
	.word	239                     // 0xef
	.word	272                     // 0x110
	.word	52                      // 0x34
	.word	85                      // 0x55
	.word	454                     // 0x1c6
	.word	349                     // 0x15d
	.word	475                     // 0x1db
	.word	46                      // 0x2e
	.word	188                     // 0xbc
	.word	85                      // 0x55
	.word	92                      // 0x5c
	.word	246                     // 0xf6
	.word	432                     // 0x1b0
	.word	398                     // 0x18e
	.word	169                     // 0xa9
	.word	477                     // 0x1dd
	.word	126                     // 0x7e
	.word	291                     // 0x123
	.word	158                     // 0x9e
	.word	141                     // 0x8d
	.word	143                     // 0x8f
	.word	199                     // 0xc7
	.word	415                     // 0x19f
	.word	144                     // 0x90
	.word	152                     // 0x98
	.word	329                     // 0x149
	.word	67                      // 0x43
	.word	286                     // 0x11e
	.word	347                     // 0x15b
	.word	126                     // 0x7e
	.word	290                     // 0x122
	.word	148                     // 0x94
	.word	421                     // 0x1a5
	.word	273                     // 0x111
	.word	342                     // 0x156
	.word	13                      // 0xd
	.word	205                     // 0xcd
	.word	424                     // 0x1a8
	.word	269                     // 0x10d
	.word	117                     // 0x75
	.word	155                     // 0x9b
	.word	42                      // 0x2a
	.word	99                      // 0x63
	.word	262                     // 0x106
	.word	343                     // 0x157
	.word	359                     // 0x167
	.word	16                      // 0x10
	.word	320                     // 0x140
	.word	466                     // 0x1d2
	.word	182                     // 0xb6
	.word	443                     // 0x1bb
	.word	412                     // 0x19c
	.word	435                     // 0x1b3
	.word	335                     // 0x14f
	.word	70                      // 0x46
	.word	494                     // 0x1ee
	.word	373                     // 0x175
	.word	463                     // 0x1cf
	.word	506                     // 0x1fa
	.word	66                      // 0x42
	.word	476                     // 0x1dc
	.word	338                     // 0x152
	.word	261                     // 0x105
	.word	223                     // 0xdf
	.word	505                     // 0x1f9
	.word	432                     // 0x1b0
	.word	400                     // 0x190
	.word	478                     // 0x1de
	.word	408                     // 0x198
	.word	99                      // 0x63
	.word	470                     // 0x1d6
	.word	331                     // 0x14b
	.word	202                     // 0xca
	.word	272                     // 0x110
	.word	362                     // 0x16a
	.word	430                     // 0x1ae
	.word	292                     // 0x124
	.word	243                     // 0xf3
	.word	158                     // 0x9e
	.word	499                     // 0x1f3
	.word	266                     // 0x10a
	.word	200                     // 0xc8
	.word	413                     // 0x19d
	.word	94                      // 0x5e
	.word	142                     // 0x8e
	.word	451                     // 0x1c3
	.word	231                     // 0xe7
	.word	414                     // 0x19e
	.word	151                     // 0x97
	.word	294                     // 0x126
	.word	154                     // 0x9a
	.word	264                     // 0x108
	.word	478                     // 0x1de
	.word	10                      // 0xa
	.word	28                      // 0x1c
	.word	150                     // 0x96
	.word	352                     // 0x160
	.word	390                     // 0x186
	.word	337                     // 0x151
	.word	67                      // 0x43
	.word	185                     // 0xb9
	.word	30                      // 0x1e
	.word	137                     // 0x89
	.word	410                     // 0x19a
	.word	113                     // 0x71
	.word	258                     // 0x102
	.word	332                     // 0x14c
	.word	174                     // 0xae
	.word	508                     // 0x1fc
	.word	296                     // 0x128
	.word	94                      // 0x5e
	.word	132                     // 0x84
	.word	202                     // 0xca
	.word	306                     // 0x132
	.word	452                     // 0x1c4
	.word	185                     // 0xb9
	.word	113                     // 0x71
	.word	409                     // 0x199
	.word	193                     // 0xc1
	.word	364                     // 0x16c
	.word	29                      // 0x1d
	.word	210                     // 0xd2
	.word	206                     // 0xce
	.word	127                     // 0x7f
	.word	244                     // 0xf4
	.word	177                     // 0xb1
	.word	394                     // 0x18a
	.word	282                     // 0x11a
	.word	329                     // 0x149
	.word	317                     // 0x13d
	.word	482                     // 0x1e2
	.word	384                     // 0x180
	.word	450                     // 0x1c2
	.word	150                     // 0x96
	.word	450                     // 0x1c2
	.word	295                     // 0x127
	.word	346                     // 0x15a
	.word	191                     // 0xbf
	.word	99                      // 0x63
	.word	63                      // 0x3f
	.word	362                     // 0x16a
	.word	59                      // 0x3b
	.word	50                      // 0x32
	.word	470                     // 0x1d6
	.word	235                     // 0xeb
	.word	360                     // 0x168
	.word	443                     // 0x1bb
	.word	352                     // 0x160
	.word	392                     // 0x188
	.word	134                     // 0x86
	.word	510                     // 0x1fe
	.word	511                     // 0x1ff
	.word	318                     // 0x13e
	.word	303                     // 0x12f
	.word	113                     // 0x71
	.word	79                      // 0x4f
	.word	84                      // 0x54
	.word	170                     // 0xaa
	.word	143                     // 0x8f
	.word	135                     // 0x87
	.word	266                     // 0x10a
	.word	326                     // 0x146
	.word	69                      // 0x45
	.word	12                      // 0xc
	.word	330                     // 0x14a
	.word	82                      // 0x52
	.word	504                     // 0x1f8
	.word	492                     // 0x1ec
	.word	174                     // 0xae
	.word	455                     // 0x1c7
	.word	228                     // 0xe4
	.word	175                     // 0xaf
	.word	446                     // 0x1be
	.word	61                      // 0x3d
	.word	405                     // 0x195
	.word	444                     // 0x1bc
	.word	451                     // 0x1c3
	.word	97                      // 0x61
	.word	241                     // 0xf1
	.word	498                     // 0x1f2
	.word	239                     // 0xef
	.word	278                     // 0x116
	.word	478                     // 0x1de
	.word	401                     // 0x191
	.word	154                     // 0x9a
	.word	223                     // 0xdf
	.word	231                     // 0xe7
	.word	445                     // 0x1bd
	.word	251                     // 0xfb
	.word	83                      // 0x53
	.word	374                     // 0x176
	.word	121                     // 0x79
	.word	506                     // 0x1fa
	.word	16                      // 0x10
	.word	291                     // 0x123
	.word	202                     // 0xca
	.word	104                     // 0x68
	.word	456                     // 0x1c8
	.word	124                     // 0x7c
	.word	445                     // 0x1bd
	.word	104                     // 0x68
	.word	223                     // 0xdf
	.word	312                     // 0x138
	.word	437                     // 0x1b5
	.word	462                     // 0x1ce
	.word	491                     // 0x1eb
	.word	403                     // 0x193
	.word	229                     // 0xe5
	.word	89                      // 0x59
	.word	466                     // 0x1d2
	.word	41                      // 0x29
	.word	427                     // 0x1ab
	.word	274                     // 0x112
	.word	380                     // 0x17c
	.word	27                      // 0x1b
	.word	484                     // 0x1e4
	.word	328                     // 0x148
	.word	341                     // 0x155
	.word	344                     // 0x158
	.word	5                       // 0x5
	.word	479                     // 0x1df
	.word	137                     // 0x89
	.word	127                     // 0x7f
	.word	86                      // 0x56
	.word	271                     // 0x10f
	.word	94                      // 0x5e
	.word	442                     // 0x1ba
	.word	140                     // 0x8c
	.word	466                     // 0x1d2
	.word	431                     // 0x1af
	.word	485                     // 0x1e5
	.word	427                     // 0x1ab
	.word	324                     // 0x144
	.word	297                     // 0x129
	.word	150                     // 0x96
	.word	237                     // 0xed
	.word	43                      // 0x2b
	.word	271                     // 0x10f
	.word	255                     // 0xff
	.word	24                      // 0x18
	.word	470                     // 0x1d6
	.word	10                      // 0xa
	.word	503                     // 0x1f7
	.word	344                     // 0x158
	.word	488                     // 0x1e8
	.word	511                     // 0x1ff
	.word	431                     // 0x1af
	.word	490                     // 0x1ea
	.word	270                     // 0x10e
	.word	317                     // 0x13d
	.word	180                     // 0xb4
	.word	334                     // 0x14e
	.word	434                     // 0x1b2
	.word	254                     // 0xfe
	.word	203                     // 0xcb
	.word	110                     // 0x6e
	.word	426                     // 0x1aa
	.word	450                     // 0x1c2
	.word	175                     // 0xaf
	.word	145                     // 0x91
	.word	220                     // 0xdc
	.word	411                     // 0x19b
	.word	478                     // 0x1de
	.word	156                     // 0x9c
	.word	271                     // 0x10f
	.word	483                     // 0x1e3
	.word	319                     // 0x13f
	.word	81                      // 0x51
	.word	149                     // 0x95
	.word	175                     // 0xaf
	.word	424                     // 0x1a8
	.word	165                     // 0xa5
	.word	326                     // 0x146
	.word	512                     // 0x200
	.word	53                      // 0x35
	.word	108                     // 0x6c
	.word	432                     // 0x1b0
	.word	217                     // 0xd9
	.word	146                     // 0x92
	.word	107                     // 0x6b
	.word	108                     // 0x6c
	.word	401                     // 0x191
	.word	339                     // 0x153
	.word	412                     // 0x19c
	.word	336                     // 0x150
	.word	211                     // 0xd3
	.word	68                      // 0x44
	.word	120                     // 0x78
	.word	153                     // 0x99
	.word	415                     // 0x19f
	.word	314                     // 0x13a
	.word	307                     // 0x133
	.word	26                      // 0x1a
	.word	374                     // 0x176
	.word	458                     // 0x1ca
	.word	8                       // 0x8
	.word	226                     // 0xe2
	.word	49                      // 0x31
	.word	458                     // 0x1ca
	.word	8                       // 0x8
	.word	369                     // 0x171
	.word	43                      // 0x2b
	.word	205                     // 0xcd
	.word	241                     // 0xf1
	.word	471                     // 0x1d7
	.word	73                      // 0x49
	.word	363                     // 0x16b
	.word	203                     // 0xcb
	.word	443                     // 0x1bb
	.word	457                     // 0x1c9
	.word	186                     // 0xba
	.word	102                     // 0x66
	.word	405                     // 0x195
	.word	343                     // 0x157
	.word	190                     // 0xbe
	.word	84                      // 0x54
	.word	43                      // 0x2b
	.word	13                      // 0xd
	.word	379                     // 0x17b
	.word	89                      // 0x59
	.word	43                      // 0x2b
	.word	435                     // 0x1b3
	.word	164                     // 0xa4
	.word	89                      // 0x59
	.word	111                     // 0x6f
	.word	135                     // 0x87
	.word	446                     // 0x1be
	.word	186                     // 0xba
	.word	120                     // 0x78
	.word	149                     // 0x95
	.word	165                     // 0xa5
	.word	264                     // 0x108
	.word	23                      // 0x17
	.word	15                      // 0xf
	.word	254                     // 0xfe
	.word	309                     // 0x135
	.word	376                     // 0x178
	.word	301                     // 0x12d
	.word	149                     // 0x95
	.word	93                      // 0x5d
	.word	415                     // 0x19f
	.word	205                     // 0xcd
	.word	245                     // 0xf5
	.word	74                      // 0x4a
	.word	304                     // 0x130
	.word	163                     // 0xa3
	.word	256                     // 0x100
	.word	7                       // 0x7
	.word	7                       // 0x7
	.word	188                     // 0xbc
	.word	182                     // 0xb6
	.word	316                     // 0x13c
	.word	11                      // 0xb
	.word	52                      // 0x34
	.word	380                     // 0x17c
	.word	246                     // 0xf6
	.word	305                     // 0x131
	.word	228                     // 0xe4
	.word	429                     // 0x1ad
	.word	87                      // 0x57
	.word	422                     // 0x1a6
	.word	368                     // 0x170
	.word	85                      // 0x55
	.word	28                      // 0x1c
	.word	271                     // 0x10f
	.word	423                     // 0x1a7
	.word	81                      // 0x51
	.word	44                      // 0x2c
	.word	128                     // 0x80
	.word	456                     // 0x1c8
	.word	365                     // 0x16d
	.word	353                     // 0x161
	.word	20                      // 0x14
	.word	75                      // 0x4b
	.word	131                     // 0x83
	.word	376                     // 0x178
	.word	40                      // 0x28
	.word	495                     // 0x1ef
	.word	273                     // 0x111
	.word	143                     // 0x8f
	.word	306                     // 0x132
	.word	352                     // 0x160
	.word	13                      // 0xd
	.word	491                     // 0x1eb
	.word	429                     // 0x1ad
	.word	391                     // 0x187
	.word	395                     // 0x18b
	.word	502                     // 0x1f6
	.word	72                      // 0x48
	.word	391                     // 0x187
	.word	71                      // 0x47
	.word	271                     // 0x10f
	.word	467                     // 0x1d3
	.word	397                     // 0x18d
	.word	95                      // 0x5f
	.word	438                     // 0x1b6
	.word	475                     // 0x1db
	.word	118                     // 0x76
	.word	485                     // 0x1e5
	.word	427                     // 0x1ab
	.word	160                     // 0xa0
	.word	34                      // 0x22
	.word	149                     // 0x95
	.word	165                     // 0xa5
	.word	90                      // 0x5a
	.word	377                     // 0x179
	.word	8                       // 0x8
	.word	405                     // 0x195
	.word	42                      // 0x2a
	.word	50                      // 0x32
	.word	160                     // 0xa0
	.word	501                     // 0x1f5
	.word	22                      // 0x16
	.word	24                      // 0x18
	.word	185                     // 0xb9
	.word	172                     // 0xac
	.word	402                     // 0x192
	.word	123                     // 0x7b
	.word	247                     // 0xf7
	.word	479                     // 0x1df
	.word	183                     // 0xb7
	.word	10                      // 0xa
	.word	440                     // 0x1b8
	.word	403                     // 0x193
	.word	43                      // 0x2b
	.word	103                     // 0x67
	.word	204                     // 0xcc
	.word	428                     // 0x1ac
	.word	300                     // 0x12c
	.word	253                     // 0xfd
	.word	312                     // 0x138
	.word	217                     // 0xd9
	.word	384                     // 0x180
	.word	254                     // 0xfe
	.word	16                      // 0x10
	.word	375                     // 0x177
	.word	212                     // 0xd4
	.word	418                     // 0x1a2
	.word	312                     // 0x138
	.word	301                     // 0x12d
	.word	214                     // 0xd6
	.word	55                      // 0x37
	.word	11                      // 0xb
	.word	509                     // 0x1fd
	.word	362                     // 0x16a
	.word	200                     // 0xc8
	.word	224                     // 0xe0
	.word	484                     // 0x1e4
	.word	136                     // 0x88
	.word	475                     // 0x1db
	.word	477                     // 0x1dd
	.word	266                     // 0x10a
	.word	410                     // 0x19a
	.word	244                     // 0xf4
	.word	256                     // 0x100
	.word	217                     // 0xd9
	.word	372                     // 0x174
	.word	460                     // 0x1cc
	.word	497                     // 0x1f1
	.word	3                       // 0x3
	.word	316                     // 0x13c
	.word	477                     // 0x1dd
	.word	474                     // 0x1da
	.word	61                      // 0x3d
	.word	462                     // 0x1ce
	.word	332                     // 0x14c
	.word	111                     // 0x6f
	.word	183                     // 0xb7
	.word	478                     // 0x1de
	.word	29                      // 0x1d
	.word	365                     // 0x16d
	.word	511                     // 0x1ff
	.word	421                     // 0x1a5
	.word	453                     // 0x1c5
	.word	287                     // 0x11f
	.word	141                     // 0x8d
	.word	177                     // 0xb1
	.word	100                     // 0x64
	.word	81                      // 0x51
	.word	266                     // 0x10a
	.word	451                     // 0x1c3
	.word	235                     // 0xeb
	.word	235                     // 0xeb
	.word	198                     // 0xc6
	.word	262                     // 0x106
	.word	409                     // 0x199
	.word	207                     // 0xcf
	.word	269                     // 0x10d
	.word	493                     // 0x1ed
	.word	192                     // 0xc0
	.word	482                     // 0x1e2
	.word	43                      // 0x2b
	.word	312                     // 0x138
	.word	492                     // 0x1ec
	.word	261                     // 0x105
	.word	10                      // 0xa
	.word	245                     // 0xf5
	.word	221                     // 0xdd
	.word	106                     // 0x6a
	.word	288                     // 0x120
	.word	58                      // 0x3a
	.word	444                     // 0x1bc
	.word	110                     // 0x6e
	.word	6                       // 0x6
	.word	10                      // 0xa
	.word	373                     // 0x175
	.word	211                     // 0xd3
	.word	323                     // 0x143
	.word	159                     // 0x9f
	.word	274                     // 0x112
	.word	210                     // 0xd2
	.word	209                     // 0xd1
	.word	314                     // 0x13a
	.word	78                      // 0x4e
	.word	75                      // 0x4b
	.size	nums1k2, 4096


	.ident	"clang version 3.5.0 "
