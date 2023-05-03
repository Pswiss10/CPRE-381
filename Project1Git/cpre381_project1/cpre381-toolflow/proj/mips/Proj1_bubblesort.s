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

    la $s0,numbers
   # add $t1, $0, $0    #length of array
    addi $t1, $0, 10
    add $t2, $0, $s0    #Offset for Numbers array   

   # jal gather        
    jal sort
    addi $t1, $t1, 1
   # jal print
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

    add $t0,$zero,$zero 
    addi $t1, $t1, -1
    loop:

        beq $t0,$t1,done
        
        add $t4,$zero,$zero
        
        innerLoop:
        	
        	beq $t4, $t1, continue
        	sll $t5, $t4, 2
        	add $t6, $s0, $t5
        	
        	lw $s1, 0($t6)
        	lw $s2, 4($t6)

		slt $t7, $s2, $s1
		
		beq $t7, $0, good
		
		sw $s2, 0($t6)
		sw $s1, 4($t6)
		
		good:
			addi $t4, $t4, 1
			j innerLoop
		
	continue:
		addi $t0, $t0, 1
		j loop        

print:

    #la $a0,newLine
 #   li $v0,4
  #  syscall 

    add $t6,$zero,$zero
    add $t7, $0, $0
    
    loopPrint:
        beq $t6,$t1,done  
        sll $t7, $t6, 2
        add $t2,$s0,$t7
        lw $a0, 0($t2) 
      #  li $v0, 1     
      #  syscall      
    
        addi $t6,$t6,1  
        j loopPrint


done:
    jr $ra
exit:
	halt
