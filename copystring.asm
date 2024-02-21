.data
	mensagem: 	.asciiz "Informe uma string(até 60caracteres): "
	string: 	.space 60
	mensagemSaida: 	.asciiz " é a cópia da sua string"
	nada:		.asciiz " "
	
.text
	li $v0, 4
	la $a0, mensagem
	syscall
	
	li $v0, 8
	la $a0, string
	la $a1, 60
	syscall
	move $a1, $a0
	
	la $a0, nada
	
	jal strcpy
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, mensagemSaida
	syscall
	
	li $v0, 10
	syscall
	
	strcpy:
		sub $sp, $sp, 4
		sw $s0, 0($sp)
		add $s0, $zero, $zero
		L1:
			add $t1, $a1, $s0
			lb $t2, 0($t1)
			add $t3, $a0, $s0
			sb $t2, 0($t3)
			beq $t2, $zero, L2
			add $s0, $s0, 1
			j L1
			
		L2:
			lw $s0, 0($sp)
			add $sp, $sp, 4
			jr $ra