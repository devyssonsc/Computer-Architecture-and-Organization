.data
    my_string: .asciiz "devysson"

.text
    # Inicializar registradores
    li $t0, 0        # Registrador para contar o tamanho da string (inicializado em 0)
    la $a0, my_string # Carregar o endere�o da string em $a0

    # Loop para percorrer a string
    count_loop:
        lb $t1, 0($a0)  # Carregar o caractere atual da string em $t1
        beq $t1, $zero, end_count_loop # Se o caractere for nulo, sair do loop
        addi $a0, $a0, 1  # Avan�ar para o pr�ximo caractere da string
        addi $t0, $t0, 1  # Incrementar o contador
        j count_loop      # Repetir o loop

    # Sair do loop
    end_count_loop:
    
    # O tamanho da string est� agora em $t0
    # Voc� pode usar $t0 conforme necess�rio
