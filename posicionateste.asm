.data
	input_text: .asciiz "Digite o seu texto: "
	input_row: .asciiz "Em qual linha deseja iniciar o seu texto?: "
	input_column: .asciiz "Em qual coluna deseja iniciar o seu texto?: "
	empty_space: .asciiz " "
	text: .space 60
	
	t4: .asciiz "$t4: "
	t5: .asciiz "$t5: "
	t6: .asciiz "$t6: "
	
	plus_sign: .asciiz "+"
	new_line: .asciiz "\n"
	
	#linha em $t0
	#coluna em $t1
	#length de texto em $t2
	
.text
	#Ler texto
	#-----------------------------------------------------------------------------------------------#
	
	#Imprimir "Digite o seu texto: "
	li $v0, 4
	la $a0, input_text
	syscall
	
	#Ler que foi digitado e coloca em texto com tamanho m�ximo de 60 caracteres
	li $v0, 8
	la $a0, text #puxa o texto da mem�ria tempor�ria para a principal
	la $a1, 60
	syscall
	
	
	#Ler linha
	#-----------------------------------------------------------------------------------------------#
	
	#Imprimir "Em qual linha deseja iniciar o seu texto?: "
	li $v0, 4
	la $a0, input_row #puxa o texto da mem�ria tempor�ria para a principal
	syscall
	
	#Ler linha que come�a
	li $v0, 5
	syscall
	move $t0, $v0 #colocar valor digitado em $t0
	
	
	#Ler coluna
	#-----------------------------------------------------------------------------------------------#
	
	#Imprimir "Em qual coluna deseja iniciar o seu texto?: "
	li $v0, 4
	la $a0, input_column #puxa o texto da mem�ria tempor�ria para a principal
	syscall
	
	#Ler coluna que come�a
	li $v0, 5
	syscall
	move $t1, $v0 #colocar valor digitado em $t1

	#Calcular length do texto
	#-----------------------------------------------------------------------------------------------#
	
	li $t2, 0
	la $a0, text
	
	count_characters:
		lb $t3, 0($a0)
		beq $t3, $zero, print_length
		
		addi $a0, $a0, 1
		addi $t2, $t2, 1
		
		j count_characters
		
	print_length:
	
		subi $t2, $t2, 1
		
		li $v0, 1
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0, new_line
		syscall
		
		
	#Ciclo para escrever cada linha
	#-----------------------------------------------------------------------------------------------#
	
	li $t4, 0 #linha
	li $t6, 60
	sub $t6, $t6, $t2
	sub $t6, $t6, $t1
	loop_rows:
	
		li $t5, 0 #coluna
	
		addi $t4, $t4, 1
		
		#Se for a primeira ou �ltima linha:
		beq $t4, 1, print_first_last
		beq $t4, 10, print_first_last
		
		#Se n�o for a primeira ou �ltima linha:
		beq $t4, $t0, print_content_uncomplete_row
		jal print_uncomplete_row
		
	print_first_last:
		
		beq $t4, $t0, print_content_complete_row
		j print_complete_row
	
	print_complete_row:	#print("+" * 60)
	
		li $v0, 4
		la $a0, plus_sign
		syscall
		
		addi $t5, $t5, 1
		
		ble $t5, 60, print_complete_row
		li $v0, 4
		la $a0, new_line
		syscall
		
		beq $t4, 10, finish_program
		j loop_rows
	
	
	print_content_complete_row:	#print("+" * (coluna - 1) + txt + "+" * (60 - tam - coluna) + "+")
		
		li $t5, 0 #zerar coluna
		
		
	
	print_uncomplete_row:	#print("+" + " " * 58 + "+")
	
		li $t5, 0 #zerar coluna
	
		li $v0, 4
		la $a0, plus_sign
		syscall
		
		print_spaces:	
			
			li $v0, 4
			la $a0, empty_space
			syscall
		
			addi $t5, $t5, 1
			
			ble $t5, 58, print_spaces
			
		li $v0, 4
		la $a0, plus_sign
		syscall
		
		
		li $v0, 4
		la $a0, new_line
		syscall
		
		j loop_rows
	
	print_content_uncomplete_row:	#print("+" + " " * (coluna - 2) + txt + " " * (60 - tam - coluna) + "+")
	
		li $t5, 0 #zerar coluna
	
		li $v0, 4
		la $a0, plus_sign
		syscall
		
		move $t6, $t1
		subi $t6, $t6, 3
		
			print_spaces_pre_content:	
			
				li $v0, 4
				la $a0, empty_space
				syscall
				
				addi $t5, $t5, 1
			
				ble $t5, $t6, print_spaces_pre_content
				
		#Imprimir text
		#-----------------------------------------------------------------------------------------------#
			
		li $v0, 4
		la $a0, text
		syscall
		
		#-----------------------------------------------------------------------------------------------#
		
		
		#Imprimir cada caractere de text
		#-----------------------------------------------------------------------------------------------#
		
		#la $a0, text
		#print_text:
		#	lb $t7, 0($a0) #PERGUNTAR AO PROFESSOR COMO RESOLVER O ERRO OU COMO IMPRIMIR A STRING SEM PULAR LINHA
		#	
		#	beq $t7, $zero, end_print_text
		#	move $a0, $t7
		#	li $v0, 11
		#	syscall
			
		#	addi $a0, $a0, 1
			
		#	j print_text
			
		#end_print_text:
		
		#-----------------------------------------------------------------------------------------------#
		
			li $t6, 60
			sub $t6, $t6, $t2
			sub $t6, $t6, $t1
		
				print_spaces_post_content:	
			

			
					ble $t5, 0, print_spaces_post_content
			

		
		
			j loop_rows

	finish_program:
		li $v0, 10
		syscall
