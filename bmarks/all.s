
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
	.file	"fac_rec.c"
	.text
	.align	2
	.global	fac
	.type	fac, %function
fac:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #1
	ble	.L2
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	mov	r0, r3
	bl	fac
	mov	r2, r0
	ldr	r3, [fp, #-8]
	mul	r3, r3, r2
	b	.L4
.L2:
	mov	r3, #1
.L4:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	ldmfd	sp!, {fp, pc}
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
	.file	"qsort.c"
	.global	nums1k1
	.data
	.align	2
	.type	nums1k1, %object
	.size	nums1k1, 4096
nums1k1:
	.word	364
	.word	286
	.word	278
	.word	283
	.word	154
	.word	477
	.word	369
	.word	480
	.word	40
	.word	382
	.word	153
	.word	293
	.word	488
	.word	35
	.word	225
	.word	172
	.word	4
	.word	443
	.word	411
	.word	429
	.word	131
	.word	490
	.word	91
	.word	89
	.word	495
	.word	426
	.word	290
	.word	411
	.word	423
	.word	493
	.word	139
	.word	414
	.word	303
	.word	485
	.word	327
	.word	44
	.word	430
	.word	129
	.word	153
	.word	331
	.word	138
	.word	206
	.word	284
	.word	461
	.word	428
	.word	473
	.word	297
	.word	90
	.word	260
	.word	317
	.word	241
	.word	135
	.word	297
	.word	386
	.word	83
	.word	481
	.word	456
	.word	116
	.word	95
	.word	47
	.word	317
	.word	31
	.word	337
	.word	29
	.word	383
	.word	417
	.word	268
	.word	134
	.word	277
	.word	402
	.word	432
	.word	493
	.word	119
	.word	352
	.word	70
	.word	459
	.word	188
	.word	329
	.word	249
	.word	287
	.word	165
	.word	384
	.word	149
	.word	371
	.word	89
	.word	285
	.word	179
	.word	133
	.word	134
	.word	219
	.word	20
	.word	11
	.word	379
	.word	295
	.word	36
	.word	380
	.word	158
	.word	80
	.word	440
	.word	335
	.word	47
	.word	182
	.word	415
	.word	452
	.word	340
	.word	57
	.word	468
	.word	182
	.word	249
	.word	106
	.word	259
	.word	276
	.word	487
	.word	175
	.word	510
	.word	63
	.word	6
	.word	122
	.word	68
	.word	34
	.word	271
	.word	74
	.word	18
	.word	126
	.word	331
	.word	435
	.word	329
	.word	60
	.word	193
	.word	75
	.word	94
	.word	128
	.word	143
	.word	143
	.word	242
	.word	423
	.word	360
	.word	249
	.word	92
	.word	342
	.word	14
	.word	270
	.word	417
	.word	110
	.word	27
	.word	160
	.word	500
	.word	428
	.word	146
	.word	103
	.word	403
	.word	304
	.word	362
	.word	331
	.word	35
	.word	392
	.word	320
	.word	330
	.word	369
	.word	34
	.word	508
	.word	405
	.word	306
	.word	338
	.word	177
	.word	220
	.word	451
	.word	369
	.word	278
	.word	37
	.word	151
	.word	378
	.word	468
	.word	486
	.word	85
	.word	206
	.word	258
	.word	169
	.word	496
	.word	505
	.word	99
	.word	216
	.word	367
	.word	99
	.word	455
	.word	301
	.word	386
	.word	447
	.word	354
	.word	430
	.word	6
	.word	266
	.word	204
	.word	59
	.word	276
	.word	11
	.word	148
	.word	506
	.word	486
	.word	459
	.word	391
	.word	36
	.word	428
	.word	54
	.word	53
	.word	453
	.word	221
	.word	503
	.word	399
	.word	330
	.word	347
	.word	487
	.word	1
	.word	278
	.word	155
	.word	221
	.word	278
	.word	328
	.word	371
	.word	150
	.word	159
	.word	228
	.word	406
	.word	101
	.word	126
	.word	215
	.word	128
	.word	26
	.word	487
	.word	339
	.word	146
	.word	24
	.word	402
	.word	97
	.word	281
	.word	320
	.word	214
	.word	151
	.word	271
	.word	363
	.word	300
	.word	501
	.word	274
	.word	41
	.word	112
	.word	306
	.word	507
	.word	293
	.word	342
	.word	282
	.word	173
	.word	477
	.word	317
	.word	176
	.word	271
	.word	327
	.word	436
	.word	117
	.word	199
	.word	276
	.word	414
	.word	485
	.word	273
	.word	76
	.word	307
	.word	267
	.word	215
	.word	327
	.word	379
	.word	315
	.word	431
	.word	313
	.word	377
	.word	261
	.word	117
	.word	195
	.word	245
	.word	153
	.word	54
	.word	427
	.word	340
	.word	485
	.word	414
	.word	318
	.word	213
	.word	491
	.word	159
	.word	511
	.word	128
	.word	312
	.word	463
	.word	297
	.word	35
	.word	273
	.word	31
	.word	272
	.word	239
	.word	101
	.word	235
	.word	234
	.word	238
	.word	308
	.word	325
	.word	397
	.word	155
	.word	163
	.word	146
	.word	499
	.word	273
	.word	28
	.word	280
	.word	374
	.word	32
	.word	400
	.word	314
	.word	21
	.word	340
	.word	7
	.word	231
	.word	390
	.word	258
	.word	431
	.word	192
	.word	469
	.word	14
	.word	293
	.word	418
	.word	140
	.word	481
	.word	302
	.word	440
	.word	68
	.word	303
	.word	499
	.word	387
	.word	169
	.word	4
	.word	166
	.word	363
	.word	388
	.word	160
	.word	428
	.word	469
	.word	361
	.word	66
	.word	458
	.word	92
	.word	315
	.word	90
	.word	331
	.word	422
	.word	249
	.word	344
	.word	496
	.word	151
	.word	295
	.word	167
	.word	297
	.word	430
	.word	309
	.word	391
	.word	158
	.word	185
	.word	91
	.word	440
	.word	275
	.word	477
	.word	362
	.word	283
	.word	88
	.word	487
	.word	341
	.word	423
	.word	96
	.word	391
	.word	419
	.word	106
	.word	110
	.word	143
	.word	319
	.word	197
	.word	330
	.word	212
	.word	403
	.word	505
	.word	1
	.word	147
	.word	223
	.word	343
	.word	41
	.word	24
	.word	357
	.word	457
	.word	90
	.word	318
	.word	21
	.word	263
	.word	371
	.word	434
	.word	82
	.word	242
	.word	7
	.word	394
	.word	245
	.word	329
	.word	352
	.word	290
	.word	241
	.word	134
	.word	35
	.word	143
	.word	429
	.word	132
	.word	328
	.word	22
	.word	298
	.word	424
	.word	258
	.word	219
	.word	355
	.word	273
	.word	101
	.word	119
	.word	55
	.word	264
	.word	188
	.word	363
	.word	413
	.word	263
	.word	11
	.word	392
	.word	285
	.word	433
	.word	322
	.word	443
	.word	502
	.word	153
	.word	304
	.word	293
	.word	42
	.word	273
	.word	450
	.word	400
	.word	147
	.word	466
	.word	61
	.word	311
	.word	204
	.word	107
	.word	233
	.word	206
	.word	373
	.word	430
	.word	374
	.word	242
	.word	498
	.word	301
	.word	391
	.word	247
	.word	120
	.word	286
	.word	261
	.word	299
	.word	395
	.word	117
	.word	457
	.word	428
	.word	386
	.word	492
	.word	213
	.word	28
	.word	231
	.word	80
	.word	181
	.word	30
	.word	498
	.word	197
	.word	71
	.word	301
	.word	144
	.word	27
	.word	209
	.word	124
	.word	82
	.word	397
	.word	22
	.word	358
	.word	296
	.word	341
	.word	468
	.word	184
	.word	140
	.word	265
	.word	448
	.word	408
	.word	185
	.word	396
	.word	193
	.word	444
	.word	439
	.word	456
	.word	152
	.word	422
	.word	32
	.word	505
	.word	46
	.word	351
	.word	67
	.word	89
	.word	136
	.word	261
	.word	64
	.word	469
	.word	174
	.word	252
	.word	431
	.word	504
	.word	486
	.word	260
	.word	7
	.word	283
	.word	313
	.word	201
	.word	226
	.word	183
	.word	396
	.word	212
	.word	340
	.word	342
	.word	178
	.word	255
	.word	78
	.word	25
	.word	18
	.word	250
	.word	57
	.word	67
	.word	96
	.word	88
	.word	477
	.word	16
	.word	379
	.word	476
	.word	241
	.word	428
	.word	124
	.word	220
	.word	6
	.word	230
	.word	34
	.word	226
	.word	409
	.word	304
	.word	501
	.word	99
	.word	265
	.word	257
	.word	351
	.word	237
	.word	326
	.word	137
	.word	312
	.word	272
	.word	471
	.word	218
	.word	154
	.word	199
	.word	212
	.word	141
	.word	93
	.word	433
	.word	210
	.word	370
	.word	506
	.word	117
	.word	499
	.word	328
	.word	357
	.word	141
	.word	27
	.word	144
	.word	162
	.word	54
	.word	435
	.word	361
	.word	447
	.word	478
	.word	400
	.word	434
	.word	2
	.word	77
	.word	401
	.word	79
	.word	313
	.word	454
	.word	177
	.word	164
	.word	415
	.word	100
	.word	87
	.word	36
	.word	101
	.word	190
	.word	294
	.word	378
	.word	471
	.word	230
	.word	49
	.word	231
	.word	56
	.word	238
	.word	45
	.word	1
	.word	73
	.word	372
	.word	322
	.word	229
	.word	336
	.word	338
	.word	53
	.word	144
	.word	491
	.word	233
	.word	440
	.word	200
	.word	35
	.word	74
	.word	108
	.word	106
	.word	448
	.word	313
	.word	324
	.word	126
	.word	157
	.word	283
	.word	405
	.word	305
	.word	237
	.word	177
	.word	354
	.word	386
	.word	318
	.word	60
	.word	145
	.word	299
	.word	468
	.word	23
	.word	314
	.word	6
	.word	145
	.word	103
	.word	482
	.word	129
	.word	98
	.word	220
	.word	67
	.word	114
	.word	211
	.word	265
	.word	83
	.word	398
	.word	168
	.word	92
	.word	200
	.word	55
	.word	71
	.word	39
	.word	459
	.word	146
	.word	252
	.word	277
	.word	376
	.word	240
	.word	232
	.word	475
	.word	297
	.word	375
	.word	385
	.word	253
	.word	388
	.word	299
	.word	174
	.word	216
	.word	243
	.word	42
	.word	144
	.word	61
	.word	336
	.word	413
	.word	338
	.word	138
	.word	133
	.word	302
	.word	202
	.word	138
	.word	78
	.word	167
	.word	101
	.word	486
	.word	131
	.word	476
	.word	282
	.word	29
	.word	402
	.word	46
	.word	57
	.word	510
	.word	418
	.word	432
	.word	78
	.word	214
	.word	224
	.word	243
	.word	121
	.word	78
	.word	378
	.word	259
	.word	314
	.word	246
	.word	291
	.word	346
	.word	239
	.word	5
	.word	162
	.word	288
	.word	42
	.word	32
	.word	286
	.word	267
	.word	67
	.word	103
	.word	244
	.word	476
	.word	172
	.word	288
	.word	124
	.word	511
	.word	226
	.word	63
	.word	103
	.word	485
	.word	488
	.word	153
	.word	453
	.word	422
	.word	461
	.word	240
	.word	169
	.word	312
	.word	290
	.word	300
	.word	99
	.word	276
	.word	102
	.word	500
	.word	300
	.word	386
	.word	247
	.word	148
	.word	120
	.word	497
	.word	17
	.word	469
	.word	441
	.word	116
	.word	357
	.word	98
	.word	31
	.word	162
	.word	213
	.word	312
	.word	100
	.word	280
	.word	89
	.word	293
	.word	324
	.word	284
	.word	205
	.word	245
	.word	317
	.word	279
	.word	95
	.word	58
	.word	3
	.word	356
	.word	36
	.word	279
	.word	499
	.word	104
	.word	240
	.word	55
	.word	61
	.word	447
	.word	441
	.word	372
	.word	176
	.word	31
	.word	165
	.word	137
	.word	498
	.word	417
	.word	54
	.word	282
	.word	288
	.word	451
	.word	367
	.word	237
	.word	23
	.word	483
	.word	164
	.word	71
	.word	430
	.word	292
	.word	136
	.word	208
	.word	415
	.word	472
	.word	376
	.word	327
	.word	195
	.word	219
	.word	419
	.word	312
	.word	14
	.word	198
	.word	347
	.word	219
	.word	358
	.word	401
	.word	159
	.word	216
	.word	94
	.word	406
	.word	349
	.word	6
	.word	340
	.word	206
	.word	35
	.word	456
	.word	363
	.word	12
	.word	37
	.word	392
	.word	178
	.word	250
	.word	142
	.word	329
	.word	389
	.word	245
	.word	327
	.word	262
	.word	81
	.word	78
	.word	62
	.word	508
	.word	512
	.word	500
	.word	122
	.word	206
	.word	77
	.word	249
	.word	377
	.word	320
	.word	209
	.word	123
	.word	416
	.word	237
	.word	253
	.word	185
	.word	154
	.word	184
	.word	353
	.word	405
	.word	143
	.word	323
	.word	132
	.word	317
	.word	155
	.word	142
	.word	250
	.word	477
	.word	250
	.word	307
	.word	417
	.word	326
	.word	190
	.word	397
	.word	71
	.word	73
	.word	326
	.word	45
	.word	192
	.word	510
	.word	376
	.word	473
	.word	61
	.word	20
	.word	286
	.word	482
	.word	178
	.word	507
	.word	301
	.word	306
	.word	319
	.word	90
	.word	197
	.word	334
	.word	119
	.word	402
	.word	66
	.word	323
	.word	445
	.word	506
	.word	473
	.word	309
	.word	236
	.word	404
	.word	245
	.word	354
	.word	325
	.word	188
	.word	387
	.word	240
	.word	86
	.word	84
	.word	223
	.word	186
	.word	14
	.word	478
	.word	251
	.word	382
	.word	444
	.word	151
	.word	417
	.word	163
	.word	490
	.word	323
	.word	253
	.word	368
	.word	187
	.word	271
	.word	445
	.word	473
	.word	19
	.word	222
	.word	290
	.word	350
	.word	285
	.word	372
	.word	421
	.word	30
	.word	380
	.word	250
	.word	75
	.word	476
	.word	168
	.word	245
	.word	390
	.word	86
	.word	20
	.word	363
	.word	165
	.word	151
	.word	423
	.word	117
	.word	163
	.word	300
	.word	82
	.word	173
	.word	237
	.word	87
	.word	208
	.word	282
	.word	87
	.word	181
	.word	481
	.word	187
	.word	112
	.word	169
	.word	69
	.word	56
	.word	131
	.word	257
	.word	24
	.word	238
	.word	78
	.word	470
	.word	154
	.word	310
	.word	197
	.word	481
	.word	398
	.word	167
	.word	386
	.word	366
	.word	49
	.word	337
	.word	66
	.word	119
	.word	490
	.word	203
	.word	39
	.word	317
	.word	97
	.word	33
	.word	414
	.word	464
	.word	210
	.word	336
	.word	489
	.word	335
	.word	378
	.word	116
	.word	363
	.word	328
	.word	191
	.word	101
	.word	407
	.word	408
	.word	259
	.word	483
	.word	51
	.word	377
	.word	223
	.global	nums1k2
	.align	2
	.type	nums1k2, %object
	.size	nums1k2, 4096
nums1k2:
	.word	348
	.word	348
	.word	4
	.word	379
	.word	124
	.word	157
	.word	325
	.word	427
	.word	423
	.word	337
	.word	460
	.word	131
	.word	240
	.word	232
	.word	165
	.word	278
	.word	158
	.word	490
	.word	101
	.word	250
	.word	109
	.word	506
	.word	332
	.word	245
	.word	462
	.word	253
	.word	165
	.word	254
	.word	321
	.word	390
	.word	107
	.word	444
	.word	498
	.word	8
	.word	360
	.word	220
	.word	79
	.word	141
	.word	474
	.word	171
	.word	271
	.word	243
	.word	96
	.word	348
	.word	297
	.word	181
	.word	466
	.word	65
	.word	100
	.word	174
	.word	360
	.word	453
	.word	207
	.word	414
	.word	190
	.word	134
	.word	92
	.word	279
	.word	464
	.word	503
	.word	158
	.word	159
	.word	98
	.word	158
	.word	302
	.word	25
	.word	188
	.word	337
	.word	8
	.word	98
	.word	393
	.word	90
	.word	396
	.word	504
	.word	205
	.word	425
	.word	175
	.word	439
	.word	58
	.word	343
	.word	247
	.word	113
	.word	249
	.word	150
	.word	348
	.word	24
	.word	174
	.word	376
	.word	331
	.word	302
	.word	280
	.word	251
	.word	510
	.word	113
	.word	241
	.word	507
	.word	9
	.word	389
	.word	172
	.word	214
	.word	253
	.word	497
	.word	401
	.word	243
	.word	7
	.word	80
	.word	499
	.word	133
	.word	208
	.word	477
	.word	456
	.word	376
	.word	350
	.word	53
	.word	466
	.word	84
	.word	261
	.word	193
	.word	215
	.word	9
	.word	509
	.word	462
	.word	378
	.word	363
	.word	154
	.word	482
	.word	72
	.word	266
	.word	465
	.word	73
	.word	460
	.word	406
	.word	454
	.word	478
	.word	447
	.word	94
	.word	283
	.word	107
	.word	483
	.word	404
	.word	48
	.word	297
	.word	207
	.word	47
	.word	435
	.word	56
	.word	416
	.word	362
	.word	181
	.word	327
	.word	36
	.word	231
	.word	273
	.word	48
	.word	123
	.word	455
	.word	319
	.word	358
	.word	21
	.word	153
	.word	161
	.word	178
	.word	382
	.word	415
	.word	362
	.word	2
	.word	116
	.word	420
	.word	197
	.word	60
	.word	205
	.word	16
	.word	506
	.word	109
	.word	60
	.word	135
	.word	491
	.word	414
	.word	150
	.word	41
	.word	342
	.word	126
	.word	188
	.word	172
	.word	348
	.word	383
	.word	475
	.word	454
	.word	236
	.word	461
	.word	370
	.word	113
	.word	158
	.word	145
	.word	157
	.word	17
	.word	90
	.word	479
	.word	497
	.word	384
	.word	18
	.word	92
	.word	471
	.word	300
	.word	137
	.word	230
	.word	105
	.word	68
	.word	128
	.word	487
	.word	125
	.word	9
	.word	158
	.word	105
	.word	4
	.word	374
	.word	202
	.word	315
	.word	295
	.word	11
	.word	512
	.word	247
	.word	276
	.word	55
	.word	52
	.word	507
	.word	390
	.word	74
	.word	470
	.word	16
	.word	332
	.word	235
	.word	455
	.word	374
	.word	175
	.word	361
	.word	414
	.word	143
	.word	481
	.word	193
	.word	409
	.word	212
	.word	361
	.word	179
	.word	189
	.word	243
	.word	330
	.word	356
	.word	503
	.word	385
	.word	397
	.word	110
	.word	486
	.word	157
	.word	169
	.word	31
	.word	276
	.word	455
	.word	499
	.word	161
	.word	43
	.word	315
	.word	264
	.word	441
	.word	242
	.word	145
	.word	204
	.word	181
	.word	206
	.word	83
	.word	354
	.word	446
	.word	86
	.word	150
	.word	338
	.word	18
	.word	488
	.word	483
	.word	297
	.word	213
	.word	479
	.word	314
	.word	439
	.word	353
	.word	272
	.word	4
	.word	75
	.word	420
	.word	143
	.word	413
	.word	153
	.word	105
	.word	376
	.word	158
	.word	101
	.word	327
	.word	396
	.word	81
	.word	427
	.word	227
	.word	404
	.word	48
	.word	302
	.word	458
	.word	446
	.word	422
	.word	134
	.word	42
	.word	132
	.word	473
	.word	197
	.word	258
	.word	146
	.word	99
	.word	220
	.word	434
	.word	381
	.word	489
	.word	365
	.word	315
	.word	280
	.word	437
	.word	284
	.word	99
	.word	388
	.word	247
	.word	494
	.word	477
	.word	122
	.word	470
	.word	42
	.word	47
	.word	130
	.word	17
	.word	484
	.word	421
	.word	268
	.word	390
	.word	490
	.word	317
	.word	417
	.word	205
	.word	220
	.word	242
	.word	477
	.word	508
	.word	196
	.word	415
	.word	5
	.word	144
	.word	479
	.word	34
	.word	117
	.word	472
	.word	309
	.word	456
	.word	72
	.word	393
	.word	51
	.word	295
	.word	407
	.word	155
	.word	128
	.word	47
	.word	400
	.word	42
	.word	424
	.word	168
	.word	231
	.word	468
	.word	24
	.word	467
	.word	226
	.word	389
	.word	68
	.word	403
	.word	502
	.word	253
	.word	409
	.word	505
	.word	333
	.word	142
	.word	203
	.word	161
	.word	426
	.word	322
	.word	329
	.word	130
	.word	114
	.word	398
	.word	302
	.word	306
	.word	268
	.word	282
	.word	168
	.word	35
	.word	214
	.word	28
	.word	355
	.word	366
	.word	208
	.word	320
	.word	418
	.word	20
	.word	239
	.word	216
	.word	277
	.word	343
	.word	33
	.word	250
	.word	28
	.word	339
	.word	151
	.word	232
	.word	336
	.word	124
	.word	36
	.word	203
	.word	376
	.word	225
	.word	114
	.word	390
	.word	241
	.word	408
	.word	246
	.word	21
	.word	246
	.word	412
	.word	421
	.word	419
	.word	472
	.word	454
	.word	239
	.word	162
	.word	482
	.word	262
	.word	132
	.word	506
	.word	305
	.word	239
	.word	341
	.word	247
	.word	253
	.word	338
	.word	200
	.word	37
	.word	86
	.word	66
	.word	49
	.word	458
	.word	21
	.word	89
	.word	54
	.word	299
	.word	86
	.word	26
	.word	417
	.word	143
	.word	275
	.word	226
	.word	325
	.word	56
	.word	183
	.word	435
	.word	262
	.word	506
	.word	181
	.word	228
	.word	197
	.word	270
	.word	339
	.word	153
	.word	364
	.word	471
	.word	283
	.word	508
	.word	510
	.word	167
	.word	337
	.word	462
	.word	41
	.word	338
	.word	388
	.word	106
	.word	162
	.word	439
	.word	473
	.word	505
	.word	16
	.word	87
	.word	338
	.word	48
	.word	504
	.word	402
	.word	261
	.word	376
	.word	317
	.word	117
	.word	345
	.word	388
	.word	374
	.word	109
	.word	272
	.word	301
	.word	398
	.word	435
	.word	348
	.word	482
	.word	438
	.word	239
	.word	272
	.word	52
	.word	85
	.word	454
	.word	349
	.word	475
	.word	46
	.word	188
	.word	85
	.word	92
	.word	246
	.word	432
	.word	398
	.word	169
	.word	477
	.word	126
	.word	291
	.word	158
	.word	141
	.word	143
	.word	199
	.word	415
	.word	144
	.word	152
	.word	329
	.word	67
	.word	286
	.word	347
	.word	126
	.word	290
	.word	148
	.word	421
	.word	273
	.word	342
	.word	13
	.word	205
	.word	424
	.word	269
	.word	117
	.word	155
	.word	42
	.word	99
	.word	262
	.word	343
	.word	359
	.word	16
	.word	320
	.word	466
	.word	182
	.word	443
	.word	412
	.word	435
	.word	335
	.word	70
	.word	494
	.word	373
	.word	463
	.word	506
	.word	66
	.word	476
	.word	338
	.word	261
	.word	223
	.word	505
	.word	432
	.word	400
	.word	478
	.word	408
	.word	99
	.word	470
	.word	331
	.word	202
	.word	272
	.word	362
	.word	430
	.word	292
	.word	243
	.word	158
	.word	499
	.word	266
	.word	200
	.word	413
	.word	94
	.word	142
	.word	451
	.word	231
	.word	414
	.word	151
	.word	294
	.word	154
	.word	264
	.word	478
	.word	10
	.word	28
	.word	150
	.word	352
	.word	390
	.word	337
	.word	67
	.word	185
	.word	30
	.word	137
	.word	410
	.word	113
	.word	258
	.word	332
	.word	174
	.word	508
	.word	296
	.word	94
	.word	132
	.word	202
	.word	306
	.word	452
	.word	185
	.word	113
	.word	409
	.word	193
	.word	364
	.word	29
	.word	210
	.word	206
	.word	127
	.word	244
	.word	177
	.word	394
	.word	282
	.word	329
	.word	317
	.word	482
	.word	384
	.word	450
	.word	150
	.word	450
	.word	295
	.word	346
	.word	191
	.word	99
	.word	63
	.word	362
	.word	59
	.word	50
	.word	470
	.word	235
	.word	360
	.word	443
	.word	352
	.word	392
	.word	134
	.word	510
	.word	511
	.word	318
	.word	303
	.word	113
	.word	79
	.word	84
	.word	170
	.word	143
	.word	135
	.word	266
	.word	326
	.word	69
	.word	12
	.word	330
	.word	82
	.word	504
	.word	492
	.word	174
	.word	455
	.word	228
	.word	175
	.word	446
	.word	61
	.word	405
	.word	444
	.word	451
	.word	97
	.word	241
	.word	498
	.word	239
	.word	278
	.word	478
	.word	401
	.word	154
	.word	223
	.word	231
	.word	445
	.word	251
	.word	83
	.word	374
	.word	121
	.word	506
	.word	16
	.word	291
	.word	202
	.word	104
	.word	456
	.word	124
	.word	445
	.word	104
	.word	223
	.word	312
	.word	437
	.word	462
	.word	491
	.word	403
	.word	229
	.word	89
	.word	466
	.word	41
	.word	427
	.word	274
	.word	380
	.word	27
	.word	484
	.word	328
	.word	341
	.word	344
	.word	5
	.word	479
	.word	137
	.word	127
	.word	86
	.word	271
	.word	94
	.word	442
	.word	140
	.word	466
	.word	431
	.word	485
	.word	427
	.word	324
	.word	297
	.word	150
	.word	237
	.word	43
	.word	271
	.word	255
	.word	24
	.word	470
	.word	10
	.word	503
	.word	344
	.word	488
	.word	511
	.word	431
	.word	490
	.word	270
	.word	317
	.word	180
	.word	334
	.word	434
	.word	254
	.word	203
	.word	110
	.word	426
	.word	450
	.word	175
	.word	145
	.word	220
	.word	411
	.word	478
	.word	156
	.word	271
	.word	483
	.word	319
	.word	81
	.word	149
	.word	175
	.word	424
	.word	165
	.word	326
	.word	512
	.word	53
	.word	108
	.word	432
	.word	217
	.word	146
	.word	107
	.word	108
	.word	401
	.word	339
	.word	412
	.word	336
	.word	211
	.word	68
	.word	120
	.word	153
	.word	415
	.word	314
	.word	307
	.word	26
	.word	374
	.word	458
	.word	8
	.word	226
	.word	49
	.word	458
	.word	8
	.word	369
	.word	43
	.word	205
	.word	241
	.word	471
	.word	73
	.word	363
	.word	203
	.word	443
	.word	457
	.word	186
	.word	102
	.word	405
	.word	343
	.word	190
	.word	84
	.word	43
	.word	13
	.word	379
	.word	89
	.word	43
	.word	435
	.word	164
	.word	89
	.word	111
	.word	135
	.word	446
	.word	186
	.word	120
	.word	149
	.word	165
	.word	264
	.word	23
	.word	15
	.word	254
	.word	309
	.word	376
	.word	301
	.word	149
	.word	93
	.word	415
	.word	205
	.word	245
	.word	74
	.word	304
	.word	163
	.word	256
	.word	7
	.word	7
	.word	188
	.word	182
	.word	316
	.word	11
	.word	52
	.word	380
	.word	246
	.word	305
	.word	228
	.word	429
	.word	87
	.word	422
	.word	368
	.word	85
	.word	28
	.word	271
	.word	423
	.word	81
	.word	44
	.word	128
	.word	456
	.word	365
	.word	353
	.word	20
	.word	75
	.word	131
	.word	376
	.word	40
	.word	495
	.word	273
	.word	143
	.word	306
	.word	352
	.word	13
	.word	491
	.word	429
	.word	391
	.word	395
	.word	502
	.word	72
	.word	391
	.word	71
	.word	271
	.word	467
	.word	397
	.word	95
	.word	438
	.word	475
	.word	118
	.word	485
	.word	427
	.word	160
	.word	34
	.word	149
	.word	165
	.word	90
	.word	377
	.word	8
	.word	405
	.word	42
	.word	50
	.word	160
	.word	501
	.word	22
	.word	24
	.word	185
	.word	172
	.word	402
	.word	123
	.word	247
	.word	479
	.word	183
	.word	10
	.word	440
	.word	403
	.word	43
	.word	103
	.word	204
	.word	428
	.word	300
	.word	253
	.word	312
	.word	217
	.word	384
	.word	254
	.word	16
	.word	375
	.word	212
	.word	418
	.word	312
	.word	301
	.word	214
	.word	55
	.word	11
	.word	509
	.word	362
	.word	200
	.word	224
	.word	484
	.word	136
	.word	475
	.word	477
	.word	266
	.word	410
	.word	244
	.word	256
	.word	217
	.word	372
	.word	460
	.word	497
	.word	3
	.word	316
	.word	477
	.word	474
	.word	61
	.word	462
	.word	332
	.word	111
	.word	183
	.word	478
	.word	29
	.word	365
	.word	511
	.word	421
	.word	453
	.word	287
	.word	141
	.word	177
	.word	100
	.word	81
	.word	266
	.word	451
	.word	235
	.word	235
	.word	198
	.word	262
	.word	409
	.word	207
	.word	269
	.word	493
	.word	192
	.word	482
	.word	43
	.word	312
	.word	492
	.word	261
	.word	10
	.word	245
	.word	221
	.word	106
	.word	288
	.word	58
	.word	444
	.word	110
	.word	6
	.word	10
	.word	373
	.word	211
	.word	323
	.word	159
	.word	274
	.word	210
	.word	209
	.word	314
	.word	78
	.word	75
	.text
	.align	2
	.global	swap
	.type	swap, %function
swap:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, [fp, #-16]
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-20]
	ldr	r2, [r3]
	ldr	r3, [fp, #-16]
	str	r2, [r3]
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-8]
	str	r2, [r3]
	mov	r0, r0	@ nop
	sub	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	swap, .-swap
	.align	2
	.global	sort
	.type	sort, %function
sort:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	str	r2, [fp, #-32]
	ldr	r3, [fp, #-28]
	add	r2, r3, #1
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	bge	.L7
	ldr	r3, [fp, #-28]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-12]
	b	.L4
.L6:
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bgt	.L5
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
	b	.L4
.L5:
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-24]
	add	r0, r2, r3
	ldr	r3, [fp, #-12]
	sub	r3, r3, #1
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	mov	r1, r3
	bl	swap
.L4:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-12]
	cmp	r2, r3
	blt	.L6
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-24]
	add	r0, r2, r3
	ldr	r3, [fp, #-28]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	mov	r1, r3
	bl	swap
	ldr	r2, [fp, #-8]
	ldr	r1, [fp, #-28]
	ldr	r0, [fp, #-24]
	bl	sort
	ldr	r2, [fp, #-32]
	ldr	r1, [fp, #-12]
	ldr	r0, [fp, #-24]
	bl	sort
.L7:
	mov	r0, r0	@ nop
	sub	sp, fp, #4
	@ sp needed
	ldmfd	sp!, {fp, pc}
	.size	sort, .-sort
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	mov	r2, #1024
	mov	r1, #0
	movw	r0, #:lower16:nums1k1
	movt	r0, #:upper16:nums1k1
	bl	sort
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp!, {fp, pc}
	.size	main, .-main
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"

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
	.file	"vadd.c"
	.global	nums1k1
	.data
	.align	2
	.type	nums1k1, %object
	.size	nums1k1, 4096
nums1k1:
	.word	364
	.word	286
	.word	278
	.word	283
	.word	154
	.word	477
	.word	369
	.word	480
	.word	40
	.word	382
	.word	153
	.word	293
	.word	488
	.word	35
	.word	225
	.word	172
	.word	4
	.word	443
	.word	411
	.word	429
	.word	131
	.word	490
	.word	91
	.word	89
	.word	495
	.word	426
	.word	290
	.word	411
	.word	423
	.word	493
	.word	139
	.word	414
	.word	303
	.word	485
	.word	327
	.word	44
	.word	430
	.word	129
	.word	153
	.word	331
	.word	138
	.word	206
	.word	284
	.word	461
	.word	428
	.word	473
	.word	297
	.word	90
	.word	260
	.word	317
	.word	241
	.word	135
	.word	297
	.word	386
	.word	83
	.word	481
	.word	456
	.word	116
	.word	95
	.word	47
	.word	317
	.word	31
	.word	337
	.word	29
	.word	383
	.word	417
	.word	268
	.word	134
	.word	277
	.word	402
	.word	432
	.word	493
	.word	119
	.word	352
	.word	70
	.word	459
	.word	188
	.word	329
	.word	249
	.word	287
	.word	165
	.word	384
	.word	149
	.word	371
	.word	89
	.word	285
	.word	179
	.word	133
	.word	134
	.word	219
	.word	20
	.word	11
	.word	379
	.word	295
	.word	36
	.word	380
	.word	158
	.word	80
	.word	440
	.word	335
	.word	47
	.word	182
	.word	415
	.word	452
	.word	340
	.word	57
	.word	468
	.word	182
	.word	249
	.word	106
	.word	259
	.word	276
	.word	487
	.word	175
	.word	510
	.word	63
	.word	6
	.word	122
	.word	68
	.word	34
	.word	271
	.word	74
	.word	18
	.word	126
	.word	331
	.word	435
	.word	329
	.word	60
	.word	193
	.word	75
	.word	94
	.word	128
	.word	143
	.word	143
	.word	242
	.word	423
	.word	360
	.word	249
	.word	92
	.word	342
	.word	14
	.word	270
	.word	417
	.word	110
	.word	27
	.word	160
	.word	500
	.word	428
	.word	146
	.word	103
	.word	403
	.word	304
	.word	362
	.word	331
	.word	35
	.word	392
	.word	320
	.word	330
	.word	369
	.word	34
	.word	508
	.word	405
	.word	306
	.word	338
	.word	177
	.word	220
	.word	451
	.word	369
	.word	278
	.word	37
	.word	151
	.word	378
	.word	468
	.word	486
	.word	85
	.word	206
	.word	258
	.word	169
	.word	496
	.word	505
	.word	99
	.word	216
	.word	367
	.word	99
	.word	455
	.word	301
	.word	386
	.word	447
	.word	354
	.word	430
	.word	6
	.word	266
	.word	204
	.word	59
	.word	276
	.word	11
	.word	148
	.word	506
	.word	486
	.word	459
	.word	391
	.word	36
	.word	428
	.word	54
	.word	53
	.word	453
	.word	221
	.word	503
	.word	399
	.word	330
	.word	347
	.word	487
	.word	1
	.word	278
	.word	155
	.word	221
	.word	278
	.word	328
	.word	371
	.word	150
	.word	159
	.word	228
	.word	406
	.word	101
	.word	126
	.word	215
	.word	128
	.word	26
	.word	487
	.word	339
	.word	146
	.word	24
	.word	402
	.word	97
	.word	281
	.word	320
	.word	214
	.word	151
	.word	271
	.word	363
	.word	300
	.word	501
	.word	274
	.word	41
	.word	112
	.word	306
	.word	507
	.word	293
	.word	342
	.word	282
	.word	173
	.word	477
	.word	317
	.word	176
	.word	271
	.word	327
	.word	436
	.word	117
	.word	199
	.word	276
	.word	414
	.word	485
	.word	273
	.word	76
	.word	307
	.word	267
	.word	215
	.word	327
	.word	379
	.word	315
	.word	431
	.word	313
	.word	377
	.word	261
	.word	117
	.word	195
	.word	245
	.word	153
	.word	54
	.word	427
	.word	340
	.word	485
	.word	414
	.word	318
	.word	213
	.word	491
	.word	159
	.word	511
	.word	128
	.word	312
	.word	463
	.word	297
	.word	35
	.word	273
	.word	31
	.word	272
	.word	239
	.word	101
	.word	235
	.word	234
	.word	238
	.word	308
	.word	325
	.word	397
	.word	155
	.word	163
	.word	146
	.word	499
	.word	273
	.word	28
	.word	280
	.word	374
	.word	32
	.word	400
	.word	314
	.word	21
	.word	340
	.word	7
	.word	231
	.word	390
	.word	258
	.word	431
	.word	192
	.word	469
	.word	14
	.word	293
	.word	418
	.word	140
	.word	481
	.word	302
	.word	440
	.word	68
	.word	303
	.word	499
	.word	387
	.word	169
	.word	4
	.word	166
	.word	363
	.word	388
	.word	160
	.word	428
	.word	469
	.word	361
	.word	66
	.word	458
	.word	92
	.word	315
	.word	90
	.word	331
	.word	422
	.word	249
	.word	344
	.word	496
	.word	151
	.word	295
	.word	167
	.word	297
	.word	430
	.word	309
	.word	391
	.word	158
	.word	185
	.word	91
	.word	440
	.word	275
	.word	477
	.word	362
	.word	283
	.word	88
	.word	487
	.word	341
	.word	423
	.word	96
	.word	391
	.word	419
	.word	106
	.word	110
	.word	143
	.word	319
	.word	197
	.word	330
	.word	212
	.word	403
	.word	505
	.word	1
	.word	147
	.word	223
	.word	343
	.word	41
	.word	24
	.word	357
	.word	457
	.word	90
	.word	318
	.word	21
	.word	263
	.word	371
	.word	434
	.word	82
	.word	242
	.word	7
	.word	394
	.word	245
	.word	329
	.word	352
	.word	290
	.word	241
	.word	134
	.word	35
	.word	143
	.word	429
	.word	132
	.word	328
	.word	22
	.word	298
	.word	424
	.word	258
	.word	219
	.word	355
	.word	273
	.word	101
	.word	119
	.word	55
	.word	264
	.word	188
	.word	363
	.word	413
	.word	263
	.word	11
	.word	392
	.word	285
	.word	433
	.word	322
	.word	443
	.word	502
	.word	153
	.word	304
	.word	293
	.word	42
	.word	273
	.word	450
	.word	400
	.word	147
	.word	466
	.word	61
	.word	311
	.word	204
	.word	107
	.word	233
	.word	206
	.word	373
	.word	430
	.word	374
	.word	242
	.word	498
	.word	301
	.word	391
	.word	247
	.word	120
	.word	286
	.word	261
	.word	299
	.word	395
	.word	117
	.word	457
	.word	428
	.word	386
	.word	492
	.word	213
	.word	28
	.word	231
	.word	80
	.word	181
	.word	30
	.word	498
	.word	197
	.word	71
	.word	301
	.word	144
	.word	27
	.word	209
	.word	124
	.word	82
	.word	397
	.word	22
	.word	358
	.word	296
	.word	341
	.word	468
	.word	184
	.word	140
	.word	265
	.word	448
	.word	408
	.word	185
	.word	396
	.word	193
	.word	444
	.word	439
	.word	456
	.word	152
	.word	422
	.word	32
	.word	505
	.word	46
	.word	351
	.word	67
	.word	89
	.word	136
	.word	261
	.word	64
	.word	469
	.word	174
	.word	252
	.word	431
	.word	504
	.word	486
	.word	260
	.word	7
	.word	283
	.word	313
	.word	201
	.word	226
	.word	183
	.word	396
	.word	212
	.word	340
	.word	342
	.word	178
	.word	255
	.word	78
	.word	25
	.word	18
	.word	250
	.word	57
	.word	67
	.word	96
	.word	88
	.word	477
	.word	16
	.word	379
	.word	476
	.word	241
	.word	428
	.word	124
	.word	220
	.word	6
	.word	230
	.word	34
	.word	226
	.word	409
	.word	304
	.word	501
	.word	99
	.word	265
	.word	257
	.word	351
	.word	237
	.word	326
	.word	137
	.word	312
	.word	272
	.word	471
	.word	218
	.word	154
	.word	199
	.word	212
	.word	141
	.word	93
	.word	433
	.word	210
	.word	370
	.word	506
	.word	117
	.word	499
	.word	328
	.word	357
	.word	141
	.word	27
	.word	144
	.word	162
	.word	54
	.word	435
	.word	361
	.word	447
	.word	478
	.word	400
	.word	434
	.word	2
	.word	77
	.word	401
	.word	79
	.word	313
	.word	454
	.word	177
	.word	164
	.word	415
	.word	100
	.word	87
	.word	36
	.word	101
	.word	190
	.word	294
	.word	378
	.word	471
	.word	230
	.word	49
	.word	231
	.word	56
	.word	238
	.word	45
	.word	1
	.word	73
	.word	372
	.word	322
	.word	229
	.word	336
	.word	338
	.word	53
	.word	144
	.word	491
	.word	233
	.word	440
	.word	200
	.word	35
	.word	74
	.word	108
	.word	106
	.word	448
	.word	313
	.word	324
	.word	126
	.word	157
	.word	283
	.word	405
	.word	305
	.word	237
	.word	177
	.word	354
	.word	386
	.word	318
	.word	60
	.word	145
	.word	299
	.word	468
	.word	23
	.word	314
	.word	6
	.word	145
	.word	103
	.word	482
	.word	129
	.word	98
	.word	220
	.word	67
	.word	114
	.word	211
	.word	265
	.word	83
	.word	398
	.word	168
	.word	92
	.word	200
	.word	55
	.word	71
	.word	39
	.word	459
	.word	146
	.word	252
	.word	277
	.word	376
	.word	240
	.word	232
	.word	475
	.word	297
	.word	375
	.word	385
	.word	253
	.word	388
	.word	299
	.word	174
	.word	216
	.word	243
	.word	42
	.word	144
	.word	61
	.word	336
	.word	413
	.word	338
	.word	138
	.word	133
	.word	302
	.word	202
	.word	138
	.word	78
	.word	167
	.word	101
	.word	486
	.word	131
	.word	476
	.word	282
	.word	29
	.word	402
	.word	46
	.word	57
	.word	510
	.word	418
	.word	432
	.word	78
	.word	214
	.word	224
	.word	243
	.word	121
	.word	78
	.word	378
	.word	259
	.word	314
	.word	246
	.word	291
	.word	346
	.word	239
	.word	5
	.word	162
	.word	288
	.word	42
	.word	32
	.word	286
	.word	267
	.word	67
	.word	103
	.word	244
	.word	476
	.word	172
	.word	288
	.word	124
	.word	511
	.word	226
	.word	63
	.word	103
	.word	485
	.word	488
	.word	153
	.word	453
	.word	422
	.word	461
	.word	240
	.word	169
	.word	312
	.word	290
	.word	300
	.word	99
	.word	276
	.word	102
	.word	500
	.word	300
	.word	386
	.word	247
	.word	148
	.word	120
	.word	497
	.word	17
	.word	469
	.word	441
	.word	116
	.word	357
	.word	98
	.word	31
	.word	162
	.word	213
	.word	312
	.word	100
	.word	280
	.word	89
	.word	293
	.word	324
	.word	284
	.word	205
	.word	245
	.word	317
	.word	279
	.word	95
	.word	58
	.word	3
	.word	356
	.word	36
	.word	279
	.word	499
	.word	104
	.word	240
	.word	55
	.word	61
	.word	447
	.word	441
	.word	372
	.word	176
	.word	31
	.word	165
	.word	137
	.word	498
	.word	417
	.word	54
	.word	282
	.word	288
	.word	451
	.word	367
	.word	237
	.word	23
	.word	483
	.word	164
	.word	71
	.word	430
	.word	292
	.word	136
	.word	208
	.word	415
	.word	472
	.word	376
	.word	327
	.word	195
	.word	219
	.word	419
	.word	312
	.word	14
	.word	198
	.word	347
	.word	219
	.word	358
	.word	401
	.word	159
	.word	216
	.word	94
	.word	406
	.word	349
	.word	6
	.word	340
	.word	206
	.word	35
	.word	456
	.word	363
	.word	12
	.word	37
	.word	392
	.word	178
	.word	250
	.word	142
	.word	329
	.word	389
	.word	245
	.word	327
	.word	262
	.word	81
	.word	78
	.word	62
	.word	508
	.word	512
	.word	500
	.word	122
	.word	206
	.word	77
	.word	249
	.word	377
	.word	320
	.word	209
	.word	123
	.word	416
	.word	237
	.word	253
	.word	185
	.word	154
	.word	184
	.word	353
	.word	405
	.word	143
	.word	323
	.word	132
	.word	317
	.word	155
	.word	142
	.word	250
	.word	477
	.word	250
	.word	307
	.word	417
	.word	326
	.word	190
	.word	397
	.word	71
	.word	73
	.word	326
	.word	45
	.word	192
	.word	510
	.word	376
	.word	473
	.word	61
	.word	20
	.word	286
	.word	482
	.word	178
	.word	507
	.word	301
	.word	306
	.word	319
	.word	90
	.word	197
	.word	334
	.word	119
	.word	402
	.word	66
	.word	323
	.word	445
	.word	506
	.word	473
	.word	309
	.word	236
	.word	404
	.word	245
	.word	354
	.word	325
	.word	188
	.word	387
	.word	240
	.word	86
	.word	84
	.word	223
	.word	186
	.word	14
	.word	478
	.word	251
	.word	382
	.word	444
	.word	151
	.word	417
	.word	163
	.word	490
	.word	323
	.word	253
	.word	368
	.word	187
	.word	271
	.word	445
	.word	473
	.word	19
	.word	222
	.word	290
	.word	350
	.word	285
	.word	372
	.word	421
	.word	30
	.word	380
	.word	250
	.word	75
	.word	476
	.word	168
	.word	245
	.word	390
	.word	86
	.word	20
	.word	363
	.word	165
	.word	151
	.word	423
	.word	117
	.word	163
	.word	300
	.word	82
	.word	173
	.word	237
	.word	87
	.word	208
	.word	282
	.word	87
	.word	181
	.word	481
	.word	187
	.word	112
	.word	169
	.word	69
	.word	56
	.word	131
	.word	257
	.word	24
	.word	238
	.word	78
	.word	470
	.word	154
	.word	310
	.word	197
	.word	481
	.word	398
	.word	167
	.word	386
	.word	366
	.word	49
	.word	337
	.word	66
	.word	119
	.word	490
	.word	203
	.word	39
	.word	317
	.word	97
	.word	33
	.word	414
	.word	464
	.word	210
	.word	336
	.word	489
	.word	335
	.word	378
	.word	116
	.word	363
	.word	328
	.word	191
	.word	101
	.word	407
	.word	408
	.word	259
	.word	483
	.word	51
	.word	377
	.word	223
	.global	nums1k2
	.align	2
	.type	nums1k2, %object
	.size	nums1k2, 4096
nums1k2:
	.word	348
	.word	348
	.word	4
	.word	379
	.word	124
	.word	157
	.word	325
	.word	427
	.word	423
	.word	337
	.word	460
	.word	131
	.word	240
	.word	232
	.word	165
	.word	278
	.word	158
	.word	490
	.word	101
	.word	250
	.word	109
	.word	506
	.word	332
	.word	245
	.word	462
	.word	253
	.word	165
	.word	254
	.word	321
	.word	390
	.word	107
	.word	444
	.word	498
	.word	8
	.word	360
	.word	220
	.word	79
	.word	141
	.word	474
	.word	171
	.word	271
	.word	243
	.word	96
	.word	348
	.word	297
	.word	181
	.word	466
	.word	65
	.word	100
	.word	174
	.word	360
	.word	453
	.word	207
	.word	414
	.word	190
	.word	134
	.word	92
	.word	279
	.word	464
	.word	503
	.word	158
	.word	159
	.word	98
	.word	158
	.word	302
	.word	25
	.word	188
	.word	337
	.word	8
	.word	98
	.word	393
	.word	90
	.word	396
	.word	504
	.word	205
	.word	425
	.word	175
	.word	439
	.word	58
	.word	343
	.word	247
	.word	113
	.word	249
	.word	150
	.word	348
	.word	24
	.word	174
	.word	376
	.word	331
	.word	302
	.word	280
	.word	251
	.word	510
	.word	113
	.word	241
	.word	507
	.word	9
	.word	389
	.word	172
	.word	214
	.word	253
	.word	497
	.word	401
	.word	243
	.word	7
	.word	80
	.word	499
	.word	133
	.word	208
	.word	477
	.word	456
	.word	376
	.word	350
	.word	53
	.word	466
	.word	84
	.word	261
	.word	193
	.word	215
	.word	9
	.word	509
	.word	462
	.word	378
	.word	363
	.word	154
	.word	482
	.word	72
	.word	266
	.word	465
	.word	73
	.word	460
	.word	406
	.word	454
	.word	478
	.word	447
	.word	94
	.word	283
	.word	107
	.word	483
	.word	404
	.word	48
	.word	297
	.word	207
	.word	47
	.word	435
	.word	56
	.word	416
	.word	362
	.word	181
	.word	327
	.word	36
	.word	231
	.word	273
	.word	48
	.word	123
	.word	455
	.word	319
	.word	358
	.word	21
	.word	153
	.word	161
	.word	178
	.word	382
	.word	415
	.word	362
	.word	2
	.word	116
	.word	420
	.word	197
	.word	60
	.word	205
	.word	16
	.word	506
	.word	109
	.word	60
	.word	135
	.word	491
	.word	414
	.word	150
	.word	41
	.word	342
	.word	126
	.word	188
	.word	172
	.word	348
	.word	383
	.word	475
	.word	454
	.word	236
	.word	461
	.word	370
	.word	113
	.word	158
	.word	145
	.word	157
	.word	17
	.word	90
	.word	479
	.word	497
	.word	384
	.word	18
	.word	92
	.word	471
	.word	300
	.word	137
	.word	230
	.word	105
	.word	68
	.word	128
	.word	487
	.word	125
	.word	9
	.word	158
	.word	105
	.word	4
	.word	374
	.word	202
	.word	315
	.word	295
	.word	11
	.word	512
	.word	247
	.word	276
	.word	55
	.word	52
	.word	507
	.word	390
	.word	74
	.word	470
	.word	16
	.word	332
	.word	235
	.word	455
	.word	374
	.word	175
	.word	361
	.word	414
	.word	143
	.word	481
	.word	193
	.word	409
	.word	212
	.word	361
	.word	179
	.word	189
	.word	243
	.word	330
	.word	356
	.word	503
	.word	385
	.word	397
	.word	110
	.word	486
	.word	157
	.word	169
	.word	31
	.word	276
	.word	455
	.word	499
	.word	161
	.word	43
	.word	315
	.word	264
	.word	441
	.word	242
	.word	145
	.word	204
	.word	181
	.word	206
	.word	83
	.word	354
	.word	446
	.word	86
	.word	150
	.word	338
	.word	18
	.word	488
	.word	483
	.word	297
	.word	213
	.word	479
	.word	314
	.word	439
	.word	353
	.word	272
	.word	4
	.word	75
	.word	420
	.word	143
	.word	413
	.word	153
	.word	105
	.word	376
	.word	158
	.word	101
	.word	327
	.word	396
	.word	81
	.word	427
	.word	227
	.word	404
	.word	48
	.word	302
	.word	458
	.word	446
	.word	422
	.word	134
	.word	42
	.word	132
	.word	473
	.word	197
	.word	258
	.word	146
	.word	99
	.word	220
	.word	434
	.word	381
	.word	489
	.word	365
	.word	315
	.word	280
	.word	437
	.word	284
	.word	99
	.word	388
	.word	247
	.word	494
	.word	477
	.word	122
	.word	470
	.word	42
	.word	47
	.word	130
	.word	17
	.word	484
	.word	421
	.word	268
	.word	390
	.word	490
	.word	317
	.word	417
	.word	205
	.word	220
	.word	242
	.word	477
	.word	508
	.word	196
	.word	415
	.word	5
	.word	144
	.word	479
	.word	34
	.word	117
	.word	472
	.word	309
	.word	456
	.word	72
	.word	393
	.word	51
	.word	295
	.word	407
	.word	155
	.word	128
	.word	47
	.word	400
	.word	42
	.word	424
	.word	168
	.word	231
	.word	468
	.word	24
	.word	467
	.word	226
	.word	389
	.word	68
	.word	403
	.word	502
	.word	253
	.word	409
	.word	505
	.word	333
	.word	142
	.word	203
	.word	161
	.word	426
	.word	322
	.word	329
	.word	130
	.word	114
	.word	398
	.word	302
	.word	306
	.word	268
	.word	282
	.word	168
	.word	35
	.word	214
	.word	28
	.word	355
	.word	366
	.word	208
	.word	320
	.word	418
	.word	20
	.word	239
	.word	216
	.word	277
	.word	343
	.word	33
	.word	250
	.word	28
	.word	339
	.word	151
	.word	232
	.word	336
	.word	124
	.word	36
	.word	203
	.word	376
	.word	225
	.word	114
	.word	390
	.word	241
	.word	408
	.word	246
	.word	21
	.word	246
	.word	412
	.word	421
	.word	419
	.word	472
	.word	454
	.word	239
	.word	162
	.word	482
	.word	262
	.word	132
	.word	506
	.word	305
	.word	239
	.word	341
	.word	247
	.word	253
	.word	338
	.word	200
	.word	37
	.word	86
	.word	66
	.word	49
	.word	458
	.word	21
	.word	89
	.word	54
	.word	299
	.word	86
	.word	26
	.word	417
	.word	143
	.word	275
	.word	226
	.word	325
	.word	56
	.word	183
	.word	435
	.word	262
	.word	506
	.word	181
	.word	228
	.word	197
	.word	270
	.word	339
	.word	153
	.word	364
	.word	471
	.word	283
	.word	508
	.word	510
	.word	167
	.word	337
	.word	462
	.word	41
	.word	338
	.word	388
	.word	106
	.word	162
	.word	439
	.word	473
	.word	505
	.word	16
	.word	87
	.word	338
	.word	48
	.word	504
	.word	402
	.word	261
	.word	376
	.word	317
	.word	117
	.word	345
	.word	388
	.word	374
	.word	109
	.word	272
	.word	301
	.word	398
	.word	435
	.word	348
	.word	482
	.word	438
	.word	239
	.word	272
	.word	52
	.word	85
	.word	454
	.word	349
	.word	475
	.word	46
	.word	188
	.word	85
	.word	92
	.word	246
	.word	432
	.word	398
	.word	169
	.word	477
	.word	126
	.word	291
	.word	158
	.word	141
	.word	143
	.word	199
	.word	415
	.word	144
	.word	152
	.word	329
	.word	67
	.word	286
	.word	347
	.word	126
	.word	290
	.word	148
	.word	421
	.word	273
	.word	342
	.word	13
	.word	205
	.word	424
	.word	269
	.word	117
	.word	155
	.word	42
	.word	99
	.word	262
	.word	343
	.word	359
	.word	16
	.word	320
	.word	466
	.word	182
	.word	443
	.word	412
	.word	435
	.word	335
	.word	70
	.word	494
	.word	373
	.word	463
	.word	506
	.word	66
	.word	476
	.word	338
	.word	261
	.word	223
	.word	505
	.word	432
	.word	400
	.word	478
	.word	408
	.word	99
	.word	470
	.word	331
	.word	202
	.word	272
	.word	362
	.word	430
	.word	292
	.word	243
	.word	158
	.word	499
	.word	266
	.word	200
	.word	413
	.word	94
	.word	142
	.word	451
	.word	231
	.word	414
	.word	151
	.word	294
	.word	154
	.word	264
	.word	478
	.word	10
	.word	28
	.word	150
	.word	352
	.word	390
	.word	337
	.word	67
	.word	185
	.word	30
	.word	137
	.word	410
	.word	113
	.word	258
	.word	332
	.word	174
	.word	508
	.word	296
	.word	94
	.word	132
	.word	202
	.word	306
	.word	452
	.word	185
	.word	113
	.word	409
	.word	193
	.word	364
	.word	29
	.word	210
	.word	206
	.word	127
	.word	244
	.word	177
	.word	394
	.word	282
	.word	329
	.word	317
	.word	482
	.word	384
	.word	450
	.word	150
	.word	450
	.word	295
	.word	346
	.word	191
	.word	99
	.word	63
	.word	362
	.word	59
	.word	50
	.word	470
	.word	235
	.word	360
	.word	443
	.word	352
	.word	392
	.word	134
	.word	510
	.word	511
	.word	318
	.word	303
	.word	113
	.word	79
	.word	84
	.word	170
	.word	143
	.word	135
	.word	266
	.word	326
	.word	69
	.word	12
	.word	330
	.word	82
	.word	504
	.word	492
	.word	174
	.word	455
	.word	228
	.word	175
	.word	446
	.word	61
	.word	405
	.word	444
	.word	451
	.word	97
	.word	241
	.word	498
	.word	239
	.word	278
	.word	478
	.word	401
	.word	154
	.word	223
	.word	231
	.word	445
	.word	251
	.word	83
	.word	374
	.word	121
	.word	506
	.word	16
	.word	291
	.word	202
	.word	104
	.word	456
	.word	124
	.word	445
	.word	104
	.word	223
	.word	312
	.word	437
	.word	462
	.word	491
	.word	403
	.word	229
	.word	89
	.word	466
	.word	41
	.word	427
	.word	274
	.word	380
	.word	27
	.word	484
	.word	328
	.word	341
	.word	344
	.word	5
	.word	479
	.word	137
	.word	127
	.word	86
	.word	271
	.word	94
	.word	442
	.word	140
	.word	466
	.word	431
	.word	485
	.word	427
	.word	324
	.word	297
	.word	150
	.word	237
	.word	43
	.word	271
	.word	255
	.word	24
	.word	470
	.word	10
	.word	503
	.word	344
	.word	488
	.word	511
	.word	431
	.word	490
	.word	270
	.word	317
	.word	180
	.word	334
	.word	434
	.word	254
	.word	203
	.word	110
	.word	426
	.word	450
	.word	175
	.word	145
	.word	220
	.word	411
	.word	478
	.word	156
	.word	271
	.word	483
	.word	319
	.word	81
	.word	149
	.word	175
	.word	424
	.word	165
	.word	326
	.word	512
	.word	53
	.word	108
	.word	432
	.word	217
	.word	146
	.word	107
	.word	108
	.word	401
	.word	339
	.word	412
	.word	336
	.word	211
	.word	68
	.word	120
	.word	153
	.word	415
	.word	314
	.word	307
	.word	26
	.word	374
	.word	458
	.word	8
	.word	226
	.word	49
	.word	458
	.word	8
	.word	369
	.word	43
	.word	205
	.word	241
	.word	471
	.word	73
	.word	363
	.word	203
	.word	443
	.word	457
	.word	186
	.word	102
	.word	405
	.word	343
	.word	190
	.word	84
	.word	43
	.word	13
	.word	379
	.word	89
	.word	43
	.word	435
	.word	164
	.word	89
	.word	111
	.word	135
	.word	446
	.word	186
	.word	120
	.word	149
	.word	165
	.word	264
	.word	23
	.word	15
	.word	254
	.word	309
	.word	376
	.word	301
	.word	149
	.word	93
	.word	415
	.word	205
	.word	245
	.word	74
	.word	304
	.word	163
	.word	256
	.word	7
	.word	7
	.word	188
	.word	182
	.word	316
	.word	11
	.word	52
	.word	380
	.word	246
	.word	305
	.word	228
	.word	429
	.word	87
	.word	422
	.word	368
	.word	85
	.word	28
	.word	271
	.word	423
	.word	81
	.word	44
	.word	128
	.word	456
	.word	365
	.word	353
	.word	20
	.word	75
	.word	131
	.word	376
	.word	40
	.word	495
	.word	273
	.word	143
	.word	306
	.word	352
	.word	13
	.word	491
	.word	429
	.word	391
	.word	395
	.word	502
	.word	72
	.word	391
	.word	71
	.word	271
	.word	467
	.word	397
	.word	95
	.word	438
	.word	475
	.word	118
	.word	485
	.word	427
	.word	160
	.word	34
	.word	149
	.word	165
	.word	90
	.word	377
	.word	8
	.word	405
	.word	42
	.word	50
	.word	160
	.word	501
	.word	22
	.word	24
	.word	185
	.word	172
	.word	402
	.word	123
	.word	247
	.word	479
	.word	183
	.word	10
	.word	440
	.word	403
	.word	43
	.word	103
	.word	204
	.word	428
	.word	300
	.word	253
	.word	312
	.word	217
	.word	384
	.word	254
	.word	16
	.word	375
	.word	212
	.word	418
	.word	312
	.word	301
	.word	214
	.word	55
	.word	11
	.word	509
	.word	362
	.word	200
	.word	224
	.word	484
	.word	136
	.word	475
	.word	477
	.word	266
	.word	410
	.word	244
	.word	256
	.word	217
	.word	372
	.word	460
	.word	497
	.word	3
	.word	316
	.word	477
	.word	474
	.word	61
	.word	462
	.word	332
	.word	111
	.word	183
	.word	478
	.word	29
	.word	365
	.word	511
	.word	421
	.word	453
	.word	287
	.word	141
	.word	177
	.word	100
	.word	81
	.word	266
	.word	451
	.word	235
	.word	235
	.word	198
	.word	262
	.word	409
	.word	207
	.word	269
	.word	493
	.word	192
	.word	482
	.word	43
	.word	312
	.word	492
	.word	261
	.word	10
	.word	245
	.word	221
	.word	106
	.word	288
	.word	58
	.word	444
	.word	110
	.word	6
	.word	10
	.word	373
	.word	211
	.word	323
	.word	159
	.word	274
	.word	210
	.word	209
	.word	314
	.word	78
	.word	75
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 4104
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #4096
	sub	sp, sp, #12
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L2
.L3:
	movw	r3, #:lower16:nums1k1
	movt	r3, #:upper16:nums1k1
	ldr	r2, [fp, #-8]
	ldr	r2, [r3, r2, asl #2]
	movw	r3, #:lower16:nums1k2
	movt	r3, #:upper16:nums1k2
	ldr	r1, [fp, #-8]
	ldr	r3, [r3, r1, asl #2]
	add	r2, r2, r3
	sub	r3, fp, #4096
	sub	r3, r3, #4
	mov	r1, r3
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	add	r3, r1, r3
	str	r2, [r3, #-4]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r3, [fp, #-8]
	cmp	r3, #1024
	blt	.L3
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	main, .-main
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
