lui $1,4097
ori $1,$1,0
add $19,$0,$1
j jump1


jump2:
jr $31

jump1:
jal jump2

addi $1, $0, 0
addi  $1,  $0,  32         # Place “1” in $1 
addi $2, $0, 175
addi $3, $0, -3210

not  $4,  $1               # negate "1" and place into 2 ($2 is now -2)
slt  $5,  $1,  $2          # check if $1 is less than $2 and place into $3 ($3 is now 0)
add  $6,  $2,  $3          # Place “$1” in $3 ($3 is now 1) 
sll  $7,  $3,  4           # shift $3 left 4 times, place into $4 ($4 should now be 16)
sra $8, $1, 2              # Shift $4 right 2 and place into 4 ($4 should now be 4)
xor $9, $1, $2             # xor $3 and $4 and place into $5 ($5 should have the value 5)
sub $10, $2, $3             # subtract $4 from $5 ($6 should be -1)
sra $10, $1, 12             # shift right arithmetic $6 12 times ($6 should still be -1)
and $11, $2, $0              # and $6 with 0 and place into $7 ($7 should be 0)
add $12, $2, $3             # add the value of $5 and $7 into $8 ($8 should have value of 5)
add $12, $1, $3             # add $3 to $8 and store in $8 ($8 should have 6)
srl $13, $2, 1              # divide $8 by 2 and store in $9 ($9 should contain 3)
nor $14, $3, $1            # nor $8 and $9 ($10 should contain -8)
or  $15, $3, $2           # or $10 with $6 and store in $11 ($11 should be -1)
sll $15, $1, 3             # shift left 3 times ($11 should finished with a value of -8)
repl.qb $16, 29         #replicate 010000000 and place into $12.
addu $16, $3, $1 
addiu $17, $2, -2
andi $18, $1, 6
sw $1, 0($19)

lw $20, 0($19)
subu $21, $2, $3
lui $19, 12
xori $22, $1, 392
ori $23, $2, 123
slti $24, $3, 0
movn $25, $1, $2


equal:
beq $25, $25, end 

end:
bne $20, $21, done

done:
halt
