.data
	input_text: .asciiz "Digite um texto: "
	input_row: .asciiz "Em qual linha deseja iniciar o seu texto?: "
	input_column: .asciiz "Em qual coluna deseja iniciar o seu texto?: "
	input_validate: .asciiz "Numero invalido! digite outro: "
	empty_space: .asciiz " "
	text: .space 60
	
	t4: .asciiz "$t4: "
	t5: .asciiz "$t5: "
	
	plus_sign: .asciiz "+"
	new_line: .asciiz "\n"
	
	#linha em $t0
	#coluna em $t1
	#length de texto em $t2
	
.text
	#Ler texto
	#-----------------------------------------------------------------------------------------------#
read_text:
	#Imprimir "Digite o seu texto: "
	li $v0, 4
	la $a0, input_text
	syscall
	
	#Ler o que foi digitado e coloca em texto com tamanho máximo de 60 caracteres
	li $v0, 8
	la $a0, text #puxa o texto da memória temporária para a principal
	la $a1, 60
	syscall
	

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
		beq $t2, $zero, read_text
		
		li $v0, 1
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0, new_line
		syscall
	
	
	#Ler linha
	#-----------------------------------------------------------------------------------------------#

read_row:
	#Imprimir "Em qual linha deseja iniciar o seu texto?: "
	li $v0, 4
	la $a0, input_row #puxa o texto da memória temporária para a principal
	syscall
	
	#Ler linha que começa
	li $v0, 5
	syscall
	move $t0, $v0 #colocar valor digitado em $t0
	beqz $t0, validate_row #validar o valor digitado, não pode ser 0
	bgt $t0, 10, validate_row
	
	
	#Ler coluna
	#-----------------------------------------------------------------------------------------------#
read_column:
	#Imprimir "Em qual coluna deseja iniciar o seu texto?: "
	li $v0, 4
	la $a0, input_column #puxa o texto da memória temporária para a principal
	syscall
	
	#Ler coluna que começa
	li $v0, 5
	syscall

	move $t1, $v0 #colocar valor digitado em $t1
	beqz $t1, validate_column #validar o valor digitado
	bgt $t1, 59, validate_column	
		
	#Ciclo para escrever cada linha
	#-----------------------------------------------------------------------------------------------#
	
	li $t4, 0 #linha
	
	posiciona: #loop principal para imprimir o retângulo
	
		li $t5, 0 #coluna
	
		addi $t4, $t4, 1
		
		#Se for a primeira ou última linha:
		beq $t4, 1, print_first_last
		beq $t4, 10, print_first_last
		
		#Se não for a primeira ou última linha:
		beq $t4, $t0, print_content_uncomplete_row
		j print_uncomplete_row
		
	print_first_last:
		
		beq $t4, $t0, print_content_complete_row
		j print_complete_row
	
	print_complete_row:	#print("+" * 60)
	
		li $v0, 4
		la $a0, plus_sign
		syscall
		
		addi $t5, $t5, 1
		
		blt $t5, 60, print_complete_row
		li $v0, 4
		la $a0, new_line
		syscall
		
		beq $t4, 10, finish_program
		j posiciona
	
	
	print_content_complete_row:	#print("+" * (coluna - 1) + txt + "+" * (60 - tam - coluna) + "+")
		
		li $t5, 0 #zerar coluna
		
		move $t6, $t1		#$t6 recebe coluna desejada ($t1)
		subi $t6, $t6, 2
		
		print_plus_pre_content:
			li $v0, 4
			la $a0, plus_sign
			syscall
			
			addi $t5, $t5, 1
			
			ble $t5, $t6, print_plus_pre_content
			
		#Imprimir text
		#-----------------------------------------------------------------------------------------------#
		la $s0, text
		li $s1, 1
		j print_text_complete_row
		#-----------------------------------------------------------------------------------------------#
		
		print_text_complete_row:
			lb $a0, 0($s0)
   			addi $s0, $s0, 1
   			addi $s1, $s1, 1
   			
   			li $v0, 11
   			syscall	
   			
   			ble $s1, $t2, print_text_complete_row
		
		li $t6, 60
		sub $t6, $t6, $t2
		sub $t6, $t6, $t1
			
		li $t5, 0 #zerar coluna
		
			print_plus_post_content:	
			
				li $v0, 4
				la $a0, plus_sign
				syscall
		
				addi $t5, $t5, 1
			
				blt $t5, $t6, print_plus_post_content
				
		li $v0, 4
		la $a0, new_line
		syscall
		
		beq $t4, 10, finish_program
		j posiciona
	
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
			
			blt $t5, 58, print_spaces
			
		li $v0, 4
		la $a0, plus_sign
		syscall
		
		
		li $v0, 4
		la $a0, new_line
		syscall
		
		j posiciona
	
	print_content_uncomplete_row:	#print("+" + " " * (coluna - 2) + txt + " " * (60 - tam - coluna) + "+")
	
		li $t5, 0 #zerar coluna
	
		li $v0, 4
		la $a0, plus_sign
		syscall
		
		move $t6, $t1		#$t6 recebe coluna desejada ($t1)
		subi $t6, $t6, 3	# | $t6 = $t6 - 3 (-1 pq é o primeiro +
					# | -1 pq a primeira letra precisa está na posição desejada 
					# | E -1 pq o addi é feito antes da condição)
		
			print_spaces_pre_content:	
			
				li $v0, 4
				la $a0, empty_space
				syscall
				
				addi $t5, $t5, 1
			
				ble $t5, $t6, print_spaces_pre_content
		
						
		#Imprimir text
		#-----------------------------------------------------------------------------------------------#
		li $t6, 60  #variavel para limitar o print do texto
		sub $t6, $t6, $t1
		
		la $s0, text
		li $s1, 1
		j print_text_uncomplete_row	
		#-----------------------------------------------------------------------------------------------#
		
		
		print_text_uncomplete_row:
			
			lb $a0, 0($s0)
   			addi $s0, $s0, 1
   			addi $s1, $s1, 1
   			
   			li $v0, 11
   			syscall
   			subi $t6, $t6, 1	
   			beq $t6, 0, row_ending #se o caractere já estiver na posição 59, terminar a linha
   			ble $s1, $t2, print_text_uncomplete_row 	 

                 	
		
		
		
		li $t5, 0 #zerar coluna
		
			print_spaces_post_content:
			
				li $v0, 4
				la $a0, empty_space
				syscall
		
				addi $t5, $t5, 1
			
				blt $t5, $t6, print_spaces_post_content #Enquanto contador for menor que 60 - tam - coluna 
			
		row_ending:
		li $v0, 4
		la $a0, plus_sign
		syscall
		
		
		li $v0, 4
		la $a0, new_line
		syscall
		
		j posiciona
		
		validate_column:
			li $v0, 4
			la $a0, input_validate #pedir pra escrever outro numero
			syscall
			
			li $v0, 5 #ler o novo numero
			syscall
			move $t1, $v0 #colocar valor digitado em $t1
			
			beqz $t1, validate_column # se numero for igual a 0, validar novamente
			bgt $t1, 59, validate_column # se numero for maior que 59, validar novamente
			
			li $t4, 0 #linha
			j posiciona
	
		validate_row:
			li $v0, 4
			la $a0, input_validate #pedir pra escrever outro numero
			syscall
			
			li $v0, 5 #ler o novo numero
			syscall
			move $t0, $v0 #colocar valor digitado em $t1
			
			beqz $t0, validate_row # se numero for igual a 0, validar novamente
			bgt $t0, 10, validate_row # se numero for maior que 10, validar novamente
			
			
			j read_column
	
	finish_program:
		li $v0, 10
		syscall
