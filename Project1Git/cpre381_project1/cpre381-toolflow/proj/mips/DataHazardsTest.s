

addi $t0, $0, 255
xori $t1, $t0, 255

addi $t2, $0, 357 
add $t3, $0, $t2 
addi $t4, $t3, 6000

sub $t5, $0, 127 
addi $t5, $t4, 255 
andi $t6, $t5, 255 

add $t7, $0, 127 
add $t7, $0, $t6
andi $t0, $7, 47524
addi $t1, $t0, 255
add $t2, $0, $t1 

halt
