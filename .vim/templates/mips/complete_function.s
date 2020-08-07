:
		# save argument variables up to 4
		addi $sp,$sp,-4
		sw $a0,0($sp)
		
		addi $sp,$sp,-4
		sw $a1,$sp

		# save return address
		addi $sp,$sp,-4
		sw $ra,0($sp)

		# save save register up to 0-8
		addi $sp,$sp,-4
		sw $s0,0($sp)
		
		addi $sp,$sp,-4
		sw $s1,0($sp)

		# body


		# return save register
		lw $s0,0($sp)
		addi $sp,$sp,4
		
		lw $s1,0($sp)
		addi $sp,$sp,4

		# restore return address
		lw $ra,0($sp)
		addi $sp,$sp,4
		
		# restore argument variables
		#addi $sp,$sp,8
		lw $a0,0($sp)
		addi $sp,$sp,4

		lw $a0,0($sp)
		addi $sp,$sp,4

		jr $ra
