.data
	input_string: .asciiz "Digite o seu texto: "
	input_column: .asciiz "Em qual coluna deseja que o seu texto inicie?: "
	input_row: .asciiz "Em qual linha deseja que o seu texto inicie?: "

.text
	li $v0 , 4
	la $a0, input_string
	syscall
	
	li $v0, 10
	syscall
	