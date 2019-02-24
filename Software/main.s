	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	softfloat
	.module	oddspreg
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.globl	long_delay
.LFB1 = .
	.file 1 "main.c"
	.loc 1 25 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	long_delay
	.type	long_delay, @function
long_delay:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	.cfi_def_cfa_offset 8
	.loc 1 30 0
	sw	$0,0($sp)
	lw	$2,0($sp)
	sltu	$2,$2,2
	beq	$2,$0,.L1
	nop

.L4:
	.loc 1 30 0 is_stmt 0 discriminator 3
	lw	$2,0($sp)
	addiu	$2,$2,1
	sw	$2,0($sp)
	lw	$2,0($sp)
	sltu	$2,$2,2
	bne	$2,$0,.L4
	nop

.L1:
	.loc 1 31 0 is_stmt 1
	jr	$31
	addiu	$sp,$sp,8

	.cfi_def_cfa_offset 0
	.set	macro
	.set	reorder
	.end	long_delay
	.cfi_endproc
.LFE1:
	.size	long_delay, .-long_delay
	.align	2
	.globl	delay_slot
.LFB2 = .
	.loc 1 33 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	delay_slot
	.type	delay_slot, @function
delay_slot:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.loc 1 34 0
 #APP
 # 34 "main.c" 1
	ori $0, $0, 0x1234
 # 0 "" 2
	.loc 1 35 0
 # 35 "main.c" 1
	ori $0, $0, 0x1234
 # 0 "" 2
 #NO_APP
	jr	$31
	.end	delay_slot
	.cfi_endproc
.LFE2:
	.size	delay_slot, .-delay_slot
	.align	2
	.globl	draw_line
.LFB3 = .
	.loc 1 38 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	draw_line
	.type	draw_line, @function
draw_line:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
.LVL0 = .
	addiu	$sp,$sp,-32
	.cfi_def_cfa_offset 32
	sw	$31,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	.cfi_offset 31, -4
	.cfi_offset 17, -8
	.cfi_offset 16, -12
	.loc 1 39 0
	li	$16,-1082130432			# 0xffffffffbf800000
	sw	$0,32($16)
	.loc 1 40 0
	sw	$0,36($16)
	.loc 1 41 0
	sw	$4,16($16)
	.loc 1 42 0
	sw	$5,24($16)
	.loc 1 43 0
	sw	$6,20($16)
	.loc 1 44 0
	sw	$7,28($16)
	.loc 1 45 0
	jal	delay_slot
	li	$17,1			# 0x1

.LVL1 = .
	.loc 1 46 0
	sw	$17,36($16)
	.loc 1 47 0
	jal	delay_slot
	nop

.LVL2 = .
	.loc 1 48 0
	sw	$0,36($16)
	.loc 1 49 0
	jal	delay_slot
	nop

.LVL3 = .
	.loc 1 50 0
	sw	$17,32($16)
	.loc 1 51 0
	jal	delay_slot
	nop

.LVL4 = .
	.loc 1 52 0
	sw	$0,32($16)
	.loc 1 55 0
	li	$3,-1082130432			# 0xffffffffbf800000
.L9:
	lw	$2,40($3)
	beq	$2,$0,.L9
	nop

	.loc 1 59 0
	jal	delay_slot
	nop

.LVL5 = .
	.loc 1 60 0
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.cfi_def_cfa_offset 0
	.cfi_restore 16
	.cfi_restore 17
	.cfi_restore 31
	.set	macro
	.set	reorder
	.end	draw_line
	.cfi_endproc
.LFE3:
	.size	draw_line, .-draw_line
	.align	2
	.globl	main
.LFB0 = .
	.loc 1 16 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	.cfi_def_cfa_offset 24
	sw	$31,20($sp)
	.cfi_offset 31, -4
	.loc 1 18 0
	li	$4,10			# 0xa
	li	$5,11			# 0xb
	li	$6,15			# 0xf
	jal	draw_line
	li	$7,11			# 0xb

.LVL6 = .
	.loc 1 19 0
	li	$4,9			# 0x9
	li	$5,8			# 0x8
	li	$6,16			# 0x10
	jal	draw_line
	li	$7,8			# 0x8

.LVL7 = .
	.loc 1 20 0
	li	$4,7			# 0x7
	li	$5,6			# 0x6
	li	$6,12			# 0xc
	jal	draw_line
	li	$7,6			# 0x6

.LVL8 = .
	.loc 1 23 0
	move	$2,$0
	lw	$31,20($sp)
	jr	$31
	addiu	$sp,$sp,24

	.cfi_def_cfa_offset 0
	.cfi_restore 31
	.set	macro
	.set	reorder
	.end	main
	.cfi_endproc
.LFE0:
	.size	main, .-main
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x15b
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF3
	.byte	0x1
	.4byte	.LASF4
	.4byte	.LASF5
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.4byte	.LASF1
	.byte	0x1
	.byte	0x19
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x47
	.uleb128 0x3
	.ascii	"j\000"
	.byte	0x1
	.byte	0x1a
	.4byte	0x47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0
	.uleb128 0x4
	.4byte	0x4c
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x6
	.4byte	.LASF6
	.byte	0x1
	.byte	0x21
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x7
	.4byte	.LASF7
	.byte	0x1
	.byte	0x26
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xdf
	.uleb128 0x8
	.ascii	"x0\000"
	.byte	0x1
	.byte	0x26
	.4byte	0xdf
	.4byte	.LLST0
	.uleb128 0x8
	.ascii	"y0\000"
	.byte	0x1
	.byte	0x26
	.4byte	0xdf
	.4byte	.LLST1
	.uleb128 0x8
	.ascii	"x1\000"
	.byte	0x1
	.byte	0x26
	.4byte	0xdf
	.4byte	.LLST2
	.uleb128 0x8
	.ascii	"y1\000"
	.byte	0x1
	.byte	0x26
	.4byte	0xdf
	.4byte	.LLST3
	.uleb128 0x9
	.4byte	.LVL1
	.4byte	0x53
	.uleb128 0x9
	.4byte	.LVL2
	.4byte	0x53
	.uleb128 0x9
	.4byte	.LVL3
	.4byte	0x53
	.uleb128 0x9
	.4byte	.LVL4
	.4byte	0x53
	.uleb128 0x9
	.4byte	.LVL5
	.4byte	0x53
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0xb
	.4byte	.LASF2
	.byte	0x1
	.byte	0x10
	.4byte	0xdf
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xc
	.4byte	.LVL6
	.4byte	0x64
	.4byte	0x11d
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x57
	.uleb128 0x1
	.byte	0x3b
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x56
	.uleb128 0x1
	.byte	0x3f
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x3b
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x3a
	.byte	0
	.uleb128 0xc
	.4byte	.LVL7
	.4byte	0x64
	.4byte	0x13f
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x57
	.uleb128 0x1
	.byte	0x38
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x56
	.uleb128 0x1
	.byte	0x40
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x38
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x39
	.byte	0
	.uleb128 0xe
	.4byte	.LVL8
	.4byte	0x64
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x57
	.uleb128 0x1
	.byte	0x36
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x56
	.uleb128 0x1
	.byte	0x3c
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x36
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x37
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL0-.Ltext0
	.4byte	.LVL1-1-.Ltext0
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL1-1-.Ltext0
	.4byte	.LFE3-.Ltext0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL0-.Ltext0
	.4byte	.LVL1-1-.Ltext0
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL1-1-.Ltext0
	.4byte	.LFE3-.Ltext0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST2:
	.4byte	.LVL0-.Ltext0
	.4byte	.LVL1-1-.Ltext0
	.2byte	0x1
	.byte	0x56
	.4byte	.LVL1-1-.Ltext0
	.4byte	.LFE3-.Ltext0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x56
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST3:
	.4byte	.LVL0-.Ltext0
	.4byte	.LVL1-1-.Ltext0
	.2byte	0x1
	.byte	0x57
	.4byte	.LVL1-1-.Ltext0
	.4byte	.LFE3-.Ltext0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x57
	.byte	0x9f
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF0:
	.ascii	"unsigned int\000"
.LASF3:
	.ascii	"GNU C 4.9.2 -mel -march=m14kc -msoft-float -mplt -mips32"
	.ascii	"r2 -msynci -mabi=32 -g -O1\000"
.LASF2:
	.ascii	"main\000"
.LASF4:
	.ascii	"main.c\000"
.LASF5:
	.ascii	"F:\\Line drawing verilog_updated\\MIPSfpga2_line_drawing"
	.ascii	"\\software\000"
.LASF7:
	.ascii	"draw_line\000"
.LASF6:
	.ascii	"delay_slot\000"
.LASF1:
	.ascii	"long_delay\000"
	.ident	"GCC: (Codescape GNU Tools 2016.05-03 for MIPS MTI Bare Metal) 4.9.2"
