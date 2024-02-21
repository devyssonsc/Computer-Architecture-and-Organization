.data
    prompt:     .asciiz "Digite uma string: "
    output:     .asciiz "Você digitou: "
    buffer:     .space 50         # Buffer para armazenar a string
    teste : 	.asciiz "teste"

.text
    main:
        # Imprimir o prompt
        li $v0, 4               # Código da syscall para imprimir string
        la $a0, prompt          # Carrega o endereço da string prompt
        syscall

        # Ler a string digitada pelo usuário
        li $v0, 8               # Código da syscall para ler string
        la $a0, buffer          # Endereço do buffer para armazenar a string
        li $a1, 50              # Tamanho máximo da string
        syscall

        # Imprimir a mensagem de saída
        li $v0, 4               # Código da syscall para imprimir string
        la $a0, output          # Carrega o endereço da string output
        syscall

        # Imprimir a string digitada pelo usuário
        li $v0, 4               # Código da syscall para imprimir string
        la $a0, buffer          # Carrega o endereço da string digitada
        syscall
        
        li $v0, 4
        la $a0, teste
        syscall

        # Terminar o programa
        li $v0, 10              # Código da syscall para sair do programa
        syscall