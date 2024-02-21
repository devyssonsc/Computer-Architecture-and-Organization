.data
    prompt:     .asciiz "Digite uma string: "
    output:     .asciiz "Voc� digitou: "
    buffer:     .space 50         # Buffer para armazenar a string
    teste : 	.asciiz "teste"

.text
    main:
        # Imprimir o prompt
        li $v0, 4               # C�digo da syscall para imprimir string
        la $a0, prompt          # Carrega o endere�o da string prompt
        syscall

        # Ler a string digitada pelo usu�rio
        li $v0, 8               # C�digo da syscall para ler string
        la $a0, buffer          # Endere�o do buffer para armazenar a string
        li $a1, 50              # Tamanho m�ximo da string
        syscall

        # Imprimir a mensagem de sa�da
        li $v0, 4               # C�digo da syscall para imprimir string
        la $a0, output          # Carrega o endere�o da string output
        syscall

        # Imprimir a string digitada pelo usu�rio
        li $v0, 4               # C�digo da syscall para imprimir string
        la $a0, buffer          # Carrega o endere�o da string digitada
        syscall
        
        li $v0, 4
        la $a0, teste
        syscall

        # Terminar o programa
        li $v0, 10              # C�digo da syscall para sair do programa
        syscall