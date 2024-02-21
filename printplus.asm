.data
	plus: .asciiz "+"
	new_line: .asciiz "\n"
	
.text
	
	li $t5, 0
	
	loop:
		li $v0, 4
		la $a0, plus
		syscall
		
		addi $t5, $t5, 1
		
		blt $t5, 60, loop
		li $v0, 4
		la $a0, new_line
		syscall
		
		li $v0, 4
		la $a0, plus
		syscall