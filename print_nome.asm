.data
    prompt: .asciiz "Digite seu nome: "
    greeting_prefix: .asciiz ""
    greeting_suffix: .asciiz "! Olá"
    user_input: .space 50
    newline: .asciiz "\n"

.text
    # Perguntar ao usuário o nome
    li $v0, 4
    la $a0, prompt
    syscall

    # Ler o nome do usuário
    li $v0, 8
    la $a0, user_input
    li $a1, 50  # Tamanho máximo da string
    syscall

    # Imprimir a saudação completa em uma única linha
    li $v0, 4
    la $a0, greeting_prefix
    syscall

    li $v0, 4
    la $a0, user_input
    syscall

    li $v0, 4
    la $a0, greeting_suffix
    syscall

    li $v0, 4
    la $a0, newline  # Adiciona uma nova linha no final
    syscall

    # Terminar o programa
    li $v0, 10
    syscall
