		li <COUNTER_VAR>,0
.<FNAME>toploop<ID>:
		slt $t0,<COUNTER_VAR>,<LENGTH>
		beq $t0,$0,.<FNAME>botloop<ID>
		
		# TODO For Loop Body
		
		addi <COUNTER_VAR>,<COUNTER_VAR>,1
		j .<FNAME>toploop<ID>
.<FNAME>botloop<ID>:
