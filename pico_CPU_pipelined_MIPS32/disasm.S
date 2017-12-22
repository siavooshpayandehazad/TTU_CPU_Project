
simple_add_0.elf:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <.text>:
       0:	3c1c0001 	lui	gp,0x1
       4:	279cab30 	addiu	gp,gp,-21712
       8:	3c050000 	lui	a1,0x0
       c:	24a52b40 	addiu	a1,a1,11072
      10:	3c040000 	lui	a0,0x0
      14:	24842df0 	addiu	a0,a0,11760
      18:	3c1d0000 	lui	sp,0x0
      1c:	27bd2d58 	addiu	sp,sp,11608
      20:	aca00000 	sw	zero,0(a1)
      24:	00a4182a 	slt	v1,a1,a0
      28:	1460fffd 	bnez	v1,0x20
      2c:	24a50004 	addiu	a1,a1,4
      30:	0c0008ac 	jal	0x22b0
      34:	00000000 	nop
      38:	0800000e 	j	0x38
      3c:	23bdff98 	addi	sp,sp,-104
      40:	afa10010 	sw	at,16(sp)
      44:	afa20014 	sw	v0,20(sp)
      48:	afa30018 	sw	v1,24(sp)
      4c:	afa4001c 	sw	a0,28(sp)
      50:	afa50020 	sw	a1,32(sp)
      54:	afa60024 	sw	a2,36(sp)
      58:	afa70028 	sw	a3,40(sp)
      5c:	afa8002c 	sw	t0,44(sp)
      60:	afa90030 	sw	t1,48(sp)
      64:	afaa0034 	sw	t2,52(sp)
      68:	afab0038 	sw	t3,56(sp)
      6c:	afac003c 	sw	t4,60(sp)
      70:	afad0040 	sw	t5,64(sp)
      74:	afae0044 	sw	t6,68(sp)
      78:	afaf0048 	sw	t7,72(sp)
      7c:	afb8004c 	sw	t8,76(sp)
      80:	afb90050 	sw	t9,80(sp)
      84:	afbf0054 	sw	ra,84(sp)
      88:	401a7000 	mfc0	k0,c0_epc
      8c:	235afffc 	addi	k0,k0,-4
      90:	afba0058 	sw	k0,88(sp)
      94:	0000d810 	mfhi	k1
      98:	afbb005c 	sw	k1,92(sp)
      9c:	0000d812 	mflo	k1
      a0:	afbb0060 	sw	k1,96(sp)
      a4:	3c062000 	lui	a2,0x2000
      a8:	8cc40020 	lw	a0,32(a2)
      ac:	8cc60010 	lw	a2,16(a2)
      b0:	00862024 	and	a0,a0,a2
      b4:	0c0007cc 	jal	0x1f30
      b8:	23a50000 	addi	a1,sp,0
      bc:	8fa10010 	lw	at,16(sp)
      c0:	8fa20014 	lw	v0,20(sp)
      c4:	8fa30018 	lw	v1,24(sp)
      c8:	8fa4001c 	lw	a0,28(sp)
      cc:	8fa50020 	lw	a1,32(sp)
      d0:	8fa60024 	lw	a2,36(sp)
      d4:	8fa70028 	lw	a3,40(sp)
      d8:	8fa8002c 	lw	t0,44(sp)
      dc:	8fa90030 	lw	t1,48(sp)
      e0:	8faa0034 	lw	t2,52(sp)
      e4:	8fab0038 	lw	t3,56(sp)
      e8:	8fac003c 	lw	t4,60(sp)
      ec:	8fad0040 	lw	t5,64(sp)
      f0:	8fae0044 	lw	t6,68(sp)
      f4:	8faf0048 	lw	t7,72(sp)
      f8:	8fb8004c 	lw	t8,76(sp)
      fc:	8fb90050 	lw	t9,80(sp)
     100:	8fbf0054 	lw	ra,84(sp)
     104:	8fba0058 	lw	k0,88(sp)
     108:	8fbb005c 	lw	k1,92(sp)
     10c:	03600011 	mthi	k1
     110:	8fbb0060 	lw	k1,96(sp)
     114:	03600013 	mtlo	k1
     118:	23bd0068 	addi	sp,sp,104
     11c:	341b0001 	li	k1,0x1
     120:	03400008 	jr	k0
     124:	409b6000 	mtc0	k1,c0_sr
     128:	40026000 	mfc0	v0,c0_sr
     12c:	03e00008 	jr	ra
     130:	40846000 	mtc0	a0,c0_sr
     134:	3c050000 	lui	a1,0x0
     138:	24a50160 	addiu	a1,a1,352
     13c:	8ca60000 	lw	a2,0(a1)
     140:	ac06003c 	sw	a2,60(zero)
     144:	8ca60004 	lw	a2,4(a1)
     148:	ac060040 	sw	a2,64(zero)
     14c:	8ca60008 	lw	a2,8(a1)
     150:	ac060044 	sw	a2,68(zero)
     154:	8ca6000c 	lw	a2,12(a1)
     158:	03e00008 	jr	ra
     15c:	ac060048 	sw	a2,72(zero)
     160:	3c1a1000 	lui	k0,0x1000
     164:	375a003c 	ori	k0,k0,0x3c
     168:	03400008 	jr	k0
     16c:	00000000 	nop
     170:	ac900000 	sw	s0,0(a0)
     174:	ac910004 	sw	s1,4(a0)
     178:	ac920008 	sw	s2,8(a0)
     17c:	ac93000c 	sw	s3,12(a0)
     180:	ac940010 	sw	s4,16(a0)
     184:	ac950014 	sw	s5,20(a0)
     188:	ac960018 	sw	s6,24(a0)
     18c:	ac97001c 	sw	s7,28(a0)
     190:	ac9e0020 	sw	s8,32(a0)
     194:	ac9c0024 	sw	gp,36(a0)
     198:	ac9d0028 	sw	sp,40(a0)
     19c:	ac9f002c 	sw	ra,44(a0)
     1a0:	03e00008 	jr	ra
     1a4:	34020000 	li	v0,0x0
     1a8:	8c900000 	lw	s0,0(a0)
     1ac:	8c910004 	lw	s1,4(a0)
     1b0:	8c920008 	lw	s2,8(a0)
     1b4:	8c93000c 	lw	s3,12(a0)
     1b8:	8c940010 	lw	s4,16(a0)
     1bc:	8c950014 	lw	s5,20(a0)
     1c0:	8c960018 	lw	s6,24(a0)
     1c4:	8c97001c 	lw	s7,28(a0)
     1c8:	8c9e0020 	lw	s8,32(a0)
     1cc:	8c9c0024 	lw	gp,36(a0)
     1d0:	8c9d0028 	lw	sp,40(a0)
     1d4:	8c9f002c 	lw	ra,44(a0)
     1d8:	03e00008 	jr	ra
     1dc:	34a20000 	ori	v0,a1,0x0
     1e0:	00850019 	multu	a0,a1
     1e4:	00001012 	mflo	v0
     1e8:	00002010 	mfhi	a0
     1ec:	03e00008 	jr	ra
     1f0:	acc40000 	sw	a0,0(a2)
     1f4:	0000000c 	syscall
     1f8:	03e00008 	jr	ra
     1fc:	00000000 	nop
     200:	27bdfff0 	addiu	sp,sp,-16
     204:	afbe000c 	sw	s8,12(sp)
     208:	03a0f025 	move	s8,sp
     20c:	afc40010 	sw	a0,16(s8)
     210:	afc50014 	sw	a1,20(s8)
     214:	8fc30010 	lw	v1,16(s8)
     218:	8fc20014 	lw	v0,20(s8)
     21c:	00000000 	nop
     220:	14400002 	bnez	v0,0x22c
     224:	0062001b 	divu	zero,v1,v0
     228:	0007000d 	break	0x7
     22c:	00001010 	mfhi	v0
     230:	00001012 	mflo	v0
     234:	afc20000 	sw	v0,0(s8)
     238:	34028010 	li	v0,0x8010
     23c:	8fc30000 	lw	v1,0(s8)
     240:	00000000 	nop
     244:	ac430000 	sw	v1,0(v0)
     248:	00000000 	nop
     24c:	03c0e825 	move	sp,s8
     250:	8fbe000c 	lw	s8,12(sp)
     254:	27bd0010 	addiu	sp,sp,16
     258:	03e00008 	jr	ra
     25c:	00000000 	nop
     260:	27bdfff8 	addiu	sp,sp,-8
     264:	afbe0004 	sw	s8,4(sp)
     268:	03a0f025 	move	s8,sp
     26c:	afc40008 	sw	a0,8(s8)
     270:	00000000 	nop
     274:	3c022000 	lui	v0,0x2000
     278:	34420020 	ori	v0,v0,0x20
     27c:	8c420000 	lw	v0,0(v0)
     280:	00000000 	nop
     284:	30420002 	andi	v0,v0,0x2
     288:	1040fffa 	beqz	v0,0x274
     28c:	00000000 	nop
     290:	3c022000 	lui	v0,0x2000
     294:	8fc30008 	lw	v1,8(s8)
     298:	00000000 	nop
     29c:	ac430000 	sw	v1,0(v0)
     2a0:	00000000 	nop
     2a4:	03c0e825 	move	sp,s8
     2a8:	8fbe0004 	lw	s8,4(sp)
     2ac:	27bd0008 	addiu	sp,sp,8
     2b0:	03e00008 	jr	ra
     2b4:	00000000 	nop
     2b8:	27bdffe8 	addiu	sp,sp,-24
     2bc:	afbf0014 	sw	ra,20(sp)
     2c0:	afbe0010 	sw	s8,16(sp)
     2c4:	03a0f025 	move	s8,sp
     2c8:	afc40018 	sw	a0,24(s8)
     2cc:	10000013 	b	0x31c
     2d0:	00000000 	nop
     2d4:	8fc20018 	lw	v0,24(s8)
     2d8:	00000000 	nop
     2dc:	80430000 	lb	v1,0(v0)
     2e0:	2402000a 	li	v0,10
     2e4:	14620004 	bne	v1,v0,0x2f8
     2e8:	00000000 	nop
     2ec:	2404000d 	li	a0,13
     2f0:	0c000098 	jal	0x260
     2f4:	00000000 	nop
     2f8:	8fc20018 	lw	v0,24(s8)
     2fc:	00000000 	nop
     300:	24430001 	addiu	v1,v0,1
     304:	afc30018 	sw	v1,24(s8)
     308:	80420000 	lb	v0,0(v0)
     30c:	00000000 	nop
     310:	00402025 	move	a0,v0
     314:	0c000098 	jal	0x260
     318:	00000000 	nop
     31c:	8fc20018 	lw	v0,24(s8)
     320:	00000000 	nop
     324:	80420000 	lb	v0,0(v0)
     328:	00000000 	nop
     32c:	1440ffe9 	bnez	v0,0x2d4
     330:	00000000 	nop
     334:	00000000 	nop
     338:	03c0e825 	move	sp,s8
     33c:	8fbf0014 	lw	ra,20(sp)
     340:	8fbe0010 	lw	s8,16(sp)
     344:	27bd0018 	addiu	sp,sp,24
     348:	03e00008 	jr	ra
     34c:	00000000 	nop
     350:	27bdffe0 	addiu	sp,sp,-32
     354:	afbf001c 	sw	ra,28(sp)
     358:	afbe0018 	sw	s8,24(sp)
     35c:	03a0f025 	move	s8,sp
     360:	afc40020 	sw	a0,32(s8)
     364:	2402001c 	li	v0,28
     368:	afc20010 	sw	v0,16(s8)
     36c:	1000001e 	b	0x3e8
     370:	00000000 	nop
     374:	8fc30020 	lw	v1,32(s8)
     378:	8fc20010 	lw	v0,16(s8)
     37c:	00000000 	nop
     380:	00431006 	srlv	v0,v1,v0
     384:	3042000f 	andi	v0,v0,0xf
     388:	afc20014 	sw	v0,20(s8)
     38c:	8fc20014 	lw	v0,20(s8)
     390:	00000000 	nop
     394:	2c42000a 	sltiu	v0,v0,10
     398:	10400009 	beqz	v0,0x3c0
     39c:	00000000 	nop
     3a0:	8fc20014 	lw	v0,20(s8)
     3a4:	00000000 	nop
     3a8:	24420030 	addiu	v0,v0,48
     3ac:	00402025 	move	a0,v0
     3b0:	0c000098 	jal	0x260
     3b4:	00000000 	nop
     3b8:	10000007 	b	0x3d8
     3bc:	00000000 	nop
     3c0:	8fc20014 	lw	v0,20(s8)
     3c4:	00000000 	nop
     3c8:	24420057 	addiu	v0,v0,87
     3cc:	00402025 	move	a0,v0
     3d0:	0c000098 	jal	0x260
     3d4:	00000000 	nop
     3d8:	8fc20010 	lw	v0,16(s8)
     3dc:	00000000 	nop
     3e0:	2442fffc 	addiu	v0,v0,-4
     3e4:	afc20010 	sw	v0,16(s8)
     3e8:	8fc20010 	lw	v0,16(s8)
     3ec:	00000000 	nop
     3f0:	0441ffe0 	bgez	v0,0x374
     3f4:	00000000 	nop
     3f8:	00000000 	nop
     3fc:	03c0e825 	move	sp,s8
     400:	8fbf001c 	lw	ra,28(sp)
     404:	8fbe0018 	lw	s8,24(sp)
     408:	27bd0020 	addiu	sp,sp,32
     40c:	03e00008 	jr	ra
     410:	00000000 	nop
     414:	27bdff60 	addiu	sp,sp,-160
     418:	afbf009c 	sw	ra,156(sp)
     41c:	afbe0098 	sw	s8,152(sp)
     420:	03a0f025 	move	s8,sp
     424:	afc400a0 	sw	a0,160(s8)
     428:	afc500a4 	sw	a1,164(s8)
     42c:	afc600a8 	sw	a2,168(s8)
     430:	27c300a8 	addiu	v1,s8,168
     434:	27c20014 	addiu	v0,s8,20
     438:	00603825 	move	a3,v1
     43c:	8fc600a4 	lw	a2,164(s8)
     440:	00402825 	move	a1,v0
     444:	8fc400a0 	lw	a0,160(s8)
     448:	0c000716 	jal	0x1c58
     44c:	00000000 	nop
     450:	27c20014 	addiu	v0,s8,20
     454:	afc20010 	sw	v0,16(s8)
     458:	10000018 	b	0x4bc
     45c:	00000000 	nop
     460:	8fc20010 	lw	v0,16(s8)
     464:	00000000 	nop
     468:	24430001 	addiu	v1,v0,1
     46c:	afc30010 	sw	v1,16(s8)
     470:	80420000 	lb	v0,0(v0)
     474:	00000000 	nop
     478:	00402025 	move	a0,v0
     47c:	0c000098 	jal	0x260
     480:	00000000 	nop
     484:	8fc20010 	lw	v0,16(s8)
     488:	00000000 	nop
     48c:	2442ffff 	addiu	v0,v0,-1
     490:	80430000 	lb	v1,0(v0)
     494:	2402000a 	li	v0,10
     498:	14620008 	bne	v1,v0,0x4bc
     49c:	00000000 	nop
     4a0:	8fc20010 	lw	v0,16(s8)
     4a4:	00000000 	nop
     4a8:	2442ffff 	addiu	v0,v0,-1
     4ac:	afc20010 	sw	v0,16(s8)
     4b0:	8fc20010 	lw	v0,16(s8)
     4b4:	2403000d 	li	v1,13
     4b8:	a0430000 	sb	v1,0(v0)
     4bc:	8fc20010 	lw	v0,16(s8)
     4c0:	00000000 	nop
     4c4:	80420000 	lb	v0,0(v0)
     4c8:	00000000 	nop
     4cc:	1440ffe4 	bnez	v0,0x460
     4d0:	00000000 	nop
     4d4:	00000000 	nop
     4d8:	03c0e825 	move	sp,s8
     4dc:	8fbf009c 	lw	ra,156(sp)
     4e0:	8fbe0098 	lw	s8,152(sp)
     4e4:	27bd00a0 	addiu	sp,sp,160
     4e8:	03e00008 	jr	ra
     4ec:	00000000 	nop
     4f0:	27bdfff8 	addiu	sp,sp,-8
     4f4:	afbe0004 	sw	s8,4(sp)
     4f8:	03a0f025 	move	s8,sp
     4fc:	3c022000 	lui	v0,0x2000
     500:	34420020 	ori	v0,v0,0x20
     504:	8c420000 	lw	v0,0(v0)
     508:	00000000 	nop
     50c:	30420001 	andi	v0,v0,0x1
     510:	03c0e825 	move	sp,s8
     514:	8fbe0004 	lw	s8,4(sp)
     518:	27bd0008 	addiu	sp,sp,8
     51c:	03e00008 	jr	ra
     520:	00000000 	nop
     524:	27bdffe8 	addiu	sp,sp,-24
     528:	afbf0014 	sw	ra,20(sp)
     52c:	afbe0010 	sw	s8,16(sp)
     530:	03a0f025 	move	s8,sp
     534:	00000000 	nop
     538:	0c00013c 	jal	0x4f0
     53c:	00000000 	nop
     540:	1040fffd 	beqz	v0,0x538
     544:	00000000 	nop
     548:	3c022000 	lui	v0,0x2000
     54c:	8c420000 	lw	v0,0(v0)
     550:	00000000 	nop
     554:	00021600 	sll	v0,v0,0x18
     558:	00021603 	sra	v0,v0,0x18
     55c:	03c0e825 	move	sp,s8
     560:	8fbf0014 	lw	ra,20(sp)
     564:	8fbe0010 	lw	s8,16(sp)
     568:	27bd0018 	addiu	sp,sp,24
     56c:	03e00008 	jr	ra
     570:	00000000 	nop
	...
     580:	27bdffe0 	addiu	sp,sp,-32
     584:	afbf001c 	sw	ra,28(sp)
     588:	afbe0018 	sw	s8,24(sp)
     58c:	03a0f025 	move	s8,sp
     590:	3c020000 	lui	v0,0x0
     594:	244428cc 	addiu	a0,v0,10444
     598:	0c0000ae 	jal	0x2b8
     59c:	00000000 	nop
     5a0:	3c020000 	lui	v0,0x0
     5a4:	244428e4 	addiu	a0,v0,10468
     5a8:	0c0000ae 	jal	0x2b8
     5ac:	00000000 	nop
     5b0:	3c020000 	lui	v0,0x0
     5b4:	244428f8 	addiu	a0,v0,10488
     5b8:	0c0000ae 	jal	0x2b8
     5bc:	00000000 	nop
     5c0:	24060001 	li	a2,1
     5c4:	3c020000 	lui	v0,0x0
     5c8:	2445259c 	addiu	a1,v0,9628
     5cc:	3c021234 	lui	v0,0x1234
     5d0:	34445678 	ori	a0,v0,0x5678
     5d4:	0c000288 	jal	0xa20
     5d8:	00000000 	nop
     5dc:	24060002 	li	a2,2
     5e0:	3c020000 	lui	v0,0x0
     5e4:	2445261c 	addiu	a1,v0,9756
     5e8:	3c029234 	lui	v0,0x9234
     5ec:	34445678 	ori	a0,v0,0x5678
     5f0:	0c000288 	jal	0xa20
     5f4:	00000000 	nop
     5f8:	3c020000 	lui	v0,0x0
     5fc:	24442910 	addiu	a0,v0,10512
     600:	0c0000ae 	jal	0x2b8
     604:	00000000 	nop
     608:	3c020000 	lui	v0,0x0
     60c:	244428f8 	addiu	a0,v0,10488
     610:	0c0000ae 	jal	0x2b8
     614:	00000000 	nop
     618:	24020001 	li	v0,1
     61c:	afa20014 	sw	v0,20(sp)
     620:	3c020000 	lui	v0,0x0
     624:	244226f0 	addiu	v0,v0,9968
     628:	afa20010 	sw	v0,16(sp)
     62c:	3c020000 	lui	v0,0x0
     630:	244726cc 	addiu	a3,v0,9932
     634:	3c020000 	lui	v0,0x0
     638:	244626b4 	addiu	a2,v0,9908
     63c:	3c020000 	lui	v0,0x0
     640:	2445269c 	addiu	a1,v0,9884
     644:	24040007 	li	a0,7
     648:	0c0002e7 	jal	0xb9c
     64c:	00000000 	nop
     650:	24020002 	li	v0,2
     654:	afa20014 	sw	v0,20(sp)
     658:	3c020000 	lui	v0,0x0
     65c:	24422768 	addiu	v0,v0,10088
     660:	afa20010 	sw	v0,16(sp)
     664:	3c020000 	lui	v0,0x0
     668:	24472744 	addiu	a3,v0,10052
     66c:	3c020000 	lui	v0,0x0
     670:	2446272c 	addiu	a2,v0,10028
     674:	3c020000 	lui	v0,0x0
     678:	24452714 	addiu	a1,v0,10004
     67c:	24040321 	li	a0,801
     680:	0c0002e7 	jal	0xb9c
     684:	00000000 	nop
     688:	24020003 	li	v0,3
     68c:	afa20014 	sw	v0,20(sp)
     690:	3c020000 	lui	v0,0x0
     694:	244227e0 	addiu	v0,v0,10208
     698:	afa20010 	sw	v0,16(sp)
     69c:	3c020000 	lui	v0,0x0
     6a0:	244727bc 	addiu	a3,v0,10172
     6a4:	3c020000 	lui	v0,0x0
     6a8:	244627a4 	addiu	a2,v0,10148
     6ac:	3c020000 	lui	v0,0x0
     6b0:	2445278c 	addiu	a1,v0,10124
     6b4:	3c020005 	lui	v0,0x5
     6b8:	34444321 	ori	a0,v0,0x4321
     6bc:	0c0002e7 	jal	0xb9c
     6c0:	00000000 	nop
     6c4:	24020004 	li	v0,4
     6c8:	afa20014 	sw	v0,20(sp)
     6cc:	3c020000 	lui	v0,0x0
     6d0:	24422858 	addiu	v0,v0,10328
     6d4:	afa20010 	sw	v0,16(sp)
     6d8:	3c020000 	lui	v0,0x0
     6dc:	24472834 	addiu	a3,v0,10292
     6e0:	3c020000 	lui	v0,0x0
     6e4:	2446281c 	addiu	a2,v0,10268
     6e8:	3c020000 	lui	v0,0x0
     6ec:	24452804 	addiu	a1,v0,10244
     6f0:	3c020001 	lui	v0,0x1
     6f4:	34442345 	ori	a0,v0,0x2345
     6f8:	0c0002e7 	jal	0xb9c
     6fc:	00000000 	nop
     700:	3c020000 	lui	v0,0x0
     704:	24442938 	addiu	a0,v0,10552
     708:	0c0000ae 	jal	0x2b8
     70c:	00000000 	nop
     710:	3c020000 	lui	v0,0x0
     714:	244428f8 	addiu	a0,v0,10488
     718:	0c0000ae 	jal	0x2b8
     71c:	00000000 	nop
     720:	0c0003fe 	jal	0xff8
     724:	00000000 	nop
     728:	3c020000 	lui	v0,0x0
     72c:	24442958 	addiu	a0,v0,10584
     730:	0c0000ae 	jal	0x2b8
     734:	00000000 	nop
     738:	3c020000 	lui	v0,0x0
     73c:	244428f8 	addiu	a0,v0,10488
     740:	0c0000ae 	jal	0x2b8
     744:	00000000 	nop
     748:	0c000563 	jal	0x158c
     74c:	00000000 	nop
     750:	3c020000 	lui	v0,0x0
     754:	24442970 	addiu	a0,v0,10608
     758:	0c0000ae 	jal	0x2b8
     75c:	00000000 	nop
     760:	3c020000 	lui	v0,0x0
     764:	244428f8 	addiu	a0,v0,10488
     768:	0c0000ae 	jal	0x2b8
     76c:	00000000 	nop
     770:	0c00048b 	jal	0x122c
     774:	00000000 	nop
     778:	3c020000 	lui	v0,0x0
     77c:	24442988 	addiu	a0,v0,10632
     780:	0c0000ae 	jal	0x2b8
     784:	00000000 	nop
     788:	3c020000 	lui	v0,0x0
     78c:	244428f8 	addiu	a0,v0,10488
     790:	0c0000ae 	jal	0x2b8
     794:	00000000 	nop
     798:	0c000214 	jal	0x850
     79c:	00000000 	nop
     7a0:	3c020000 	lui	v0,0x0
     7a4:	244429b8 	addiu	a0,v0,10680
     7a8:	0c0000ae 	jal	0x2b8
     7ac:	00000000 	nop
     7b0:	3c020000 	lui	v0,0x0
     7b4:	244429c8 	addiu	a0,v0,10696
     7b8:	0c0000ae 	jal	0x2b8
     7bc:	00000000 	nop
     7c0:	3c020000 	lui	v0,0x0
     7c4:	8c422b50 	lw	v0,11088(v0)
     7c8:	00000000 	nop
     7cc:	14400007 	bnez	v0,0x7ec
     7d0:	00000000 	nop
     7d4:	3c020000 	lui	v0,0x0
     7d8:	244429d8 	addiu	a0,v0,10712
     7dc:	0c0000ae 	jal	0x2b8
     7e0:	00000000 	nop
     7e4:	10000013 	b	0x834
     7e8:	00000000 	nop
     7ec:	3c020000 	lui	v0,0x0
     7f0:	244429e0 	addiu	a0,v0,10720
     7f4:	0c0000ae 	jal	0x2b8
     7f8:	00000000 	nop
     7fc:	3c020000 	lui	v0,0x0
     800:	244429ec 	addiu	a0,v0,10732
     804:	0c0000ae 	jal	0x2b8
     808:	00000000 	nop
     80c:	3c020000 	lui	v0,0x0
     810:	8c422b50 	lw	v0,11088(v0)
     814:	00003025 	move	a2,zero
     818:	2405000a 	li	a1,10
     81c:	00402025 	move	a0,v0
     820:	0c000105 	jal	0x414
     824:	00000000 	nop
     828:	2404000a 	li	a0,10
     82c:	0c000098 	jal	0x260
     830:	00000000 	nop
     834:	00000000 	nop
     838:	03c0e825 	move	sp,s8
     83c:	8fbf001c 	lw	ra,28(sp)
     840:	8fbe0018 	lw	s8,24(sp)
     844:	27bd0020 	addiu	sp,sp,32
     848:	03e00008 	jr	ra
     84c:	00000000 	nop
     850:	27bdffd8 	addiu	sp,sp,-40
     854:	afbf0024 	sw	ra,36(sp)
     858:	afbe0020 	sw	s8,32(sp)
     85c:	03a0f025 	move	s8,sp
     860:	afc00018 	sw	zero,24(s8)
     864:	afc0001c 	sw	zero,28(s8)
     868:	24020003 	li	v0,3
     86c:	afc20010 	sw	v0,16(s8)
     870:	1000004b 	b	0x9a0
     874:	00000000 	nop
     878:	24020003 	li	v0,3
     87c:	afc20014 	sw	v0,20(s8)
     880:	10000011 	b	0x8c8
     884:	00000000 	nop
     888:	8fc30010 	lw	v1,16(s8)
     88c:	8fc20014 	lw	v0,20(s8)
     890:	00000000 	nop
     894:	14400002 	bnez	v0,0x8a0
     898:	0062001a 	div	zero,v1,v0
     89c:	0007000d 	break	0x7
     8a0:	00001010 	mfhi	v0
     8a4:	14400004 	bnez	v0,0x8b8
     8a8:	00000000 	nop
     8ac:	afc00014 	sw	zero,20(s8)
     8b0:	1000000b 	b	0x8e0
     8b4:	00000000 	nop
     8b8:	8fc20014 	lw	v0,20(s8)
     8bc:	00000000 	nop
     8c0:	24420002 	addiu	v0,v0,2
     8c4:	afc20014 	sw	v0,20(s8)
     8c8:	8fc30014 	lw	v1,20(s8)
     8cc:	8fc20010 	lw	v0,16(s8)
     8d0:	00000000 	nop
     8d4:	0062102a 	slt	v0,v1,v0
     8d8:	1440ffeb 	bnez	v0,0x888
     8dc:	00000000 	nop
     8e0:	8fc20014 	lw	v0,20(s8)
     8e4:	00000000 	nop
     8e8:	10400026 	beqz	v0,0x984
     8ec:	00000000 	nop
     8f0:	00003025 	move	a2,zero
     8f4:	2405000a 	li	a1,10
     8f8:	8fc40010 	lw	a0,16(s8)
     8fc:	0c000105 	jal	0x414
     900:	00000000 	nop
     904:	2404003a 	li	a0,58
     908:	0c000098 	jal	0x260
     90c:	00000000 	nop
     910:	3c020000 	lui	v0,0x0
     914:	8fc30018 	lw	v1,24(s8)
     918:	00000000 	nop
     91c:	00031880 	sll	v1,v1,0x2
     920:	24422300 	addiu	v0,v0,8960
     924:	00621021 	addu	v0,v1,v0
     928:	8c420000 	lw	v0,0(v0)
     92c:	00003025 	move	a2,zero
     930:	2405000a 	li	a1,10
     934:	00402025 	move	a0,v0
     938:	0c000105 	jal	0x414
     93c:	00000000 	nop
     940:	3c020000 	lui	v0,0x0
     944:	8fc30018 	lw	v1,24(s8)
     948:	00000000 	nop
     94c:	00031880 	sll	v1,v1,0x2
     950:	24422300 	addiu	v0,v0,8960
     954:	00621021 	addu	v0,v1,v0
     958:	8c430000 	lw	v1,0(v0)
     95c:	8fc20010 	lw	v0,16(s8)
     960:	00000000 	nop
     964:	10620003 	beq	v1,v0,0x974
     968:	00000000 	nop
     96c:	24020001 	li	v0,1
     970:	afc2001c 	sw	v0,28(s8)
     974:	8fc20018 	lw	v0,24(s8)
     978:	00000000 	nop
     97c:	24420001 	addiu	v0,v0,1
     980:	afc20018 	sw	v0,24(s8)
     984:	24040020 	li	a0,32
     988:	0c000098 	jal	0x260
     98c:	00000000 	nop
     990:	8fc20010 	lw	v0,16(s8)
     994:	00000000 	nop
     998:	24420002 	addiu	v0,v0,2
     99c:	afc20010 	sw	v0,16(s8)
     9a0:	8fc20010 	lw	v0,16(s8)
     9a4:	00000000 	nop
     9a8:	284203e8 	slti	v0,v0,1000
     9ac:	1440ffb2 	bnez	v0,0x878
     9b0:	00000000 	nop
     9b4:	8fc3001c 	lw	v1,28(s8)
     9b8:	24020001 	li	v0,1
     9bc:	1462000d 	bne	v1,v0,0x9f4
     9c0:	00000000 	nop
     9c4:	3c020000 	lui	v0,0x0
     9c8:	24442a04 	addiu	a0,v0,10756
     9cc:	0c0000ae 	jal	0x2b8
     9d0:	00000000 	nop
     9d4:	3c020000 	lui	v0,0x0
     9d8:	8c422b50 	lw	v0,11088(v0)
     9dc:	00000000 	nop
     9e0:	24430001 	addiu	v1,v0,1
     9e4:	3c020000 	lui	v0,0x0
     9e8:	ac432b50 	sw	v1,11088(v0)
     9ec:	10000005 	b	0xa04
     9f0:	00000000 	nop
     9f4:	3c020000 	lui	v0,0x0
     9f8:	24442a2c 	addiu	a0,v0,10796
     9fc:	0c0000ae 	jal	0x2b8
     a00:	00000000 	nop
     a04:	00000000 	nop
     a08:	03c0e825 	move	sp,s8
     a0c:	8fbf0024 	lw	ra,36(sp)
     a10:	8fbe0020 	lw	s8,32(sp)
     a14:	27bd0028 	addiu	sp,sp,40
     a18:	03e00008 	jr	ra
     a1c:	00000000 	nop
     a20:	27bdffd8 	addiu	sp,sp,-40
     a24:	afbf0024 	sw	ra,36(sp)
     a28:	afbe0020 	sw	s8,32(sp)
     a2c:	03a0f025 	move	s8,sp
     a30:	afc40028 	sw	a0,40(s8)
     a34:	afc5002c 	sw	a1,44(s8)
     a38:	afc60030 	sw	a2,48(s8)
     a3c:	afc00014 	sw	zero,20(s8)
     a40:	a7c00010 	sh	zero,16(s8)
     a44:	1000002c 	b	0xaf8
     a48:	00000000 	nop
     a4c:	87c20010 	lh	v0,16(s8)
     a50:	8fc30028 	lw	v1,40(s8)
     a54:	00000000 	nop
     a58:	00431007 	srav	v0,v1,v0
     a5c:	afc20018 	sw	v0,24(s8)
     a60:	8fc40018 	lw	a0,24(s8)
     a64:	0c0000d4 	jal	0x350
     a68:	00000000 	nop
     a6c:	2404003a 	li	a0,58
     a70:	0c000098 	jal	0x260
     a74:	00000000 	nop
     a78:	87c20010 	lh	v0,16(s8)
     a7c:	00000000 	nop
     a80:	00021080 	sll	v0,v0,0x2
     a84:	8fc3002c 	lw	v1,44(s8)
     a88:	00000000 	nop
     a8c:	00621021 	addu	v0,v1,v0
     a90:	8c420000 	lw	v0,0(v0)
     a94:	00000000 	nop
     a98:	00402025 	move	a0,v0
     a9c:	0c0000d4 	jal	0x350
     aa0:	00000000 	nop
     aa4:	24040020 	li	a0,32
     aa8:	0c000098 	jal	0x260
     aac:	00000000 	nop
     ab0:	87c20010 	lh	v0,16(s8)
     ab4:	00000000 	nop
     ab8:	00021080 	sll	v0,v0,0x2
     abc:	8fc3002c 	lw	v1,44(s8)
     ac0:	00000000 	nop
     ac4:	00621021 	addu	v0,v1,v0
     ac8:	8c430000 	lw	v1,0(v0)
     acc:	8fc20018 	lw	v0,24(s8)
     ad0:	00000000 	nop
     ad4:	10620003 	beq	v1,v0,0xae4
     ad8:	00000000 	nop
     adc:	24020001 	li	v0,1
     ae0:	afc20014 	sw	v0,20(s8)
     ae4:	97c20010 	lhu	v0,16(s8)
     ae8:	00000000 	nop
     aec:	24420001 	addiu	v0,v0,1
     af0:	3042ffff 	andi	v0,v0,0xffff
     af4:	a7c20010 	sh	v0,16(s8)
     af8:	87c20010 	lh	v0,16(s8)
     afc:	00000000 	nop
     b00:	28420020 	slti	v0,v0,32
     b04:	1440ffd1 	bnez	v0,0xa4c
     b08:	00000000 	nop
     b0c:	3c020000 	lui	v0,0x0
     b10:	24442a54 	addiu	a0,v0,10836
     b14:	0c0000ae 	jal	0x2b8
     b18:	00000000 	nop
     b1c:	00003025 	move	a2,zero
     b20:	2405000a 	li	a1,10
     b24:	8fc40030 	lw	a0,48(s8)
     b28:	0c000105 	jal	0x414
     b2c:	00000000 	nop
     b30:	8fc30014 	lw	v1,20(s8)
     b34:	24020001 	li	v0,1
     b38:	1462000d 	bne	v1,v0,0xb70
     b3c:	00000000 	nop
     b40:	3c020000 	lui	v0,0x0
     b44:	24442a68 	addiu	a0,v0,10856
     b48:	0c0000ae 	jal	0x2b8
     b4c:	00000000 	nop
     b50:	3c020000 	lui	v0,0x0
     b54:	8c422b50 	lw	v0,11088(v0)
     b58:	00000000 	nop
     b5c:	24430001 	addiu	v1,v0,1
     b60:	3c020000 	lui	v0,0x0
     b64:	ac432b50 	sw	v1,11088(v0)
     b68:	10000005 	b	0xb80
     b6c:	00000000 	nop
     b70:	3c020000 	lui	v0,0x0
     b74:	24442a74 	addiu	a0,v0,10868
     b78:	0c0000ae 	jal	0x2b8
     b7c:	00000000 	nop
     b80:	00000000 	nop
     b84:	03c0e825 	move	sp,s8
     b88:	8fbf0024 	lw	ra,36(sp)
     b8c:	8fbe0020 	lw	s8,32(sp)
     b90:	27bd0028 	addiu	sp,sp,40
     b94:	03e00008 	jr	ra
     b98:	00000000 	nop
     b9c:	27bdffd8 	addiu	sp,sp,-40
     ba0:	afbf0024 	sw	ra,36(sp)
     ba4:	afbe0020 	sw	s8,32(sp)
     ba8:	03a0f025 	move	s8,sp
     bac:	afc40028 	sw	a0,40(s8)
     bb0:	afc5002c 	sw	a1,44(s8)
     bb4:	afc60030 	sw	a2,48(s8)
     bb8:	afc70034 	sw	a3,52(s8)
     bbc:	afc00014 	sw	zero,20(s8)
     bc0:	a7c00010 	sh	zero,16(s8)
     bc4:	1000002d 	b	0xc7c
     bc8:	00000000 	nop
     bcc:	87c30010 	lh	v1,16(s8)
     bd0:	8fc20028 	lw	v0,40(s8)
     bd4:	00000000 	nop
     bd8:	00620018 	mult	v1,v0
     bdc:	00001012 	mflo	v0
     be0:	afc20018 	sw	v0,24(s8)
     be4:	8fc40018 	lw	a0,24(s8)
     be8:	0c0000d4 	jal	0x350
     bec:	00000000 	nop
     bf0:	2404003a 	li	a0,58
     bf4:	0c000098 	jal	0x260
     bf8:	00000000 	nop
     bfc:	87c20010 	lh	v0,16(s8)
     c00:	00000000 	nop
     c04:	00021080 	sll	v0,v0,0x2
     c08:	8fc3002c 	lw	v1,44(s8)
     c0c:	00000000 	nop
     c10:	00621021 	addu	v0,v1,v0
     c14:	8c420000 	lw	v0,0(v0)
     c18:	00000000 	nop
     c1c:	00402025 	move	a0,v0
     c20:	0c0000d4 	jal	0x350
     c24:	00000000 	nop
     c28:	24040020 	li	a0,32
     c2c:	0c000098 	jal	0x260
     c30:	00000000 	nop
     c34:	87c20010 	lh	v0,16(s8)
     c38:	00000000 	nop
     c3c:	00021080 	sll	v0,v0,0x2
     c40:	8fc3002c 	lw	v1,44(s8)
     c44:	00000000 	nop
     c48:	00621021 	addu	v0,v1,v0
     c4c:	8c430000 	lw	v1,0(v0)
     c50:	8fc20018 	lw	v0,24(s8)
     c54:	00000000 	nop
     c58:	10620003 	beq	v1,v0,0xc68
     c5c:	00000000 	nop
     c60:	24020001 	li	v0,1
     c64:	afc20014 	sw	v0,20(s8)
     c68:	97c20010 	lhu	v0,16(s8)
     c6c:	00000000 	nop
     c70:	24420001 	addiu	v0,v0,1
     c74:	3042ffff 	andi	v0,v0,0xffff
     c78:	a7c20010 	sh	v0,16(s8)
     c7c:	87c20010 	lh	v0,16(s8)
     c80:	00000000 	nop
     c84:	28420006 	slti	v0,v0,6
     c88:	1440ffd0 	bnez	v0,0xbcc
     c8c:	00000000 	nop
     c90:	2404000a 	li	a0,10
     c94:	0c000098 	jal	0x260
     c98:	00000000 	nop
     c9c:	a7c00010 	sh	zero,16(s8)
     ca0:	1000002f 	b	0xd60
     ca4:	00000000 	nop
     ca8:	87c20010 	lh	v0,16(s8)
     cac:	00000000 	nop
     cb0:	24430123 	addiu	v1,v0,291
     cb4:	8fc20028 	lw	v0,40(s8)
     cb8:	00000000 	nop
     cbc:	00620018 	mult	v1,v0
     cc0:	00001012 	mflo	v0
     cc4:	afc20018 	sw	v0,24(s8)
     cc8:	8fc40018 	lw	a0,24(s8)
     ccc:	0c0000d4 	jal	0x350
     cd0:	00000000 	nop
     cd4:	2404003a 	li	a0,58
     cd8:	0c000098 	jal	0x260
     cdc:	00000000 	nop
     ce0:	87c20010 	lh	v0,16(s8)
     ce4:	00000000 	nop
     ce8:	00021080 	sll	v0,v0,0x2
     cec:	8fc30030 	lw	v1,48(s8)
     cf0:	00000000 	nop
     cf4:	00621021 	addu	v0,v1,v0
     cf8:	8c420000 	lw	v0,0(v0)
     cfc:	00000000 	nop
     d00:	00402025 	move	a0,v0
     d04:	0c0000d4 	jal	0x350
     d08:	00000000 	nop
     d0c:	24040020 	li	a0,32
     d10:	0c000098 	jal	0x260
     d14:	00000000 	nop
     d18:	87c20010 	lh	v0,16(s8)
     d1c:	00000000 	nop
     d20:	00021080 	sll	v0,v0,0x2
     d24:	8fc30030 	lw	v1,48(s8)
     d28:	00000000 	nop
     d2c:	00621021 	addu	v0,v1,v0
     d30:	8c430000 	lw	v1,0(v0)
     d34:	8fc20018 	lw	v0,24(s8)
     d38:	00000000 	nop
     d3c:	10620003 	beq	v1,v0,0xd4c
     d40:	00000000 	nop
     d44:	24020001 	li	v0,1
     d48:	afc20014 	sw	v0,20(s8)
     d4c:	97c20010 	lhu	v0,16(s8)
     d50:	00000000 	nop
     d54:	24420001 	addiu	v0,v0,1
     d58:	3042ffff 	andi	v0,v0,0xffff
     d5c:	a7c20010 	sh	v0,16(s8)
     d60:	87c20010 	lh	v0,16(s8)
     d64:	00000000 	nop
     d68:	28420006 	slti	v0,v0,6
     d6c:	1440ffce 	bnez	v0,0xca8
     d70:	00000000 	nop
     d74:	2404000a 	li	a0,10
     d78:	0c000098 	jal	0x260
     d7c:	00000000 	nop
     d80:	24020001 	li	v0,1
     d84:	a7c20010 	sh	v0,16(s8)
     d88:	10000034 	b	0xe5c
     d8c:	00000000 	nop
     d90:	87c20010 	lh	v0,16(s8)
     d94:	8fc30028 	lw	v1,40(s8)
     d98:	00000000 	nop
     d9c:	14400002 	bnez	v0,0xda8
     da0:	0062001a 	div	zero,v1,v0
     da4:	0007000d 	break	0x7
     da8:	00001010 	mfhi	v0
     dac:	00001012 	mflo	v0
     db0:	afc20018 	sw	v0,24(s8)
     db4:	8fc40018 	lw	a0,24(s8)
     db8:	0c0000d4 	jal	0x350
     dbc:	00000000 	nop
     dc0:	2404003a 	li	a0,58
     dc4:	0c000098 	jal	0x260
     dc8:	00000000 	nop
     dcc:	87c30010 	lh	v1,16(s8)
     dd0:	3c023fff 	lui	v0,0x3fff
     dd4:	3442ffff 	ori	v0,v0,0xffff
     dd8:	00621021 	addu	v0,v1,v0
     ddc:	00021080 	sll	v0,v0,0x2
     de0:	8fc30034 	lw	v1,52(s8)
     de4:	00000000 	nop
     de8:	00621021 	addu	v0,v1,v0
     dec:	8c420000 	lw	v0,0(v0)
     df0:	00000000 	nop
     df4:	00402025 	move	a0,v0
     df8:	0c0000d4 	jal	0x350
     dfc:	00000000 	nop
     e00:	24040020 	li	a0,32
     e04:	0c000098 	jal	0x260
     e08:	00000000 	nop
     e0c:	87c30010 	lh	v1,16(s8)
     e10:	3c023fff 	lui	v0,0x3fff
     e14:	3442ffff 	ori	v0,v0,0xffff
     e18:	00621021 	addu	v0,v1,v0
     e1c:	00021080 	sll	v0,v0,0x2
     e20:	8fc30034 	lw	v1,52(s8)
     e24:	00000000 	nop
     e28:	00621021 	addu	v0,v1,v0
     e2c:	8c430000 	lw	v1,0(v0)
     e30:	8fc20018 	lw	v0,24(s8)
     e34:	00000000 	nop
     e38:	10620003 	beq	v1,v0,0xe48
     e3c:	00000000 	nop
     e40:	24020001 	li	v0,1
     e44:	afc20014 	sw	v0,20(s8)
     e48:	97c20010 	lhu	v0,16(s8)
     e4c:	00000000 	nop
     e50:	24420001 	addiu	v0,v0,1
     e54:	3042ffff 	andi	v0,v0,0xffff
     e58:	a7c20010 	sh	v0,16(s8)
     e5c:	87c20010 	lh	v0,16(s8)
     e60:	00000000 	nop
     e64:	2842000a 	slti	v0,v0,10
     e68:	1440ffc9 	bnez	v0,0xd90
     e6c:	00000000 	nop
     e70:	2404000a 	li	a0,10
     e74:	0c000098 	jal	0x260
     e78:	00000000 	nop
     e7c:	24020001 	li	v0,1
     e80:	a7c20010 	sh	v0,16(s8)
     e84:	10000033 	b	0xf54
     e88:	00000000 	nop
     e8c:	87c20010 	lh	v0,16(s8)
     e90:	8fc30028 	lw	v1,40(s8)
     e94:	00000000 	nop
     e98:	14400002 	bnez	v0,0xea4
     e9c:	0062001a 	div	zero,v1,v0
     ea0:	0007000d 	break	0x7
     ea4:	00001010 	mfhi	v0
     ea8:	afc20018 	sw	v0,24(s8)
     eac:	8fc40018 	lw	a0,24(s8)
     eb0:	0c0000d4 	jal	0x350
     eb4:	00000000 	nop
     eb8:	2404003a 	li	a0,58
     ebc:	0c000098 	jal	0x260
     ec0:	00000000 	nop
     ec4:	87c30010 	lh	v1,16(s8)
     ec8:	3c023fff 	lui	v0,0x3fff
     ecc:	3442ffff 	ori	v0,v0,0xffff
     ed0:	00621021 	addu	v0,v1,v0
     ed4:	00021080 	sll	v0,v0,0x2
     ed8:	8fc30038 	lw	v1,56(s8)
     edc:	00000000 	nop
     ee0:	00621021 	addu	v0,v1,v0
     ee4:	8c420000 	lw	v0,0(v0)
     ee8:	00000000 	nop
     eec:	00402025 	move	a0,v0
     ef0:	0c0000d4 	jal	0x350
     ef4:	00000000 	nop
     ef8:	24040020 	li	a0,32
     efc:	0c000098 	jal	0x260
     f00:	00000000 	nop
     f04:	87c30010 	lh	v1,16(s8)
     f08:	3c023fff 	lui	v0,0x3fff
     f0c:	3442ffff 	ori	v0,v0,0xffff
     f10:	00621021 	addu	v0,v1,v0
     f14:	00021080 	sll	v0,v0,0x2
     f18:	8fc30038 	lw	v1,56(s8)
     f1c:	00000000 	nop
     f20:	00621021 	addu	v0,v1,v0
     f24:	8c430000 	lw	v1,0(v0)
     f28:	8fc20018 	lw	v0,24(s8)
     f2c:	00000000 	nop
     f30:	10620003 	beq	v1,v0,0xf40
     f34:	00000000 	nop
     f38:	24020001 	li	v0,1
     f3c:	afc20014 	sw	v0,20(s8)
     f40:	97c20010 	lhu	v0,16(s8)
     f44:	00000000 	nop
     f48:	24420001 	addiu	v0,v0,1
     f4c:	3042ffff 	andi	v0,v0,0xffff
     f50:	a7c20010 	sh	v0,16(s8)
     f54:	87c20010 	lh	v0,16(s8)
     f58:	00000000 	nop
     f5c:	2842000a 	slti	v0,v0,10
     f60:	1440ffca 	bnez	v0,0xe8c
     f64:	00000000 	nop
     f68:	3c020000 	lui	v0,0x0
     f6c:	24442a80 	addiu	a0,v0,10880
     f70:	0c0000ae 	jal	0x2b8
     f74:	00000000 	nop
     f78:	00003025 	move	a2,zero
     f7c:	2405000a 	li	a1,10
     f80:	8fc4003c 	lw	a0,60(s8)
     f84:	0c000105 	jal	0x414
     f88:	00000000 	nop
     f8c:	8fc30014 	lw	v1,20(s8)
     f90:	24020001 	li	v0,1
     f94:	1462000d 	bne	v1,v0,0xfcc
     f98:	00000000 	nop
     f9c:	3c020000 	lui	v0,0x0
     fa0:	24442a68 	addiu	a0,v0,10856
     fa4:	0c0000ae 	jal	0x2b8
     fa8:	00000000 	nop
     fac:	3c020000 	lui	v0,0x0
     fb0:	8c422b50 	lw	v0,11088(v0)
     fb4:	00000000 	nop
     fb8:	24430001 	addiu	v1,v0,1
     fbc:	3c020000 	lui	v0,0x0
     fc0:	ac432b50 	sw	v1,11088(v0)
     fc4:	10000005 	b	0xfdc
     fc8:	00000000 	nop
     fcc:	3c020000 	lui	v0,0x0
     fd0:	24442a74 	addiu	a0,v0,10868
     fd4:	0c0000ae 	jal	0x2b8
     fd8:	00000000 	nop
     fdc:	00000000 	nop
     fe0:	03c0e825 	move	sp,s8
     fe4:	8fbf0024 	lw	ra,36(sp)
     fe8:	8fbe0020 	lw	s8,32(sp)
     fec:	27bd0028 	addiu	sp,sp,40
     ff0:	03e00008 	jr	ra
     ff4:	00000000 	nop
     ff8:	27bdffd8 	addiu	sp,sp,-40
     ffc:	afbf0024 	sw	ra,36(sp)
    1000:	afbe0020 	sw	s8,32(sp)
    1004:	03a0f025 	move	s8,sp
    1008:	24021234 	li	v0,4660
    100c:	afc20018 	sw	v0,24(s8)
    1010:	afc00014 	sw	zero,20(s8)
    1014:	afc00010 	sw	zero,16(s8)
    1018:	1000002b 	b	0x10c8
    101c:	00000000 	nop
    1020:	8fc30018 	lw	v1,24(s8)
    1024:	8fc20010 	lw	v0,16(s8)
    1028:	00000000 	nop
    102c:	00621021 	addu	v0,v1,v0
    1030:	afc2001c 	sw	v0,28(s8)
    1034:	8fc4001c 	lw	a0,28(s8)
    1038:	0c0000d4 	jal	0x350
    103c:	00000000 	nop
    1040:	2404003a 	li	a0,58
    1044:	0c000098 	jal	0x260
    1048:	00000000 	nop
    104c:	3c020000 	lui	v0,0x0
    1050:	8fc30010 	lw	v1,16(s8)
    1054:	00000000 	nop
    1058:	00031880 	sll	v1,v1,0x2
    105c:	2442287c 	addiu	v0,v0,10364
    1060:	00621021 	addu	v0,v1,v0
    1064:	8c420000 	lw	v0,0(v0)
    1068:	00000000 	nop
    106c:	00402025 	move	a0,v0
    1070:	0c0000d4 	jal	0x350
    1074:	00000000 	nop
    1078:	24040020 	li	a0,32
    107c:	0c000098 	jal	0x260
    1080:	00000000 	nop
    1084:	3c020000 	lui	v0,0x0
    1088:	8fc30010 	lw	v1,16(s8)
    108c:	00000000 	nop
    1090:	00031880 	sll	v1,v1,0x2
    1094:	2442287c 	addiu	v0,v0,10364
    1098:	00621021 	addu	v0,v1,v0
    109c:	8c430000 	lw	v1,0(v0)
    10a0:	8fc2001c 	lw	v0,28(s8)
    10a4:	00000000 	nop
    10a8:	10620003 	beq	v1,v0,0x10b8
    10ac:	00000000 	nop
    10b0:	24020001 	li	v0,1
    10b4:	afc20014 	sw	v0,20(s8)
    10b8:	8fc20010 	lw	v0,16(s8)
    10bc:	00000000 	nop
    10c0:	24420001 	addiu	v0,v0,1
    10c4:	afc20010 	sw	v0,16(s8)
    10c8:	8fc20010 	lw	v0,16(s8)
    10cc:	00000000 	nop
    10d0:	2842000a 	slti	v0,v0,10
    10d4:	1440ffd2 	bnez	v0,0x1020
    10d8:	00000000 	nop
    10dc:	2404000a 	li	a0,10
    10e0:	0c000098 	jal	0x260
    10e4:	00000000 	nop
    10e8:	afc00010 	sw	zero,16(s8)
    10ec:	1000002b 	b	0x119c
    10f0:	00000000 	nop
    10f4:	8fc30018 	lw	v1,24(s8)
    10f8:	8fc20010 	lw	v0,16(s8)
    10fc:	00000000 	nop
    1100:	00621023 	subu	v0,v1,v0
    1104:	afc2001c 	sw	v0,28(s8)
    1108:	8fc4001c 	lw	a0,28(s8)
    110c:	0c0000d4 	jal	0x350
    1110:	00000000 	nop
    1114:	2404003a 	li	a0,58
    1118:	0c000098 	jal	0x260
    111c:	00000000 	nop
    1120:	3c020000 	lui	v0,0x0
    1124:	8fc30010 	lw	v1,16(s8)
    1128:	00000000 	nop
    112c:	00031880 	sll	v1,v1,0x2
    1130:	244228a4 	addiu	v0,v0,10404
    1134:	00621021 	addu	v0,v1,v0
    1138:	8c420000 	lw	v0,0(v0)
    113c:	00000000 	nop
    1140:	00402025 	move	a0,v0
    1144:	0c0000d4 	jal	0x350
    1148:	00000000 	nop
    114c:	24040020 	li	a0,32
    1150:	0c000098 	jal	0x260
    1154:	00000000 	nop
    1158:	3c020000 	lui	v0,0x0
    115c:	8fc30010 	lw	v1,16(s8)
    1160:	00000000 	nop
    1164:	00031880 	sll	v1,v1,0x2
    1168:	244228a4 	addiu	v0,v0,10404
    116c:	00621021 	addu	v0,v1,v0
    1170:	8c430000 	lw	v1,0(v0)
    1174:	8fc2001c 	lw	v0,28(s8)
    1178:	00000000 	nop
    117c:	10620003 	beq	v1,v0,0x118c
    1180:	00000000 	nop
    1184:	24020001 	li	v0,1
    1188:	afc20014 	sw	v0,20(s8)
    118c:	8fc20010 	lw	v0,16(s8)
    1190:	00000000 	nop
    1194:	24420001 	addiu	v0,v0,1
    1198:	afc20010 	sw	v0,16(s8)
    119c:	8fc20010 	lw	v0,16(s8)
    11a0:	00000000 	nop
    11a4:	2842000a 	slti	v0,v0,10
    11a8:	1440ffd2 	bnez	v0,0x10f4
    11ac:	00000000 	nop
    11b0:	3c020000 	lui	v0,0x0
    11b4:	24442aa4 	addiu	a0,v0,10916
    11b8:	0c0000ae 	jal	0x2b8
    11bc:	00000000 	nop
    11c0:	8fc30014 	lw	v1,20(s8)
    11c4:	24020001 	li	v0,1
    11c8:	1462000d 	bne	v1,v0,0x1200
    11cc:	00000000 	nop
    11d0:	3c020000 	lui	v0,0x0
    11d4:	24442a68 	addiu	a0,v0,10856
    11d8:	0c0000ae 	jal	0x2b8
    11dc:	00000000 	nop
    11e0:	3c020000 	lui	v0,0x0
    11e4:	8c422b50 	lw	v0,11088(v0)
    11e8:	00000000 	nop
    11ec:	24430001 	addiu	v1,v0,1
    11f0:	3c020000 	lui	v0,0x0
    11f4:	ac432b50 	sw	v1,11088(v0)
    11f8:	10000005 	b	0x1210
    11fc:	00000000 	nop
    1200:	3c020000 	lui	v0,0x0
    1204:	24442a74 	addiu	a0,v0,10868
    1208:	0c0000ae 	jal	0x2b8
    120c:	00000000 	nop
    1210:	00000000 	nop
    1214:	03c0e825 	move	sp,s8
    1218:	8fbf0024 	lw	ra,36(sp)
    121c:	8fbe0020 	lw	s8,32(sp)
    1220:	27bd0028 	addiu	sp,sp,40
    1224:	03e00008 	jr	ra
    1228:	00000000 	nop
    122c:	27bdff68 	addiu	sp,sp,-152
    1230:	afbf0094 	sw	ra,148(sp)
    1234:	afbe0090 	sw	s8,144(sp)
    1238:	03a0f025 	move	s8,sp
    123c:	afc00014 	sw	zero,20(s8)
    1240:	afc00010 	sw	zero,16(s8)
    1244:	1000001f 	b	0x12c4
    1248:	00000000 	nop
    124c:	8fc20010 	lw	v0,16(s8)
    1250:	00000000 	nop
    1254:	00021e00 	sll	v1,v0,0x18
    1258:	00031e03 	sra	v1,v1,0x18
    125c:	8fc20010 	lw	v0,16(s8)
    1260:	27c40010 	addiu	a0,s8,16
    1264:	00821021 	addu	v0,a0,v0
    1268:	a043000c 	sb	v1,12(v0)
    126c:	8fc20010 	lw	v0,16(s8)
    1270:	00000000 	nop
    1274:	00021c00 	sll	v1,v0,0x10
    1278:	00031c03 	sra	v1,v1,0x10
    127c:	8fc20010 	lw	v0,16(s8)
    1280:	00000000 	nop
    1284:	00021040 	sll	v0,v0,0x1
    1288:	27c40010 	addiu	a0,s8,16
    128c:	00821021 	addu	v0,a0,v0
    1290:	a443001c 	sh	v1,28(v0)
    1294:	8fc20010 	lw	v0,16(s8)
    1298:	00000000 	nop
    129c:	00021080 	sll	v0,v0,0x2
    12a0:	27c30010 	addiu	v1,s8,16
    12a4:	00621021 	addu	v0,v1,v0
    12a8:	8fc30010 	lw	v1,16(s8)
    12ac:	00000000 	nop
    12b0:	ac43003c 	sw	v1,60(v0)
    12b4:	8fc20010 	lw	v0,16(s8)
    12b8:	00000000 	nop
    12bc:	24420001 	addiu	v0,v0,1
    12c0:	afc20010 	sw	v0,16(s8)
    12c4:	8fc20010 	lw	v0,16(s8)
    12c8:	00000000 	nop
    12cc:	2842000a 	slti	v0,v0,10
    12d0:	1440ffde 	bnez	v0,0x124c
    12d4:	00000000 	nop
    12d8:	afc00010 	sw	zero,16(s8)
    12dc:	10000087 	b	0x14fc
    12e0:	00000000 	nop
    12e4:	8fc20010 	lw	v0,16(s8)
    12e8:	27c30010 	addiu	v1,s8,16
    12ec:	00621021 	addu	v0,v1,v0
    12f0:	8042000c 	lb	v0,12(v0)
    12f4:	00000000 	nop
    12f8:	afc20018 	sw	v0,24(s8)
    12fc:	00003025 	move	a2,zero
    1300:	2405000a 	li	a1,10
    1304:	8fc40018 	lw	a0,24(s8)
    1308:	0c000105 	jal	0x414
    130c:	00000000 	nop
    1310:	2404003a 	li	a0,58
    1314:	0c000098 	jal	0x260
    1318:	00000000 	nop
    131c:	3c020000 	lui	v0,0x0
    1320:	8fc30010 	lw	v1,16(s8)
    1324:	00000000 	nop
    1328:	00031880 	sll	v1,v1,0x2
    132c:	24422ae8 	addiu	v0,v0,10984
    1330:	00621021 	addu	v0,v1,v0
    1334:	8c420000 	lw	v0,0(v0)
    1338:	00003025 	move	a2,zero
    133c:	2405000a 	li	a1,10
    1340:	00402025 	move	a0,v0
    1344:	0c000105 	jal	0x414
    1348:	00000000 	nop
    134c:	24040020 	li	a0,32
    1350:	0c000098 	jal	0x260
    1354:	00000000 	nop
    1358:	3c020000 	lui	v0,0x0
    135c:	8fc30010 	lw	v1,16(s8)
    1360:	00000000 	nop
    1364:	00031880 	sll	v1,v1,0x2
    1368:	24422ae8 	addiu	v0,v0,10984
    136c:	00621021 	addu	v0,v1,v0
    1370:	8c430000 	lw	v1,0(v0)
    1374:	8fc20018 	lw	v0,24(s8)
    1378:	00000000 	nop
    137c:	10620003 	beq	v1,v0,0x138c
    1380:	00000000 	nop
    1384:	24020001 	li	v0,1
    1388:	afc20014 	sw	v0,20(s8)
    138c:	8fc20010 	lw	v0,16(s8)
    1390:	00000000 	nop
    1394:	00021040 	sll	v0,v0,0x1
    1398:	27c30010 	addiu	v1,s8,16
    139c:	00621021 	addu	v0,v1,v0
    13a0:	8442001c 	lh	v0,28(v0)
    13a4:	00000000 	nop
    13a8:	afc20018 	sw	v0,24(s8)
    13ac:	00003025 	move	a2,zero
    13b0:	2405000a 	li	a1,10
    13b4:	8fc40018 	lw	a0,24(s8)
    13b8:	0c000105 	jal	0x414
    13bc:	00000000 	nop
    13c0:	2404003a 	li	a0,58
    13c4:	0c000098 	jal	0x260
    13c8:	00000000 	nop
    13cc:	3c020000 	lui	v0,0x0
    13d0:	8fc30010 	lw	v1,16(s8)
    13d4:	00000000 	nop
    13d8:	00031880 	sll	v1,v1,0x2
    13dc:	24422ae8 	addiu	v0,v0,10984
    13e0:	00621021 	addu	v0,v1,v0
    13e4:	8c420000 	lw	v0,0(v0)
    13e8:	00003025 	move	a2,zero
    13ec:	2405000a 	li	a1,10
    13f0:	00402025 	move	a0,v0
    13f4:	0c000105 	jal	0x414
    13f8:	00000000 	nop
    13fc:	24040020 	li	a0,32
    1400:	0c000098 	jal	0x260
    1404:	00000000 	nop
    1408:	3c020000 	lui	v0,0x0
    140c:	8fc30010 	lw	v1,16(s8)
    1410:	00000000 	nop
    1414:	00031880 	sll	v1,v1,0x2
    1418:	24422ae8 	addiu	v0,v0,10984
    141c:	00621021 	addu	v0,v1,v0
    1420:	8c430000 	lw	v1,0(v0)
    1424:	8fc20018 	lw	v0,24(s8)
    1428:	00000000 	nop
    142c:	10620003 	beq	v1,v0,0x143c
    1430:	00000000 	nop
    1434:	24020001 	li	v0,1
    1438:	afc20014 	sw	v0,20(s8)
    143c:	8fc20010 	lw	v0,16(s8)
    1440:	00000000 	nop
    1444:	00021080 	sll	v0,v0,0x2
    1448:	27c30010 	addiu	v1,s8,16
    144c:	00621021 	addu	v0,v1,v0
    1450:	8c42003c 	lw	v0,60(v0)
    1454:	00000000 	nop
    1458:	afc20018 	sw	v0,24(s8)
    145c:	00003025 	move	a2,zero
    1460:	2405000a 	li	a1,10
    1464:	8fc40018 	lw	a0,24(s8)
    1468:	0c000105 	jal	0x414
    146c:	00000000 	nop
    1470:	2404003a 	li	a0,58
    1474:	0c000098 	jal	0x260
    1478:	00000000 	nop
    147c:	3c020000 	lui	v0,0x0
    1480:	8fc30010 	lw	v1,16(s8)
    1484:	00000000 	nop
    1488:	00031880 	sll	v1,v1,0x2
    148c:	24422ae8 	addiu	v0,v0,10984
    1490:	00621021 	addu	v0,v1,v0
    1494:	8c420000 	lw	v0,0(v0)
    1498:	00003025 	move	a2,zero
    149c:	2405000a 	li	a1,10
    14a0:	00402025 	move	a0,v0
    14a4:	0c000105 	jal	0x414
    14a8:	00000000 	nop
    14ac:	2404000a 	li	a0,10
    14b0:	0c000098 	jal	0x260
    14b4:	00000000 	nop
    14b8:	3c020000 	lui	v0,0x0
    14bc:	8fc30010 	lw	v1,16(s8)
    14c0:	00000000 	nop
    14c4:	00031880 	sll	v1,v1,0x2
    14c8:	24422ae8 	addiu	v0,v0,10984
    14cc:	00621021 	addu	v0,v1,v0
    14d0:	8c430000 	lw	v1,0(v0)
    14d4:	8fc20018 	lw	v0,24(s8)
    14d8:	00000000 	nop
    14dc:	10620003 	beq	v1,v0,0x14ec
    14e0:	00000000 	nop
    14e4:	24020001 	li	v0,1
    14e8:	afc20014 	sw	v0,20(s8)
    14ec:	8fc20010 	lw	v0,16(s8)
    14f0:	00000000 	nop
    14f4:	24420001 	addiu	v0,v0,1
    14f8:	afc20010 	sw	v0,16(s8)
    14fc:	8fc20010 	lw	v0,16(s8)
    1500:	00000000 	nop
    1504:	2842000a 	slti	v0,v0,10
    1508:	1440ff76 	bnez	v0,0x12e4
    150c:	00000000 	nop
    1510:	3c020000 	lui	v0,0x0
    1514:	24442ac0 	addiu	a0,v0,10944
    1518:	0c0000ae 	jal	0x2b8
    151c:	00000000 	nop
    1520:	8fc30014 	lw	v1,20(s8)
    1524:	24020001 	li	v0,1
    1528:	1462000d 	bne	v1,v0,0x1560
    152c:	00000000 	nop
    1530:	3c020000 	lui	v0,0x0
    1534:	24442a68 	addiu	a0,v0,10856
    1538:	0c0000ae 	jal	0x2b8
    153c:	00000000 	nop
    1540:	3c020000 	lui	v0,0x0
    1544:	8c422b50 	lw	v0,11088(v0)
    1548:	00000000 	nop
    154c:	24430001 	addiu	v1,v0,1
    1550:	3c020000 	lui	v0,0x0
    1554:	ac432b50 	sw	v1,11088(v0)
    1558:	10000005 	b	0x1570
    155c:	00000000 	nop
    1560:	3c020000 	lui	v0,0x0
    1564:	24442a74 	addiu	a0,v0,10868
    1568:	0c0000ae 	jal	0x2b8
    156c:	00000000 	nop
    1570:	00000000 	nop
    1574:	03c0e825 	move	sp,s8
    1578:	8fbf0094 	lw	ra,148(sp)
    157c:	8fbe0090 	lw	s8,144(sp)
    1580:	27bd0098 	addiu	sp,sp,152
    1584:	03e00008 	jr	ra
    1588:	00000000 	nop
    158c:	27bdffd8 	addiu	sp,sp,-40
    1590:	afbf0024 	sw	ra,36(sp)
    1594:	afbe0020 	sw	s8,32(sp)
    1598:	03a0f025 	move	s8,sp
    159c:	24021234 	li	v0,4660
    15a0:	afc20014 	sw	v0,20(s8)
    15a4:	24024321 	li	v0,17185
    15a8:	afc20018 	sw	v0,24(s8)
    15ac:	afc00010 	sw	zero,16(s8)
    15b0:	8fc30014 	lw	v1,20(s8)
    15b4:	8fc20018 	lw	v0,24(s8)
    15b8:	00000000 	nop
    15bc:	00621024 	and	v0,v1,v0
    15c0:	afc2001c 	sw	v0,28(s8)
    15c4:	8fc4001c 	lw	a0,28(s8)
    15c8:	0c0000d4 	jal	0x350
    15cc:	00000000 	nop
    15d0:	2404003a 	li	a0,58
    15d4:	0c000098 	jal	0x260
    15d8:	00000000 	nop
    15dc:	3c020000 	lui	v0,0x0
    15e0:	8c422b10 	lw	v0,11024(v0)
    15e4:	00000000 	nop
    15e8:	00402025 	move	a0,v0
    15ec:	0c0000d4 	jal	0x350
    15f0:	00000000 	nop
    15f4:	24040020 	li	a0,32
    15f8:	0c000098 	jal	0x260
    15fc:	00000000 	nop
    1600:	3c020000 	lui	v0,0x0
    1604:	8c432b10 	lw	v1,11024(v0)
    1608:	8fc2001c 	lw	v0,28(s8)
    160c:	00000000 	nop
    1610:	10620003 	beq	v1,v0,0x1620
    1614:	00000000 	nop
    1618:	24020001 	li	v0,1
    161c:	afc20010 	sw	v0,16(s8)
    1620:	8fc30014 	lw	v1,20(s8)
    1624:	8fc20018 	lw	v0,24(s8)
    1628:	00000000 	nop
    162c:	00621025 	or	v0,v1,v0
    1630:	afc2001c 	sw	v0,28(s8)
    1634:	8fc4001c 	lw	a0,28(s8)
    1638:	0c0000d4 	jal	0x350
    163c:	00000000 	nop
    1640:	2404003a 	li	a0,58
    1644:	0c000098 	jal	0x260
    1648:	00000000 	nop
    164c:	3c020000 	lui	v0,0x0
    1650:	24422b10 	addiu	v0,v0,11024
    1654:	8c420004 	lw	v0,4(v0)
    1658:	00000000 	nop
    165c:	00402025 	move	a0,v0
    1660:	0c0000d4 	jal	0x350
    1664:	00000000 	nop
    1668:	24040020 	li	a0,32
    166c:	0c000098 	jal	0x260
    1670:	00000000 	nop
    1674:	3c020000 	lui	v0,0x0
    1678:	24422b10 	addiu	v0,v0,11024
    167c:	8c430004 	lw	v1,4(v0)
    1680:	8fc2001c 	lw	v0,28(s8)
    1684:	00000000 	nop
    1688:	10620003 	beq	v1,v0,0x1698
    168c:	00000000 	nop
    1690:	24020001 	li	v0,1
    1694:	afc20010 	sw	v0,16(s8)
    1698:	8fc30014 	lw	v1,20(s8)
    169c:	8fc20018 	lw	v0,24(s8)
    16a0:	00000000 	nop
    16a4:	00621026 	xor	v0,v1,v0
    16a8:	afc2001c 	sw	v0,28(s8)
    16ac:	8fc4001c 	lw	a0,28(s8)
    16b0:	0c0000d4 	jal	0x350
    16b4:	00000000 	nop
    16b8:	2404003a 	li	a0,58
    16bc:	0c000098 	jal	0x260
    16c0:	00000000 	nop
    16c4:	3c020000 	lui	v0,0x0
    16c8:	24422b10 	addiu	v0,v0,11024
    16cc:	8c420008 	lw	v0,8(v0)
    16d0:	00000000 	nop
    16d4:	00402025 	move	a0,v0
    16d8:	0c0000d4 	jal	0x350
    16dc:	00000000 	nop
    16e0:	24040020 	li	a0,32
    16e4:	0c000098 	jal	0x260
    16e8:	00000000 	nop
    16ec:	3c020000 	lui	v0,0x0
    16f0:	24422b10 	addiu	v0,v0,11024
    16f4:	8c430008 	lw	v1,8(v0)
    16f8:	8fc2001c 	lw	v0,28(s8)
    16fc:	00000000 	nop
    1700:	10620003 	beq	v1,v0,0x1710
    1704:	00000000 	nop
    1708:	24020001 	li	v0,1
    170c:	afc20010 	sw	v0,16(s8)
    1710:	8fc20014 	lw	v0,20(s8)
    1714:	00000000 	nop
    1718:	00021027 	nor	v0,zero,v0
    171c:	afc2001c 	sw	v0,28(s8)
    1720:	8fc4001c 	lw	a0,28(s8)
    1724:	0c0000d4 	jal	0x350
    1728:	00000000 	nop
    172c:	2404003a 	li	a0,58
    1730:	0c000098 	jal	0x260
    1734:	00000000 	nop
    1738:	3c020000 	lui	v0,0x0
    173c:	24422b10 	addiu	v0,v0,11024
    1740:	8c42000c 	lw	v0,12(v0)
    1744:	00000000 	nop
    1748:	00402025 	move	a0,v0
    174c:	0c0000d4 	jal	0x350
    1750:	00000000 	nop
    1754:	24040020 	li	a0,32
    1758:	0c000098 	jal	0x260
    175c:	00000000 	nop
    1760:	3c020000 	lui	v0,0x0
    1764:	24422b10 	addiu	v0,v0,11024
    1768:	8c43000c 	lw	v1,12(v0)
    176c:	8fc2001c 	lw	v0,28(s8)
    1770:	00000000 	nop
    1774:	10620003 	beq	v1,v0,0x1784
    1778:	00000000 	nop
    177c:	24020001 	li	v0,1
    1780:	afc20010 	sw	v0,16(s8)
    1784:	8fc20014 	lw	v0,20(s8)
    1788:	00000000 	nop
    178c:	24420012 	addiu	v0,v0,18
    1790:	afc2001c 	sw	v0,28(s8)
    1794:	8fc4001c 	lw	a0,28(s8)
    1798:	0c0000d4 	jal	0x350
    179c:	00000000 	nop
    17a0:	2404003a 	li	a0,58
    17a4:	0c000098 	jal	0x260
    17a8:	00000000 	nop
    17ac:	3c020000 	lui	v0,0x0
    17b0:	24422b10 	addiu	v0,v0,11024
    17b4:	8c420010 	lw	v0,16(v0)
    17b8:	00000000 	nop
    17bc:	00402025 	move	a0,v0
    17c0:	0c0000d4 	jal	0x350
    17c4:	00000000 	nop
    17c8:	24040020 	li	a0,32
    17cc:	0c000098 	jal	0x260
    17d0:	00000000 	nop
    17d4:	3c020000 	lui	v0,0x0
    17d8:	24422b10 	addiu	v0,v0,11024
    17dc:	8c430010 	lw	v1,16(v0)
    17e0:	8fc2001c 	lw	v0,28(s8)
    17e4:	00000000 	nop
    17e8:	10620003 	beq	v1,v0,0x17f8
    17ec:	00000000 	nop
    17f0:	24020001 	li	v0,1
    17f4:	afc20010 	sw	v0,16(s8)
    17f8:	8fc20014 	lw	v0,20(s8)
    17fc:	00000000 	nop
    1800:	2442ffee 	addiu	v0,v0,-18
    1804:	afc2001c 	sw	v0,28(s8)
    1808:	8fc4001c 	lw	a0,28(s8)
    180c:	0c0000d4 	jal	0x350
    1810:	00000000 	nop
    1814:	2404003a 	li	a0,58
    1818:	0c000098 	jal	0x260
    181c:	00000000 	nop
    1820:	3c020000 	lui	v0,0x0
    1824:	24422b10 	addiu	v0,v0,11024
    1828:	8c420014 	lw	v0,20(v0)
    182c:	00000000 	nop
    1830:	00402025 	move	a0,v0
    1834:	0c0000d4 	jal	0x350
    1838:	00000000 	nop
    183c:	3c020000 	lui	v0,0x0
    1840:	24422b10 	addiu	v0,v0,11024
    1844:	8c430014 	lw	v1,20(v0)
    1848:	8fc2001c 	lw	v0,28(s8)
    184c:	00000000 	nop
    1850:	10620003 	beq	v1,v0,0x1860
    1854:	00000000 	nop
    1858:	24020001 	li	v0,1
    185c:	afc20010 	sw	v0,16(s8)
    1860:	3c020000 	lui	v0,0x0
    1864:	24442ad0 	addiu	a0,v0,10960
    1868:	0c0000ae 	jal	0x2b8
    186c:	00000000 	nop
    1870:	8fc30010 	lw	v1,16(s8)
    1874:	24020001 	li	v0,1
    1878:	1462000d 	bne	v1,v0,0x18b0
    187c:	00000000 	nop
    1880:	3c020000 	lui	v0,0x0
    1884:	24442a68 	addiu	a0,v0,10856
    1888:	0c0000ae 	jal	0x2b8
    188c:	00000000 	nop
    1890:	3c020000 	lui	v0,0x0
    1894:	8c422b50 	lw	v0,11088(v0)
    1898:	00000000 	nop
    189c:	24430001 	addiu	v1,v0,1
    18a0:	3c020000 	lui	v0,0x0
    18a4:	ac432b50 	sw	v1,11088(v0)
    18a8:	10000005 	b	0x18c0
    18ac:	00000000 	nop
    18b0:	3c020000 	lui	v0,0x0
    18b4:	24442a74 	addiu	a0,v0,10868
    18b8:	0c0000ae 	jal	0x2b8
    18bc:	00000000 	nop
    18c0:	00000000 	nop
    18c4:	03c0e825 	move	sp,s8
    18c8:	8fbf0024 	lw	ra,36(sp)
    18cc:	8fbe0020 	lw	s8,32(sp)
    18d0:	27bd0028 	addiu	sp,sp,40
    18d4:	03e00008 	jr	ra
    18d8:	00000000 	nop
    18dc:	00000000 	nop
    18e0:	27bdfff8 	addiu	sp,sp,-8
    18e4:	afbe0004 	sw	s8,4(sp)
    18e8:	03a0f025 	move	s8,sp
    18ec:	afc40008 	sw	a0,8(s8)
    18f0:	3c020000 	lui	v0,0x0
    18f4:	8c422b64 	lw	v0,11108(v0)
    18f8:	00000000 	nop
    18fc:	2842000f 	slti	v0,v0,15
    1900:	10400013 	beqz	v0,0x1950
    1904:	00000000 	nop
    1908:	3c020000 	lui	v0,0x0
    190c:	8c432b64 	lw	v1,11108(v0)
    1910:	3c020000 	lui	v0,0x0
    1914:	00031880 	sll	v1,v1,0x2
    1918:	24422d70 	addiu	v0,v0,11632
    191c:	00621021 	addu	v0,v1,v0
    1920:	8fc30008 	lw	v1,8(s8)
    1924:	00000000 	nop
    1928:	ac430000 	sw	v1,0(v0)
    192c:	3c020000 	lui	v0,0x0
    1930:	8c422b64 	lw	v0,11108(v0)
    1934:	00000000 	nop
    1938:	24430001 	addiu	v1,v0,1
    193c:	3c020000 	lui	v0,0x0
    1940:	ac432b64 	sw	v1,11108(v0)
    1944:	00001025 	move	v0,zero
    1948:	10000002 	b	0x1954
    194c:	00000000 	nop
    1950:	2402ffff 	li	v0,-1
    1954:	03c0e825 	move	sp,s8
    1958:	8fbe0004 	lw	s8,4(sp)
    195c:	27bd0008 	addiu	sp,sp,8
    1960:	03e00008 	jr	ra
    1964:	00000000 	nop
    1968:	27bdfff0 	addiu	sp,sp,-16
    196c:	afbe000c 	sw	s8,12(sp)
    1970:	03a0f025 	move	s8,sp
    1974:	afc40010 	sw	a0,16(s8)
    1978:	24020001 	li	v0,1
    197c:	a3c20000 	sb	v0,0(s8)
    1980:	8fc20010 	lw	v0,16(s8)
    1984:	00000000 	nop
    1988:	94420000 	lhu	v0,0(v0)
    198c:	00000000 	nop
    1990:	10400006 	beqz	v0,0x19ac
    1994:	00000000 	nop
    1998:	24030032 	li	v1,50
    199c:	10430007 	beq	v0,v1,0x19bc
    19a0:	00000000 	nop
    19a4:	1000002a 	b	0x1a50
    19a8:	00000000 	nop
    19ac:	a3c00000 	sb	zero,0(s8)
    19b0:	8fc20010 	lw	v0,16(s8)
    19b4:	24030032 	li	v1,50
    19b8:	a4430000 	sh	v1,0(v0)
    19bc:	83c20000 	lb	v0,0(s8)
    19c0:	00000000 	nop
    19c4:	10400006 	beqz	v0,0x19e0
    19c8:	00000000 	nop
    19cc:	3c020000 	lui	v0,0x0
    19d0:	8c432b30 	lw	v1,11056(v0)
    19d4:	24020001 	li	v0,1
    19d8:	10620004 	beq	v1,v0,0x19ec
    19dc:	00000000 	nop
    19e0:	24020001 	li	v0,1
    19e4:	1000001f 	b	0x1a64
    19e8:	00000000 	nop
    19ec:	34028000 	li	v0,0x8000
    19f0:	8c430000 	lw	v1,0(v0)
    19f4:	3c024000 	lui	v0,0x4000
    19f8:	00621024 	and	v0,v1,v0
    19fc:	1440000b 	bnez	v0,0x1a2c
    1a00:	00000000 	nop
    1a04:	3c020000 	lui	v0,0x0
    1a08:	8c422b64 	lw	v0,11108(v0)
    1a0c:	00000000 	nop
    1a10:	18400006 	blez	v0,0x1a2c
    1a14:	00000000 	nop
    1a18:	24027ffc 	li	v0,32764
    1a1c:	3c030000 	lui	v1,0x0
    1a20:	8c632d70 	lw	v1,11632(v1)
    1a24:	00000000 	nop
    1a28:	ac430000 	sw	v1,0(v0)
    1a2c:	3c020000 	lui	v0,0x0
    1a30:	ac402b30 	sw	zero,11056(v0)
    1a34:	3c020000 	lui	v0,0x0
    1a38:	24030001 	li	v1,1
    1a3c:	ac432b68 	sw	v1,11112(v0)
    1a40:	3c020000 	lui	v0,0x0
    1a44:	ac402b6c 	sw	zero,11116(v0)
    1a48:	1000ffd8 	b	0x19ac
    1a4c:	00000000 	nop
    1a50:	a3c00000 	sb	zero,0(s8)
    1a54:	8fc20010 	lw	v0,16(s8)
    1a58:	00000000 	nop
    1a5c:	a4400000 	sh	zero,0(v0)
    1a60:	24020003 	li	v0,3
    1a64:	03c0e825 	move	sp,s8
    1a68:	8fbe000c 	lw	s8,12(sp)
    1a6c:	27bd0010 	addiu	sp,sp,16
    1a70:	03e00008 	jr	ra
    1a74:	00000000 	nop
    1a78:	27bdffe8 	addiu	sp,sp,-24
    1a7c:	afbe0014 	sw	s8,20(sp)
    1a80:	03a0f025 	move	s8,sp
    1a84:	afc40018 	sw	a0,24(s8)
    1a88:	afc00004 	sw	zero,4(s8)
    1a8c:	24020001 	li	v0,1
    1a90:	a3c20000 	sb	v0,0(s8)
    1a94:	8fc20018 	lw	v0,24(s8)
    1a98:	00000000 	nop
    1a9c:	94420000 	lhu	v0,0(v0)
    1aa0:	00000000 	nop
    1aa4:	10400006 	beqz	v0,0x1ac0
    1aa8:	00000000 	nop
    1aac:	2403005d 	li	v1,93
    1ab0:	10430007 	beq	v0,v1,0x1ad0
    1ab4:	00000000 	nop
    1ab8:	1000003f 	b	0x1bb8
    1abc:	00000000 	nop
    1ac0:	a3c00000 	sb	zero,0(s8)
    1ac4:	8fc20018 	lw	v0,24(s8)
    1ac8:	2403005d 	li	v1,93
    1acc:	a4430000 	sh	v1,0(v0)
    1ad0:	83c20000 	lb	v0,0(s8)
    1ad4:	00000000 	nop
    1ad8:	10400006 	beqz	v0,0x1af4
    1adc:	00000000 	nop
    1ae0:	3c020000 	lui	v0,0x0
    1ae4:	8c432b68 	lw	v1,11112(v0)
    1ae8:	24020001 	li	v0,1
    1aec:	10620004 	beq	v1,v0,0x1b00
    1af0:	00000000 	nop
    1af4:	24020001 	li	v0,1
    1af8:	10000034 	b	0x1bcc
    1afc:	00000000 	nop
    1b00:	34028004 	li	v0,0x8004
    1b04:	8c420000 	lw	v0,0(v0)
    1b08:	00000000 	nop
    1b0c:	afc20004 	sw	v0,4(s8)
    1b10:	34028000 	li	v0,0x8000
    1b14:	8c420000 	lw	v0,0(v0)
    1b18:	00000000 	nop
    1b1c:	afc20008 	sw	v0,8(s8)
    1b20:	8fc20004 	lw	v0,4(s8)
    1b24:	00000000 	nop
    1b28:	1040001a 	beqz	v0,0x1b94
    1b2c:	00000000 	nop
    1b30:	8fc20008 	lw	v0,8(s8)
    1b34:	00000000 	nop
    1b38:	04400016 	bltz	v0,0x1b94
    1b3c:	00000000 	nop
    1b40:	3c020000 	lui	v0,0x0
    1b44:	8c422b60 	lw	v0,11104(v0)
    1b48:	00000000 	nop
    1b4c:	2842000f 	slti	v0,v0,15
    1b50:	10400010 	beqz	v0,0x1b94
    1b54:	00000000 	nop
    1b58:	3c020000 	lui	v0,0x0
    1b5c:	8c442b60 	lw	a0,11104(v0)
    1b60:	24027ffc 	li	v0,32764
    1b64:	8c430000 	lw	v1,0(v0)
    1b68:	3c020000 	lui	v0,0x0
    1b6c:	00042080 	sll	a0,a0,0x2
    1b70:	24422db0 	addiu	v0,v0,11696
    1b74:	00821021 	addu	v0,a0,v0
    1b78:	ac430000 	sw	v1,0(v0)
    1b7c:	3c020000 	lui	v0,0x0
    1b80:	8c422b60 	lw	v0,11104(v0)
    1b84:	00000000 	nop
    1b88:	24430001 	addiu	v1,v0,1
    1b8c:	3c020000 	lui	v0,0x0
    1b90:	ac432b60 	sw	v1,11104(v0)
    1b94:	3c020000 	lui	v0,0x0
    1b98:	ac402b30 	sw	zero,11056(v0)
    1b9c:	3c020000 	lui	v0,0x0
    1ba0:	ac402b68 	sw	zero,11112(v0)
    1ba4:	3c020000 	lui	v0,0x0
    1ba8:	24030001 	li	v1,1
    1bac:	ac432b6c 	sw	v1,11116(v0)
    1bb0:	1000ffc3 	b	0x1ac0
    1bb4:	00000000 	nop
    1bb8:	a3c00000 	sb	zero,0(s8)
    1bbc:	8fc20018 	lw	v0,24(s8)
    1bc0:	00000000 	nop
    1bc4:	a4400000 	sh	zero,0(v0)
    1bc8:	24020003 	li	v0,3
    1bcc:	03c0e825 	move	sp,s8
    1bd0:	8fbe0014 	lw	s8,20(sp)
    1bd4:	27bd0018 	addiu	sp,sp,24
    1bd8:	03e00008 	jr	ra
    1bdc:	00000000 	nop
    1be0:	27bdfff0 	addiu	sp,sp,-16
    1be4:	afbe000c 	sw	s8,12(sp)
    1be8:	03a0f025 	move	s8,sp
    1bec:	afc40010 	sw	a0,16(s8)
    1bf0:	afc50014 	sw	a1,20(s8)
    1bf4:	8fc20010 	lw	v0,16(s8)
    1bf8:	00000000 	nop
    1bfc:	afc20000 	sw	v0,0(s8)
    1c00:	00000000 	nop
    1c04:	8fc20010 	lw	v0,16(s8)
    1c08:	00000000 	nop
    1c0c:	24430001 	addiu	v1,v0,1
    1c10:	afc30010 	sw	v1,16(s8)
    1c14:	8fc30014 	lw	v1,20(s8)
    1c18:	00000000 	nop
    1c1c:	24640001 	addiu	a0,v1,1
    1c20:	afc40014 	sw	a0,20(s8)
    1c24:	80630000 	lb	v1,0(v1)
    1c28:	00000000 	nop
    1c2c:	a0430000 	sb	v1,0(v0)
    1c30:	80420000 	lb	v0,0(v0)
    1c34:	00000000 	nop
    1c38:	1440fff2 	bnez	v0,0x1c04
    1c3c:	00000000 	nop
    1c40:	8fc20000 	lw	v0,0(s8)
    1c44:	03c0e825 	move	sp,s8
    1c48:	8fbe000c 	lw	s8,12(sp)
    1c4c:	27bd0010 	addiu	sp,sp,16
    1c50:	03e00008 	jr	ra
    1c54:	00000000 	nop
    1c58:	27bdffc0 	addiu	sp,sp,-64
    1c5c:	afbf003c 	sw	ra,60(sp)
    1c60:	afbe0038 	sw	s8,56(sp)
    1c64:	03a0f025 	move	s8,sp
    1c68:	afc40040 	sw	a0,64(s8)
    1c6c:	afc50044 	sw	a1,68(s8)
    1c70:	afc60048 	sw	a2,72(s8)
    1c74:	afc7004c 	sw	a3,76(s8)
    1c78:	afc00010 	sw	zero,16(s8)
    1c7c:	1000000a 	b	0x1ca8
    1c80:	00000000 	nop
    1c84:	8fc20010 	lw	v0,16(s8)
    1c88:	27c30010 	addiu	v1,s8,16
    1c8c:	00621021 	addu	v0,v1,v0
    1c90:	24030020 	li	v1,32
    1c94:	a0430010 	sb	v1,16(v0)
    1c98:	8fc20010 	lw	v0,16(s8)
    1c9c:	00000000 	nop
    1ca0:	24420001 	addiu	v0,v0,1
    1ca4:	afc20010 	sw	v0,16(s8)
    1ca8:	8fc20010 	lw	v0,16(s8)
    1cac:	00000000 	nop
    1cb0:	2842000f 	slti	v0,v0,15
    1cb4:	1440fff3 	bnez	v0,0x1c84
    1cb8:	00000000 	nop
    1cbc:	a3c0002f 	sb	zero,47(s8)
    1cc0:	8fc20040 	lw	v0,64(s8)
    1cc4:	00000000 	nop
    1cc8:	04410005 	bgez	v0,0x1ce0
    1ccc:	00000000 	nop
    1cd0:	8fc30048 	lw	v1,72(s8)
    1cd4:	2402000a 	li	v0,10
    1cd8:	10620005 	beq	v1,v0,0x1cf0
    1cdc:	00000000 	nop
    1ce0:	24020001 	li	v0,1
    1ce4:	afc20018 	sw	v0,24(s8)
    1ce8:	10000003 	b	0x1cf8
    1cec:	00000000 	nop
    1cf0:	2402ffff 	li	v0,-1
    1cf4:	afc20018 	sw	v0,24(s8)
    1cf8:	8fc30040 	lw	v1,64(s8)
    1cfc:	8fc20018 	lw	v0,24(s8)
    1d00:	00000000 	nop
    1d04:	00620018 	mult	v1,v0
    1d08:	00001012 	mflo	v0
    1d0c:	afc2001c 	sw	v0,28(s8)
    1d10:	2402000e 	li	v0,14
    1d14:	afc20014 	sw	v0,20(s8)
    1d18:	1000003e 	b	0x1e14
    1d1c:	00000000 	nop
    1d20:	8fc20048 	lw	v0,72(s8)
    1d24:	8fc3001c 	lw	v1,28(s8)
    1d28:	00000000 	nop
    1d2c:	14400002 	bnez	v0,0x1d38
    1d30:	0062001b 	divu	zero,v1,v0
    1d34:	0007000d 	break	0x7
    1d38:	00001010 	mfhi	v0
    1d3c:	afc20010 	sw	v0,16(s8)
    1d40:	8fc20048 	lw	v0,72(s8)
    1d44:	8fc3001c 	lw	v1,28(s8)
    1d48:	00000000 	nop
    1d4c:	14400002 	bnez	v0,0x1d58
    1d50:	0062001b 	divu	zero,v1,v0
    1d54:	0007000d 	break	0x7
    1d58:	00001010 	mfhi	v0
    1d5c:	00001012 	mflo	v0
    1d60:	afc2001c 	sw	v0,28(s8)
    1d64:	8fc20010 	lw	v0,16(s8)
    1d68:	00000000 	nop
    1d6c:	2842000a 	slti	v0,v0,10
    1d70:	1040000a 	beqz	v0,0x1d9c
    1d74:	00000000 	nop
    1d78:	8fc20010 	lw	v0,16(s8)
    1d7c:	00000000 	nop
    1d80:	304200ff 	andi	v0,v0,0xff
    1d84:	24420030 	addiu	v0,v0,48
    1d88:	304200ff 	andi	v0,v0,0xff
    1d8c:	00021600 	sll	v0,v0,0x18
    1d90:	00021603 	sra	v0,v0,0x18
    1d94:	10000008 	b	0x1db8
    1d98:	00000000 	nop
    1d9c:	8fc20010 	lw	v0,16(s8)
    1da0:	00000000 	nop
    1da4:	304200ff 	andi	v0,v0,0xff
    1da8:	24420057 	addiu	v0,v0,87
    1dac:	304200ff 	andi	v0,v0,0xff
    1db0:	00021600 	sll	v0,v0,0x18
    1db4:	00021603 	sra	v0,v0,0x18
    1db8:	8fc30014 	lw	v1,20(s8)
    1dbc:	27c40010 	addiu	a0,s8,16
    1dc0:	00831821 	addu	v1,a0,v1
    1dc4:	a0620010 	sb	v0,16(v1)
    1dc8:	8fc2001c 	lw	v0,28(s8)
    1dcc:	00000000 	nop
    1dd0:	1440000c 	bnez	v0,0x1e04
    1dd4:	00000000 	nop
    1dd8:	2403000f 	li	v1,15
    1ddc:	8fc20014 	lw	v0,20(s8)
    1de0:	00000000 	nop
    1de4:	00621823 	subu	v1,v1,v0
    1de8:	8fc2004c 	lw	v0,76(s8)
    1dec:	00000000 	nop
    1df0:	8c420000 	lw	v0,0(v0)
    1df4:	00000000 	nop
    1df8:	0062102a 	slt	v0,v1,v0
    1dfc:	1040000b 	beqz	v0,0x1e2c
    1e00:	00000000 	nop
    1e04:	8fc20014 	lw	v0,20(s8)
    1e08:	00000000 	nop
    1e0c:	2442ffff 	addiu	v0,v0,-1
    1e10:	afc20014 	sw	v0,20(s8)
    1e14:	8fc20014 	lw	v0,20(s8)
    1e18:	00000000 	nop
    1e1c:	0441ffc0 	bgez	v0,0x1d20
    1e20:	00000000 	nop
    1e24:	10000002 	b	0x1e30
    1e28:	00000000 	nop
    1e2c:	00000000 	nop
    1e30:	8fc30018 	lw	v1,24(s8)
    1e34:	2402ffff 	li	v0,-1
    1e38:	1462000a 	bne	v1,v0,0x1e64
    1e3c:	00000000 	nop
    1e40:	8fc20014 	lw	v0,20(s8)
    1e44:	00000000 	nop
    1e48:	2442ffff 	addiu	v0,v0,-1
    1e4c:	afc20014 	sw	v0,20(s8)
    1e50:	8fc20014 	lw	v0,20(s8)
    1e54:	27c30010 	addiu	v1,s8,16
    1e58:	00621021 	addu	v0,v1,v0
    1e5c:	2403002d 	li	v1,45
    1e60:	a0430010 	sb	v1,16(v0)
    1e64:	8fc2004c 	lw	v0,76(s8)
    1e68:	00000000 	nop
    1e6c:	8c420000 	lw	v0,0(v0)
    1e70:	00000000 	nop
    1e74:	1040000b 	beqz	v0,0x1ea4
    1e78:	00000000 	nop
    1e7c:	8fc2004c 	lw	v0,76(s8)
    1e80:	00000000 	nop
    1e84:	8c430000 	lw	v1,0(v0)
    1e88:	2404000f 	li	a0,15
    1e8c:	8fc20014 	lw	v0,20(s8)
    1e90:	00000000 	nop
    1e94:	00821023 	subu	v0,a0,v0
    1e98:	0062102a 	slt	v0,v1,v0
    1e9c:	10400012 	beqz	v0,0x1ee8
    1ea0:	00000000 	nop
    1ea4:	27c30020 	addiu	v1,s8,32
    1ea8:	8fc20014 	lw	v0,20(s8)
    1eac:	00000000 	nop
    1eb0:	00621021 	addu	v0,v1,v0
    1eb4:	00402825 	move	a1,v0
    1eb8:	8fc40044 	lw	a0,68(s8)
    1ebc:	0c0006f8 	jal	0x1be0
    1ec0:	00000000 	nop
    1ec4:	2403000f 	li	v1,15
    1ec8:	8fc20014 	lw	v0,20(s8)
    1ecc:	00000000 	nop
    1ed0:	00621823 	subu	v1,v1,v0
    1ed4:	8fc2004c 	lw	v0,76(s8)
    1ed8:	00000000 	nop
    1edc:	ac430000 	sw	v1,0(v0)
    1ee0:	1000000c 	b	0x1f14
    1ee4:	00000000 	nop
    1ee8:	8fc2004c 	lw	v0,76(s8)
    1eec:	00000000 	nop
    1ef0:	8c420000 	lw	v0,0(v0)
    1ef4:	2403000f 	li	v1,15
    1ef8:	00621023 	subu	v0,v1,v0
    1efc:	27c30020 	addiu	v1,s8,32
    1f00:	00621021 	addu	v0,v1,v0
    1f04:	00402825 	move	a1,v0
    1f08:	8fc40044 	lw	a0,68(s8)
    1f0c:	0c0006f8 	jal	0x1be0
    1f10:	00000000 	nop
    1f14:	00000000 	nop
    1f18:	03c0e825 	move	sp,s8
    1f1c:	8fbf003c 	lw	ra,60(sp)
    1f20:	8fbe0038 	lw	s8,56(sp)
    1f24:	27bd0040 	addiu	sp,sp,64
    1f28:	03e00008 	jr	ra
    1f2c:	00000000 	nop
    1f30:	27bdfff8 	addiu	sp,sp,-8
    1f34:	afbe0004 	sw	s8,4(sp)
    1f38:	03a0f025 	move	s8,sp
    1f3c:	afc40008 	sw	a0,8(s8)
    1f40:	afc5000c 	sw	a1,12(s8)
    1f44:	3c022000 	lui	v0,0x2000
    1f48:	34420060 	ori	v0,v0,0x60
    1f4c:	3c030003 	lui	v1,0x3
    1f50:	3463fc18 	ori	v1,v1,0xfc18
    1f54:	ac430000 	sw	v1,0(v0)
    1f58:	00000000 	nop
    1f5c:	03c0e825 	move	sp,s8
    1f60:	8fbe0004 	lw	s8,4(sp)
    1f64:	27bd0008 	addiu	sp,sp,8
    1f68:	03e00008 	jr	ra
    1f6c:	00000000 	nop
    1f70:	27bdfff0 	addiu	sp,sp,-16
    1f74:	afbe000c 	sw	s8,12(sp)
    1f78:	03a0f025 	move	s8,sp
    1f7c:	afc40010 	sw	a0,16(s8)
    1f80:	afc00000 	sw	zero,0(s8)
    1f84:	1000000d 	b	0x1fbc
    1f88:	00000000 	nop
    1f8c:	8fc20000 	lw	v0,0(s8)
    1f90:	00000000 	nop
    1f94:	2c420001 	sltiu	v0,v0,1
    1f98:	304200ff 	andi	v0,v0,0xff
    1f9c:	afc20000 	sw	v0,0(s8)
    1fa0:	8fc20010 	lw	v0,16(s8)
    1fa4:	00000000 	nop
    1fa8:	2442ffff 	addiu	v0,v0,-1
    1fac:	8fc30010 	lw	v1,16(s8)
    1fb0:	00000000 	nop
    1fb4:	00621024 	and	v0,v1,v0
    1fb8:	afc20010 	sw	v0,16(s8)
    1fbc:	8fc20010 	lw	v0,16(s8)
    1fc0:	00000000 	nop
    1fc4:	1440fff1 	bnez	v0,0x1f8c
    1fc8:	00000000 	nop
    1fcc:	8fc20000 	lw	v0,0(s8)
    1fd0:	03c0e825 	move	sp,s8
    1fd4:	8fbe000c 	lw	s8,12(sp)
    1fd8:	27bd0010 	addiu	sp,sp,16
    1fdc:	03e00008 	jr	ra
    1fe0:	00000000 	nop
    1fe4:	27bdfff8 	addiu	sp,sp,-8
    1fe8:	afbe0004 	sw	s8,4(sp)
    1fec:	03a0f025 	move	s8,sp
    1ff0:	afc40008 	sw	a0,8(s8)
    1ff4:	afc5000c 	sw	a1,12(s8)
    1ff8:	8fc20008 	lw	v0,8(s8)
    1ffc:	00000000 	nop
    2000:	00021f00 	sll	v1,v0,0x1c
    2004:	8fc2000c 	lw	v0,12(s8)
    2008:	00000000 	nop
    200c:	00021400 	sll	v0,v0,0x10
    2010:	00621025 	or	v0,v1,v0
    2014:	03c0e825 	move	sp,s8
    2018:	8fbe0004 	lw	s8,4(sp)
    201c:	27bd0008 	addiu	sp,sp,8
    2020:	03e00008 	jr	ra
    2024:	00000000 	nop
    2028:	27bdffe0 	addiu	sp,sp,-32
    202c:	afbf001c 	sw	ra,28(sp)
    2030:	afbe0018 	sw	s8,24(sp)
    2034:	03a0f025 	move	s8,sp
    2038:	afc40020 	sw	a0,32(s8)
    203c:	afc50024 	sw	a1,36(s8)
    2040:	8fc20024 	lw	v0,36(s8)
    2044:	00000000 	nop
    2048:	00021040 	sll	v0,v0,0x1
    204c:	8fc30020 	lw	v1,32(s8)
    2050:	00000000 	nop
    2054:	00031f40 	sll	v1,v1,0x1d
    2058:	00431025 	or	v0,v0,v1
    205c:	afc20010 	sw	v0,16(s8)
    2060:	8fc40010 	lw	a0,16(s8)
    2064:	0c0007dc 	jal	0x1f70
    2068:	00000000 	nop
    206c:	afc20014 	sw	v0,20(s8)
    2070:	8fc30010 	lw	v1,16(s8)
    2074:	8fc20014 	lw	v0,20(s8)
    2078:	00000000 	nop
    207c:	00621025 	or	v0,v1,v0
    2080:	03c0e825 	move	sp,s8
    2084:	8fbf001c 	lw	ra,28(sp)
    2088:	8fbe0018 	lw	s8,24(sp)
    208c:	27bd0020 	addiu	sp,sp,32
    2090:	03e00008 	jr	ra
    2094:	00000000 	nop
    2098:	27bdfff0 	addiu	sp,sp,-16
    209c:	afbe000c 	sw	s8,12(sp)
    20a0:	03a0f025 	move	s8,sp
    20a4:	afc40010 	sw	a0,16(s8)
    20a8:	afc50014 	sw	a1,20(s8)
    20ac:	afc60018 	sw	a2,24(s8)
    20b0:	afc7001c 	sw	a3,28(s8)
    20b4:	afc00004 	sw	zero,4(s8)
    20b8:	8fc20010 	lw	v0,16(s8)
    20bc:	00000000 	nop
    20c0:	304300ff 	andi	v1,v0,0xff
    20c4:	8fc20014 	lw	v0,20(s8)
    20c8:	00000000 	nop
    20cc:	ac430000 	sw	v1,0(v0)
    20d0:	8fc20018 	lw	v0,24(s8)
    20d4:	00000000 	nop
    20d8:	ac400000 	sw	zero,0(v0)
    20dc:	8fc2001c 	lw	v0,28(s8)
    20e0:	00000000 	nop
    20e4:	ac400000 	sw	zero,0(v0)
    20e8:	8fc30010 	lw	v1,16(s8)
    20ec:	3c020fff 	lui	v0,0xfff
    20f0:	00621024 	and	v0,v1,v0
    20f4:	00021402 	srl	v0,v0,0x10
    20f8:	00401825 	move	v1,v0
    20fc:	8fc20020 	lw	v0,32(s8)
    2100:	00000000 	nop
    2104:	ac430000 	sw	v1,0(v0)
    2108:	afc00000 	sw	zero,0(s8)
    210c:	10000013 	b	0x215c
    2110:	00000000 	nop
    2114:	8fc20014 	lw	v0,20(s8)
    2118:	00000000 	nop
    211c:	8c430000 	lw	v1,0(v0)
    2120:	8fc20000 	lw	v0,0(s8)
    2124:	00000000 	nop
    2128:	00431007 	srav	v0,v1,v0
    212c:	30420001 	andi	v0,v0,0x1
    2130:	0002102b 	sltu	v0,zero,v0
    2134:	304200ff 	andi	v0,v0,0xff
    2138:	00401825 	move	v1,v0
    213c:	8fc20004 	lw	v0,4(s8)
    2140:	00000000 	nop
    2144:	00431021 	addu	v0,v0,v1
    2148:	afc20004 	sw	v0,4(s8)
    214c:	8fc20000 	lw	v0,0(s8)
    2150:	00000000 	nop
    2154:	24420001 	addiu	v0,v0,1
    2158:	afc20000 	sw	v0,0(s8)
    215c:	8fc20000 	lw	v0,0(s8)
    2160:	00000000 	nop
    2164:	28420008 	slti	v0,v0,8
    2168:	1440ffea 	bnez	v0,0x2114
    216c:	00000000 	nop
    2170:	8fc30004 	lw	v1,4(s8)
    2174:	24020001 	li	v0,1
    2178:	10620004 	beq	v1,v0,0x218c
    217c:	00000000 	nop
    2180:	24020001 	li	v0,1
    2184:	1000002a 	b	0x2230
    2188:	00000000 	nop
    218c:	8fc20018 	lw	v0,24(s8)
    2190:	00000000 	nop
    2194:	8c430000 	lw	v1,0(v0)
    2198:	8fc20024 	lw	v0,36(s8)
    219c:	00000000 	nop
    21a0:	0043102a 	slt	v0,v0,v1
    21a4:	10400004 	beqz	v0,0x21b8
    21a8:	00000000 	nop
    21ac:	24020002 	li	v0,2
    21b0:	1000001f 	b	0x2230
    21b4:	00000000 	nop
    21b8:	8fc2001c 	lw	v0,28(s8)
    21bc:	00000000 	nop
    21c0:	8c430000 	lw	v1,0(v0)
    21c4:	8fc20024 	lw	v0,36(s8)
    21c8:	00000000 	nop
    21cc:	0043102a 	slt	v0,v0,v1
    21d0:	10400004 	beqz	v0,0x21e4
    21d4:	00000000 	nop
    21d8:	24020003 	li	v0,3
    21dc:	10000014 	b	0x2230
    21e0:	00000000 	nop
    21e4:	8fc3001c 	lw	v1,28(s8)
    21e8:	8fc20018 	lw	v0,24(s8)
    21ec:	00000000 	nop
    21f0:	14620004 	bne	v1,v0,0x2204
    21f4:	00000000 	nop
    21f8:	24020004 	li	v0,4
    21fc:	1000000c 	b	0x2230
    2200:	00000000 	nop
    2204:	8fc20020 	lw	v0,32(s8)
    2208:	00000000 	nop
    220c:	8c420000 	lw	v0,0(v0)
    2210:	00000000 	nop
    2214:	28420002 	slti	v0,v0,2
    2218:	10400004 	beqz	v0,0x222c
    221c:	00000000 	nop
    2220:	24020005 	li	v0,5
    2224:	10000002 	b	0x2230
    2228:	00000000 	nop
    222c:	00001025 	move	v0,zero
    2230:	03c0e825 	move	sp,s8
    2234:	8fbe000c 	lw	s8,12(sp)
    2238:	27bd0010 	addiu	sp,sp,16
    223c:	03e00008 	jr	ra
    2240:	00000000 	nop
    2244:	27bdfff8 	addiu	sp,sp,-8
    2248:	afbe0004 	sw	s8,4(sp)
    224c:	03a0f025 	move	s8,sp
    2250:	afc40008 	sw	a0,8(s8)
    2254:	8fc20008 	lw	v0,8(s8)
    2258:	00000000 	nop
    225c:	00021742 	srl	v0,v0,0x1d
    2260:	03c0e825 	move	sp,s8
    2264:	8fbe0004 	lw	s8,4(sp)
    2268:	27bd0008 	addiu	sp,sp,8
    226c:	03e00008 	jr	ra
    2270:	00000000 	nop
    2274:	27bdfff8 	addiu	sp,sp,-8
    2278:	afbe0004 	sw	s8,4(sp)
    227c:	03a0f025 	move	s8,sp
    2280:	afc40008 	sw	a0,8(s8)
    2284:	8fc30008 	lw	v1,8(s8)
    2288:	3c021fff 	lui	v0,0x1fff
    228c:	3442fffe 	ori	v0,v0,0xfffe
    2290:	00621024 	and	v0,v1,v0
    2294:	00021042 	srl	v0,v0,0x1
    2298:	03c0e825 	move	sp,s8
    229c:	8fbe0004 	lw	s8,4(sp)
    22a0:	27bd0008 	addiu	sp,sp,8
    22a4:	03e00008 	jr	ra
    22a8:	00000000 	nop
    22ac:	00000000 	nop
    22b0:	27bdffe8 	addiu	sp,sp,-24
    22b4:	afbe0014 	sw	s8,20(sp)
    22b8:	03a0f025 	move	s8,sp
    22bc:	afc40018 	sw	a0,24(s8)
    22c0:	afc5001c 	sw	a1,28(s8)
    22c4:	24020064 	li	v0,100
    22c8:	afc20000 	sw	v0,0(s8)
    22cc:	2402ffbc 	li	v0,-68
    22d0:	afc20004 	sw	v0,4(s8)
    22d4:	8fc30000 	lw	v1,0(s8)
    22d8:	8fc20004 	lw	v0,4(s8)
    22dc:	00000000 	nop
    22e0:	00621021 	addu	v0,v1,v0
    22e4:	afc20008 	sw	v0,8(s8)
    22e8:	8fc20008 	lw	v0,8(s8)
    22ec:	03c0e825 	move	sp,s8
    22f0:	8fbe0014 	lw	s8,20(sp)
    22f4:	27bd0018 	addiu	sp,sp,24
    22f8:	03e00008 	jr	ra
    22fc:	00000000 	nop

Disassembly of section .MIPS.abiflags:

004000b8 <.MIPS.abiflags>:
  4000b8:	00000100 	sll	zero,zero,0x4
  4000bc:	01010001 	0x1010001
	...

Disassembly of section .reginfo:

004000d0 <.reginfo>:
  4000d0:	fffffffe 	0xfffffffe
	...
  4000e4:	0000ab30 	0xab30

Disassembly of section .rodata:

00002300 <.rodata>:
    2300:	00000003 	sra	zero,zero,0x0
    2304:	00000005 	0x5
    2308:	00000007 	srav	zero,zero,zero
    230c:	0000000b 	0xb
    2310:	0000000d 	break
    2314:	00000011 	mthi	zero
    2318:	00000013 	mtlo	zero
    231c:	00000017 	0x17
    2320:	0000001d 	0x1d
    2324:	0000001f 	0x1f
    2328:	00000025 	move	zero,zero
    232c:	00000029 	0x29
    2330:	0000002b 	sltu	zero,zero,zero
    2334:	0000002f 	0x2f
    2338:	00000035 	0x35
    233c:	0000003b 	0x3b
    2340:	0000003d 	0x3d
    2344:	00000043 	sra	zero,zero,0x1
    2348:	00000047 	0x47
    234c:	00000049 	0x49
    2350:	0000004f 	0x4f
    2354:	00000053 	0x53
    2358:	00000059 	0x59
    235c:	00000061 	0x61
    2360:	00000065 	0x65
    2364:	00000067 	0x67
    2368:	0000006b 	0x6b
    236c:	0000006d 	0x6d
    2370:	00000071 	0x71
    2374:	0000007f 	0x7f
    2378:	00000083 	sra	zero,zero,0x2
    237c:	00000089 	0x89
    2380:	0000008b 	0x8b
    2384:	00000095 	0x95
    2388:	00000097 	0x97
    238c:	0000009d 	0x9d
    2390:	000000a3 	0xa3
    2394:	000000a7 	0xa7
    2398:	000000ad 	0xad
    239c:	000000b3 	0xb3
    23a0:	000000b5 	0xb5
    23a4:	000000bf 	0xbf
    23a8:	000000c1 	0xc1
    23ac:	000000c5 	0xc5
    23b0:	000000c7 	0xc7
    23b4:	000000d3 	0xd3
    23b8:	000000df 	0xdf
    23bc:	000000e3 	0xe3
    23c0:	000000e5 	0xe5
    23c4:	000000e9 	0xe9
    23c8:	000000ef 	0xef
    23cc:	000000f1 	0xf1
    23d0:	000000fb 	0xfb
    23d4:	00000101 	0x101
    23d8:	00000107 	0x107
    23dc:	0000010d 	break	0x0,0x4
    23e0:	0000010f 	0x10f
    23e4:	00000115 	0x115
    23e8:	00000119 	0x119
    23ec:	0000011b 	0x11b
    23f0:	00000125 	0x125
    23f4:	00000133 	0x133
    23f8:	00000137 	0x137
    23fc:	00000139 	0x139
    2400:	0000013d 	0x13d
    2404:	0000014b 	0x14b
    2408:	00000151 	0x151
    240c:	0000015b 	0x15b
    2410:	0000015d 	0x15d
    2414:	00000161 	0x161
    2418:	00000167 	0x167
    241c:	0000016f 	0x16f
    2420:	00000175 	0x175
    2424:	0000017b 	0x17b
    2428:	0000017f 	0x17f
    242c:	00000185 	0x185
    2430:	0000018d 	break	0x0,0x6
    2434:	00000191 	0x191
    2438:	00000199 	0x199
    243c:	000001a3 	0x1a3
    2440:	000001a5 	0x1a5
    2444:	000001af 	0x1af
    2448:	000001b1 	0x1b1
    244c:	000001b7 	0x1b7
    2450:	000001bb 	0x1bb
    2454:	000001c1 	0x1c1
    2458:	000001c9 	0x1c9
    245c:	000001cd 	break	0x0,0x7
    2460:	000001cf 	0x1cf
    2464:	000001d3 	0x1d3
    2468:	000001df 	0x1df
    246c:	000001e7 	0x1e7
    2470:	000001eb 	0x1eb
    2474:	000001f3 	0x1f3
    2478:	000001f7 	0x1f7
    247c:	000001fd 	0x1fd
    2480:	00000209 	0x209
    2484:	0000020b 	0x20b
    2488:	0000021d 	0x21d
    248c:	00000223 	0x223
    2490:	0000022d 	0x22d
    2494:	00000233 	0x233
    2498:	00000239 	0x239
    249c:	0000023b 	0x23b
    24a0:	00000241 	0x241
    24a4:	0000024b 	0x24b
    24a8:	00000251 	0x251
    24ac:	00000257 	0x257
    24b0:	00000259 	0x259
    24b4:	0000025f 	0x25f
    24b8:	00000265 	0x265
    24bc:	00000269 	0x269
    24c0:	0000026b 	0x26b
    24c4:	00000277 	0x277
    24c8:	00000281 	0x281
    24cc:	00000283 	sra	zero,zero,0xa
    24d0:	00000287 	0x287
    24d4:	0000028d 	break	0x0,0xa
    24d8:	00000293 	0x293
    24dc:	00000295 	0x295
    24e0:	000002a1 	0x2a1
    24e4:	000002a5 	0x2a5
    24e8:	000002ab 	0x2ab
    24ec:	000002b3 	0x2b3
    24f0:	000002bd 	0x2bd
    24f4:	000002c5 	0x2c5
    24f8:	000002cf 	0x2cf
    24fc:	000002d7 	0x2d7
    2500:	000002dd 	0x2dd
    2504:	000002e3 	0x2e3
    2508:	000002e7 	0x2e7
    250c:	000002ef 	0x2ef
    2510:	000002f5 	0x2f5
    2514:	000002f9 	0x2f9
    2518:	00000301 	0x301
    251c:	00000305 	0x305
    2520:	00000313 	0x313
    2524:	0000031d 	0x31d
    2528:	00000329 	0x329
    252c:	0000032b 	0x32b
    2530:	00000335 	0x335
    2534:	00000337 	0x337
    2538:	0000033b 	0x33b
    253c:	0000033d 	0x33d
    2540:	00000347 	0x347
    2544:	00000355 	0x355
    2548:	00000359 	0x359
    254c:	0000035b 	0x35b
    2550:	0000035f 	0x35f
    2554:	0000036d 	0x36d
    2558:	00000371 	0x371
    255c:	00000373 	0x373
    2560:	00000377 	0x377
    2564:	0000038b 	0x38b
    2568:	0000038f 	0x38f
    256c:	00000397 	0x397
    2570:	000003a1 	0x3a1
    2574:	000003a9 	0x3a9
    2578:	000003ad 	0x3ad
    257c:	000003b3 	0x3b3
    2580:	000003b9 	0x3b9
    2584:	000003c7 	0x3c7
    2588:	000003cb 	0x3cb
    258c:	000003d1 	0x3d1
    2590:	000003d7 	0x3d7
    2594:	000003df 	0x3df
    2598:	000003e5 	0x3e5
    259c:	12345678 	beq	s1,s4,0x17f80
    25a0:	091a2b3c 	j	0x468acf0
    25a4:	048d159e 	0x48d159e
    25a8:	02468acf 	0x2468acf
    25ac:	01234567 	0x1234567
    25b0:	0091a2b3 	0x91a2b3
    25b4:	0048d159 	0x48d159
    25b8:	002468ac 	0x2468ac
    25bc:	00123456 	0x123456
    25c0:	00091a2b 	0x91a2b
    25c4:	00048d15 	0x48d15
    25c8:	0002468a 	0x2468a
    25cc:	00012345 	0x12345
    25d0:	000091a2 	0x91a2
    25d4:	000048d1 	0x48d1
    25d8:	00002468 	0x2468
    25dc:	00001234 	0x1234
    25e0:	0000091a 	0x91a
    25e4:	0000048d 	break	0x0,0x12
    25e8:	00000246 	0x246
    25ec:	00000123 	0x123
    25f0:	00000091 	0x91
    25f4:	00000048 	0x48
    25f8:	00000024 	and	zero,zero,zero
    25fc:	00000012 	mflo	zero
    2600:	00000009 	jalr	zero,zero
    2604:	00000004 	sllv	zero,zero,zero
    2608:	00000002 	srl	zero,zero,0x0
    260c:	00000001 	0x1
	...
    261c:	92345678 	lbu	s4,22136(s1)
    2620:	c91a2b3c 	lwc2	$26,11068(t0)
    2624:	e48d159e 	swc1	$f13,5534(a0)
    2628:	f2468acf 	0xf2468acf
    262c:	f9234567 	0xf9234567
    2630:	fc91a2b3 	0xfc91a2b3
    2634:	fe48d159 	0xfe48d159
    2638:	ff2468ac 	0xff2468ac
    263c:	ff923456 	0xff923456
    2640:	ffc91a2b 	0xffc91a2b
    2644:	ffe48d15 	0xffe48d15
    2648:	fff2468a 	0xfff2468a
    264c:	fff92345 	0xfff92345
    2650:	fffc91a2 	0xfffc91a2
    2654:	fffe48d1 	0xfffe48d1
    2658:	ffff2468 	0xffff2468
    265c:	ffff9234 	0xffff9234
    2660:	ffffc91a 	0xffffc91a
    2664:	ffffe48d 	0xffffe48d
    2668:	fffff246 	0xfffff246
    266c:	fffff923 	0xfffff923
    2670:	fffffc91 	0xfffffc91
    2674:	fffffe48 	0xfffffe48
    2678:	ffffff24 	0xffffff24
    267c:	ffffff92 	0xffffff92
    2680:	ffffffc9 	0xffffffc9
    2684:	ffffffe4 	0xffffffe4
    2688:	fffffff2 	0xfffffff2
    268c:	fffffff9 	0xfffffff9
    2690:	fffffffc 	0xfffffffc
    2694:	fffffffe 	0xfffffffe
    2698:	ffffffff 	0xffffffff
    269c:	00000000 	nop
    26a0:	00000007 	srav	zero,zero,zero
    26a4:	0000000e 	0xe
    26a8:	00000015 	0x15
    26ac:	0000001c 	0x1c
    26b0:	00000023 	negu	zero,zero
    26b4:	000007f5 	0x7f5
    26b8:	000007fc 	0x7fc
    26bc:	00000803 	sra	at,zero,0x0
    26c0:	0000080a 	0x80a
    26c4:	00000811 	0x811
    26c8:	00000818 	0x818
    26cc:	00000007 	srav	zero,zero,zero
    26d0:	00000003 	sra	zero,zero,0x0
    26d4:	00000002 	srl	zero,zero,0x0
    26d8:	00000001 	0x1
    26dc:	00000001 	0x1
    26e0:	00000001 	0x1
    26e4:	00000001 	0x1
	...
    26f4:	00000001 	0x1
    26f8:	00000001 	0x1
    26fc:	00000003 	sra	zero,zero,0x0
    2700:	00000002 	srl	zero,zero,0x0
    2704:	00000001 	0x1
    2708:	00000000 	nop
    270c:	00000007 	srav	zero,zero,zero
    2710:	00000007 	srav	zero,zero,zero
    2714:	00000000 	nop
    2718:	00000321 	0x321
    271c:	00000642 	srl	zero,zero,0x19
    2720:	00000963 	0x963
    2724:	00000c84 	0xc84
    2728:	00000fa5 	0xfa5
    272c:	00038e83 	sra	s1,v1,0x1a
    2730:	000391a4 	0x391a4
    2734:	000394c5 	0x394c5
    2738:	000397e6 	0x397e6
    273c:	00039b07 	0x39b07
    2740:	00039e28 	0x39e28
    2744:	00000321 	0x321
    2748:	00000190 	0x190
    274c:	0000010b 	0x10b
    2750:	000000c8 	0xc8
    2754:	000000a0 	0xa0
    2758:	00000085 	0x85
    275c:	00000072 	0x72
    2760:	00000064 	0x64
    2764:	00000059 	0x59
    2768:	00000000 	nop
    276c:	00000001 	0x1
    2770:	00000000 	nop
    2774:	00000001 	0x1
    2778:	00000001 	0x1
    277c:	00000003 	sra	zero,zero,0x0
    2780:	00000003 	sra	zero,zero,0x0
    2784:	00000001 	0x1
	...
    2790:	00054321 	0x54321
    2794:	000a8642 	srl	s0,t2,0x19
    2798:	000fc963 	0xfc963
    279c:	00150c84 	0x150c84
    27a0:	001a4fa5 	0x1a4fa5
    27a4:	05fb4e83 	0x5fb4e83
    27a8:	060091a4 	bltz	s0,0xfffe6e3c
    27ac:	0605d4c5 	0x605d4c5
    27b0:	060b17e6 	0x60b17e6
    27b4:	06105b07 	bltzal	s0,0x193d4
    27b8:	06159e28 	0x6159e28
    27bc:	00054321 	0x54321
    27c0:	0002a190 	0x2a190
    27c4:	0001c10b 	0x1c10b
    27c8:	000150c8 	0x150c8
    27cc:	00010d6d 	0x10d6d
    27d0:	0000e085 	0xe085
    27d4:	0000c072 	0xc072
    27d8:	0000a864 	0xa864
    27dc:	000095ae 	0x95ae
    27e0:	00000000 	nop
    27e4:	00000001 	0x1
    27e8:	00000000 	nop
    27ec:	00000001 	0x1
    27f0:	00000000 	nop
    27f4:	00000003 	sra	zero,zero,0x0
    27f8:	00000003 	sra	zero,zero,0x0
    27fc:	00000001 	0x1
    2800:	00000003 	sra	zero,zero,0x0
    2804:	00000000 	nop
    2808:	00012345 	0x12345
    280c:	0002468a 	0x2468a
    2810:	000369cf 	0x369cf
    2814:	00048d14 	0x48d14
    2818:	0005b059 	0x5b059
    281c:	014b176f 	0x14b176f
    2820:	014c3ab4 	0x14c3ab4
    2824:	014d5df9 	0x14d5df9
    2828:	014e813e 	0x14e813e
    282c:	014fa483 	0x14fa483
    2830:	0150c7c8 	0x150c7c8
    2834:	00012345 	0x12345
    2838:	000091a2 	0x91a2
    283c:	00006117 	0x6117
    2840:	000048d1 	0x48d1
    2844:	00003a41 	0x3a41
    2848:	0000308b 	0x308b
    284c:	0000299c 	0x299c
    2850:	00002468 	0x2468
    2854:	0000205d 	0x205d
    2858:	00000000 	nop
    285c:	00000001 	0x1
    2860:	00000000 	nop
    2864:	00000001 	0x1
    2868:	00000000 	nop
    286c:	00000003 	sra	zero,zero,0x0
    2870:	00000001 	0x1
    2874:	00000005 	0x5
    2878:	00000000 	nop
    287c:	00001234 	0x1234
    2880:	00001235 	0x1235
    2884:	00001236 	0x1236
    2888:	00001237 	0x1237
    288c:	00001238 	0x1238
    2890:	00001239 	0x1239
    2894:	0000123a 	0x123a
    2898:	0000123b 	0x123b
    289c:	0000123c 	0x123c
    28a0:	0000123d 	0x123d
    28a4:	00001234 	0x1234
    28a8:	00001233 	0x1233
    28ac:	00001232 	0x1232
    28b0:	00001231 	0x1231
    28b4:	00001230 	0x1230
    28b8:	0000122f 	0x122f
    28bc:	0000122e 	0x122e
    28c0:	0000122d 	0x122d
    28c4:	0000122c 	0x122c
    28c8:	0000122b 	0x122b
    28cc:	0a47656e 	j	0x91d95b8
    28d0:	6572616c 	0x6572616c
    28d4:	20706c61 	addi	s0,v1,27745
    28d8:	736d6120 	0x736d6120
    28dc:	74657374 	jalx	0x195cdd0
    28e0:	0a0a0000 	j	0x8280000
    28e4:	0a546573 	j	0x95195cc
    28e8:	74696e67 	jalx	0x1a5b99c
    28ec:	20736869 	addi	s3,v1,26729
    28f0:	6674696e 	0x6674696e
    28f4:	670a0000 	0x670a0000
    28f8:	3d3d3d3d 	0x3d3d3d3d
    28fc:	3d3d3d3d 	0x3d3d3d3d
    2900:	3d3d3d3d 	0x3d3d3d3d
    2904:	3d3d3d3d 	0x3d3d3d3d
    2908:	3d3d3d3d 	0x3d3d3d3d
    290c:	3d0a0000 	0x3d0a0000
    2910:	0a0a5465 	j	0x8295194
    2914:	7374696e 	0x7374696e
    2918:	67206d75 	0x67206d75
    291c:	6c746970 	0x6c746970
    2920:	6c696361 	0x6c696361
    2924:	74696f6e 	jalx	0x1a5bdb8
    2928:	202f2064 	addi	t7,at,8292
    292c:	69766973 	0x69766973
    2930:	696f6e0a 	0x696f6e0a
    2934:	00000000 	nop
    2938:	0a0a5465 	j	0x8295194
    293c:	7374696e 	0x7374696e
    2940:	67206164 	0x67206164
    2944:	64696e67 	0x64696e67
    2948:	202f2073 	addi	t7,at,8307
    294c:	75627472 	jalx	0x589d1c8
    2950:	61637469 	0x61637469
    2954:	6f6e0a00 	0x6f6e0a00
    2958:	54657374 	0x54657374
    295c:	696e6720 	0x696e6720
    2960:	62697420 	0x62697420
    2964:	6f706572 	0x6f706572
    2968:	6174696f 	0x6174696f
    296c:	6e730a00 	0x6e730a00
    2970:	54657374 	0x54657374
    2974:	696e6720 	0x696e6720
    2978:	6d656d6f 	0x6d656d6f
    297c:	72792061 	0x72792061
    2980:	63636573 	0x63636573
    2984:	73730a00 	0x73730a00
    2988:	4c697374 	0x4c697374
    298c:	696e6720 	0x696e6720
    2990:	616c6c20 	0x616c6c20
    2994:	7072696d 	0x7072696d
    2998:	65206e75 	0x65206e75
    299c:	6d626572 	0x6d626572
    29a0:	7320736d 	0x7320736d
    29a4:	616c6c65 	0x616c6c65
    29a8:	72207468 	0x72207468
    29ac:	616e2031 	0x616e2031
    29b0:	3030300a 	andi	s0,at,0x300a
    29b4:	00000000 	nop
    29b8:	54657374 	0x54657374
    29bc:	696e6720 	0x696e6720
    29c0:	646f6e65 	0x646f6e65
    29c4:	0a0a0000 	j	0x8280000
    29c8:	504c4153 	0x504c4153
    29cc:	4d412054 	0x4d412054
    29d0:	45535420 	0x45535420
    29d4:	00000000 	nop
    29d8:	50415353 	0x50415353
    29dc:	45442100 	0x45442100
    29e0:	4641494c 	c1	0x41494c
    29e4:	4544210a 	0x4544210a
    29e8:	00000000 	nop
    29ec:	546f7461 	0x546f7461
    29f0:	6c206661 	0x6c206661
    29f4:	696c6564 	0x696c6564
    29f8:	20746573 	addi	s4,v1,25971
    29fc:	74733a20 	jalx	0x1cce880
    2a00:	00000000 	nop
    2a04:	0a0a5052 	j	0x8294148
    2a08:	494d4520 	0x494d4520
    2a0c:	4e554d42 	c3	0x554d42
    2a10:	45522043 	0x45522043
    2a14:	414c4355 	0x414c4355
    2a18:	4c415449 	0x4c415449
    2a1c:	4f4e2046 	c3	0x14e2046
    2a20:	41494c45 	0x41494c45
    2a24:	44210a0a 	0x44210a0a
    2a28:	00000000 	nop
    2a2c:	0a0a5052 	j	0x8294148
    2a30:	494d4520 	0x494d4520
    2a34:	4e554d42 	c3	0x554d42
    2a38:	45522043 	0x45522043
    2a3c:	414c4355 	0x414c4355
    2a40:	4c415449 	0x4c415449
    2a44:	4f4e2050 	c3	0x14e2050
    2a48:	41535345 	0x41535345
    2a4c:	44210a0a 	0x44210a0a
    2a50:	00000000 	nop
    2a54:	0a0a5348 	j	0x8294d20
    2a58:	49465449 	0x49465449
    2a5c:	4e472054 	c3	0x472054
    2a60:	45535420 	0x45535420
    2a64:	00000000 	nop
    2a68:	20464149 	addi	a2,v0,16713
    2a6c:	4c454421 	0x4c454421
    2a70:	0a0a0000 	j	0x8280000
    2a74:	20504153 	addi	s0,v0,16723
    2a78:	53454421 	0x53454421
    2a7c:	0a0a0000 	j	0x8280000
    2a80:	0a0a4d55 	j	0x8293554
    2a84:	4c544950 	0x4c544950
    2a88:	4c494341 	0x4c494341
    2a8c:	54494f4e 	0x54494f4e
    2a90:	202f2044 	addi	t7,at,8260
    2a94:	49564953 	0x49564953
    2a98:	494f4e20 	0x494f4e20
    2a9c:	54455354 	0x54455354
    2aa0:	20000000 	addi	zero,zero,0
    2aa4:	0a0a4144 	j	0x8290510
    2aa8:	44455220 	0x44455220
    2aac:	2f205355 	sltiu	zero,t9,21333
    2ab0:	42545241 	c0	0x545241
    2ab4:	43544f52 	c0	0x1544f52
    2ab8:	20544553 	addi	s4,v0,17747
    2abc:	54200000 	0x54200000
    2ac0:	0a0a4d45 	j	0x8293514
    2ac4:	4d4f5259 	0x4d4f5259
    2ac8:	20544553 	addi	s4,v0,17747
    2acc:	54200000 	0x54200000
    2ad0:	0a0a4249 	j	0x8290924
    2ad4:	54204f50 	0x54204f50
    2ad8:	45524154 	0x45524154
    2adc:	494f4e53 	0x494f4e53
    2ae0:	20544553 	addi	s4,v0,17747
    2ae4:	54200000 	0x54200000
    2ae8:	00000000 	nop
    2aec:	00000001 	0x1
    2af0:	00000002 	srl	zero,zero,0x0
    2af4:	00000003 	sra	zero,zero,0x0
    2af8:	00000004 	sllv	zero,zero,zero
    2afc:	00000005 	0x5
    2b00:	00000006 	srlv	zero,zero,zero
    2b04:	00000007 	srav	zero,zero,zero
    2b08:	00000008 	jr	zero
    2b0c:	00000009 	jalr	zero,zero
    2b10:	00000220 	0x220
    2b14:	00005335 	0x5335
    2b18:	00005115 	0x5115
    2b1c:	ffffedcb 	0xffffedcb
    2b20:	00001246 	0x1246
    2b24:	00001222 	0x1222
	...

Disassembly of section .data:

00002b30 <.data>:
    2b30:	00000001 	0x1
	...

Disassembly of section .sbss:

00002b40 <.sbss>:
	...

Disassembly of section .bss:

00002b50 <.bss>:
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	4743433a 	c1	0x143433a
   4:	20285562 	addi	t0,at,21858
   8:	756e7475 	jalx	0x5b9d1d4
   c:	20352e34 	addi	s5,at,11828
  10:	2e302d36 	sltiu	s0,s1,11574
  14:	7562756e 	jalx	0x589d5b8
  18:	7475317e 	jalx	0x1d4c5f8
  1c:	31362e30 	andi	s6,t1,0x2e30
  20:	342e3129 	ori	t6,at,0x3129
  24:	20352e34 	addi	s5,at,11828
  28:	2e302032 	sltiu	s0,s1,8242
  2c:	30313630 	andi	s1,at,0x3630
  30:	36303900 	ori	s0,s1,0x3900

Disassembly of section .pdr:

00000000 <.pdr>:
	...
  20:	0000003c 	0x3c
	...
  40:	00000128 	0x128
	...
  60:	00000134 	0x134
	...
  80:	00000170 	0x170
	...
  a0:	000001a8 	0x1a8
	...
  c0:	000001e0 	0x1e0
	...
  e0:	000001f4 	0x1f4
	...
 100:	00000200 	sll	zero,zero,0x8
 104:	40000000 	mfc0	zero,c0_index
 108:	fffffffc 	0xfffffffc
	...
 114:	00000010 	mfhi	zero
 118:	0000001e 	0x1e
 11c:	0000001f 	0x1f
 120:	00000260 	0x260
 124:	40000000 	mfc0	zero,c0_index
 128:	fffffffc 	0xfffffffc
	...
 134:	00000008 	jr	zero
 138:	0000001e 	0x1e
 13c:	0000001f 	0x1f
 140:	000002b8 	0x2b8
 144:	c0000000 	lwc0	c0_index,0(zero)
 148:	fffffffc 	0xfffffffc
	...
 154:	00000018 	mult	zero,zero
 158:	0000001e 	0x1e
 15c:	0000001f 	0x1f
 160:	00000350 	0x350
 164:	c0000000 	lwc0	c0_index,0(zero)
 168:	fffffffc 	0xfffffffc
	...
 174:	00000020 	add	zero,zero,zero
 178:	0000001e 	0x1e
 17c:	0000001f 	0x1f
 180:	00000414 	0x414
 184:	c0000000 	lwc0	c0_index,0(zero)
 188:	fffffffc 	0xfffffffc
	...
 194:	000000a0 	0xa0
 198:	0000001e 	0x1e
 19c:	0000001f 	0x1f
 1a0:	000004f0 	0x4f0
 1a4:	40000000 	mfc0	zero,c0_index
 1a8:	fffffffc 	0xfffffffc
	...
 1b4:	00000008 	jr	zero
 1b8:	0000001e 	0x1e
 1bc:	0000001f 	0x1f
 1c0:	00000524 	0x524
 1c4:	c0000000 	lwc0	c0_index,0(zero)
 1c8:	fffffffc 	0xfffffffc
	...
 1d4:	00000018 	mult	zero,zero
 1d8:	0000001e 	0x1e
 1dc:	0000001f 	0x1f
 1e0:	00000580 	sll	zero,zero,0x16
 1e4:	c0000000 	lwc0	c0_index,0(zero)
 1e8:	fffffffc 	0xfffffffc
	...
 1f4:	00000020 	add	zero,zero,zero
 1f8:	0000001e 	0x1e
 1fc:	0000001f 	0x1f
 200:	00000850 	0x850
 204:	c0000000 	lwc0	c0_index,0(zero)
 208:	fffffffc 	0xfffffffc
	...
 214:	00000028 	0x28
 218:	0000001e 	0x1e
 21c:	0000001f 	0x1f
 220:	00000a20 	0xa20
 224:	c0000000 	lwc0	c0_index,0(zero)
 228:	fffffffc 	0xfffffffc
	...
 234:	00000028 	0x28
 238:	0000001e 	0x1e
 23c:	0000001f 	0x1f
 240:	00000b9c 	0xb9c
 244:	c0000000 	lwc0	c0_index,0(zero)
 248:	fffffffc 	0xfffffffc
	...
 254:	00000028 	0x28
 258:	0000001e 	0x1e
 25c:	0000001f 	0x1f
 260:	00000ff8 	0xff8
 264:	c0000000 	lwc0	c0_index,0(zero)
 268:	fffffffc 	0xfffffffc
	...
 274:	00000028 	0x28
 278:	0000001e 	0x1e
 27c:	0000001f 	0x1f
 280:	0000122c 	0x122c
 284:	c0000000 	lwc0	c0_index,0(zero)
 288:	fffffffc 	0xfffffffc
	...
 294:	00000098 	0x98
 298:	0000001e 	0x1e
 29c:	0000001f 	0x1f
 2a0:	0000158c 	syscall	0x56
 2a4:	c0000000 	lwc0	c0_index,0(zero)
 2a8:	fffffffc 	0xfffffffc
	...
 2b4:	00000028 	0x28
 2b8:	0000001e 	0x1e
 2bc:	0000001f 	0x1f
 2c0:	000018e0 	0x18e0
 2c4:	40000000 	mfc0	zero,c0_index
 2c8:	fffffffc 	0xfffffffc
	...
 2d4:	00000008 	jr	zero
 2d8:	0000001e 	0x1e
 2dc:	0000001f 	0x1f
 2e0:	00001968 	0x1968
 2e4:	40000000 	mfc0	zero,c0_index
 2e8:	fffffffc 	0xfffffffc
	...
 2f4:	00000010 	mfhi	zero
 2f8:	0000001e 	0x1e
 2fc:	0000001f 	0x1f
 300:	00001a78 	0x1a78
 304:	40000000 	mfc0	zero,c0_index
 308:	fffffffc 	0xfffffffc
	...
 314:	00000018 	mult	zero,zero
 318:	0000001e 	0x1e
 31c:	0000001f 	0x1f
 320:	00001be0 	0x1be0
 324:	40000000 	mfc0	zero,c0_index
 328:	fffffffc 	0xfffffffc
	...
 334:	00000010 	mfhi	zero
 338:	0000001e 	0x1e
 33c:	0000001f 	0x1f
 340:	00001c58 	0x1c58
 344:	c0000000 	lwc0	c0_index,0(zero)
 348:	fffffffc 	0xfffffffc
	...
 354:	00000040 	ssnop
 358:	0000001e 	0x1e
 35c:	0000001f 	0x1f
 360:	00001f30 	0x1f30
 364:	40000000 	mfc0	zero,c0_index
 368:	fffffffc 	0xfffffffc
	...
 374:	00000008 	jr	zero
 378:	0000001e 	0x1e
 37c:	0000001f 	0x1f
 380:	00001f70 	0x1f70
 384:	40000000 	mfc0	zero,c0_index
 388:	fffffffc 	0xfffffffc
	...
 394:	00000010 	mfhi	zero
 398:	0000001e 	0x1e
 39c:	0000001f 	0x1f
 3a0:	00001fe4 	0x1fe4
 3a4:	40000000 	mfc0	zero,c0_index
 3a8:	fffffffc 	0xfffffffc
	...
 3b4:	00000008 	jr	zero
 3b8:	0000001e 	0x1e
 3bc:	0000001f 	0x1f
 3c0:	00002028 	0x2028
 3c4:	c0000000 	lwc0	c0_index,0(zero)
 3c8:	fffffffc 	0xfffffffc
	...
 3d4:	00000020 	add	zero,zero,zero
 3d8:	0000001e 	0x1e
 3dc:	0000001f 	0x1f
 3e0:	00002098 	0x2098
 3e4:	40000000 	mfc0	zero,c0_index
 3e8:	fffffffc 	0xfffffffc
	...
 3f4:	00000010 	mfhi	zero
 3f8:	0000001e 	0x1e
 3fc:	0000001f 	0x1f
 400:	00002244 	0x2244
 404:	40000000 	mfc0	zero,c0_index
 408:	fffffffc 	0xfffffffc
	...
 414:	00000008 	jr	zero
 418:	0000001e 	0x1e
 41c:	0000001f 	0x1f
 420:	00002274 	0x2274
 424:	40000000 	mfc0	zero,c0_index
 428:	fffffffc 	0xfffffffc
	...
 434:	00000008 	jr	zero
 438:	0000001e 	0x1e
 43c:	0000001f 	0x1f
 440:	000022b0 	0x22b0
 444:	40000000 	mfc0	zero,c0_index
 448:	fffffffc 	0xfffffffc
	...
 454:	00000018 	mult	zero,zero
 458:	0000001e 	0x1e
 45c:	0000001f 	0x1f

Disassembly of section .gnu.attributes:

00000000 <.gnu.attributes>:
   0:	41000000 	bc0f	0x4
   4:	0f676e75 	jal	0xd9db9d4
   8:	00010000 	sll	zero,at,0x0
   c:	00070401 	0x70401
