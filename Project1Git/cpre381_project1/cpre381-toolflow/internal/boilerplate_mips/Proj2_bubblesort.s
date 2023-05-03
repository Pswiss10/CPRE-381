.data
#prompt: .asciiz   "Enter Integers: "  # user input
#.align 2
#NextData: .asciiz  "Do you want to continue, 1 for yes, 0 for no\n" 
#.align 2
newLine: .asciiz "\n"                # Newline character
.align 2
numbers: .word    7 3 1 46 24 10 5 34 100 99              # A ten character string initially filled with whitespace

.text 

main:

   # la $a0, prompt  
  #  li $v0, 4     
   # syscall    

    #la $s0,numbers
    lui $1,4097
nop
nop
nop
nop
    ori $16,$1,4
   # add $t1, $0, $0    #length of array
    addi $t1, $0, 10
nop
nop
nop
    add $t2, $0, $s0    #Offset for Numbers array   

   # jal gather 
nop
nop
nop       
    jal sort
nop
nop
nop
nop
   # addi $t1, $t1, 1
    #jal print
    j exit

#gather:

  #  li $v0, 5
   # syscall

    #add $t3, $0, $v0
   # sw $t3, 0($t2)
   # addi $t2, $t2, 4
   # addi $t1, $t1, 1


  #  la $a0, NextData 
  #  li $v0, 4     
  #  syscall 
    
  #  li $v0, 5
  #  syscall
    
  # bne $v0, $0, gather
  #  j done

sort:   
nop
nop
nop
nop
    add $t0,$zero,$zero 
nop
nop
nop
    addi $t1, $t1, -1
    nop
    nop
nop
nop
    
    loop:
nop
nop
nop
nop
        beq $t0,$t1,done
        nop
        nop
        nop
        add $t4,$zero,$zero
        nop
        nop
        nop
        
        innerLoop:
        	
nop
nop
nop
nop
        	beq $t4, $t1, continue
        	nop
        	nop
		nop
		nop
        	sll $t5, $t4, 2
        	nop
        	nop
        	nop
		nop
        	add $t6, $s0, $t5
        	nop
        	nop
        	nop
        	nop
        	
        	lw $s1, 0($t6)
        	lw $s2, 4($t6)
        	nop
        	nop
nop
nop

		slt $t7, $s2, $s1
		nop
		nop
		nop
		nop
		beq $t7, $0, good
		nop
		nop
nop
nop
		
		sw $s2, 0($t6)
		sw $s1, 4($t6)
nop
nop
nop
nop
		
		good:
nop
nop
nop
nop
			addi $t4, $t4, 1
			nop
			nop
			nop
			nop
			j innerLoop
			nop
nop
nop
nop
		
	continue:
nop
nop
nop
nop
		addi $t0, $t0, 1
nop
nop
nop
nop
		j loop
nop
nop
nop
nop        

print:

    #la $a0,newLine
 #   li $v0,4
  #  syscall 

 #   add $t6,$zero,$zero
  #  add $t7, $0, $0
 #   nop
 #   nop
  #  nop
    
    
#    loopPrint:
#        beq $t6,$t1,done  
#nop 
#nop
#nop
#nop
 #       sll $t7, $t6, 2
  #      nop
  #      nop
  #      nop
#        nop
 #       add $t2,$s0,$t7
  #      nop
   #     nop
    #    nop
     #   nop
      #  nop
       # lw $a0, 0($t2) 
      #  li $v0, 1     
      #  syscall      
    
        #addi $t6,$t6,1 
#nop
#nop
#nop
#nop 
 #       j loopPrint


done:
    jr $ra
exit:
	halt
