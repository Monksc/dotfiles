:
		# save return address
		addi $sp,$sp,-4
		sw $ra,0($sp)

		# save save register up to 0-8
		addi $sp,$sp,-16
		sw $s0,12($sp)
		sw $s1,8($sp)
		sw $s2,4($sp)
		sw $s3,0($sp)
	
		# save argument variables
		move $s0,$a0
		move $s1,$a1

		# body


		# return save register
		lw $s0,12($sp)
		lw $s1,8($sp)
		lw $s2,4($sp)
		lw $s3,0($sp)
		addi $sp,$sp,16

		# restore return address
		lw $ra,0($sp)
		addi $sp,$sp,4

		jr $ra
