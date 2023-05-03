

addi $t0, $0, 1
addi $t1, $0, 2
addi $t2, $0, 1

	beq $t0, $t2, beq1
	addi $t3, $0, 0
beq1:	addi $t3, $0, 1

bne $t0, $t1, bne1
	addi $t4, $0, 0
bne1:	addi $t4, $0, 1

	jal jal1
	addi $t6, $0, 1
	j jal2
jal1: addi $t5, $0, 1
	jr $ra
jal2: addi $t7, $0, 1

andi $t3, $t3, 0
andi $t4, $t4, 0
andi $t5, $t5, 0
andi $t6, $t6, 0
andi $t7, $t7, 0

	beq $t0, $t2, beq2
	ori $t3, $0, 1
beq2:	bne $t0, $t1, bne2
	ori $t3, $0, 2
bne2:	jal jal3
	ori $t3, $0, 3
	j jal4
jal3: ori $t3, $0, 4
	jr $ra
jal4: ori $t3, $0, 5



halt
