.data
	string: .asciiz "Olá, mundo!"
	
.text
	# Endereço da string
la $t0, string

# Contador
li $t1, 0

# Loop principal
loop:

  # Carregar o caractere atual da string
  lb $v0, 0($t0)

  # Chamar a função `syscall` para imprimir o caractere
  syscall

  # Incrementar o contador
  addi $t1, $t1, 1

  # Verificar se o contador é menor que o comprimento da string
  bltu $t1, len, loop

# Fim do programa