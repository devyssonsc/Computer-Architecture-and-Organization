txt = input("Qual o seu texto?")

linha = int(input("Em qual linha deseja que a sua palavra inicie?"))

coluna = int(input("Em qual coluna deseja que a sua palavra inicie?"))

tam = len(txt)

print(tam)

print(linha)
for l in range(10):
    if l == 0 or l == 9:
        print("+" * 60)
    elif l == linha-1:
        print("+"+" " * (coluna-2)+txt+" " * (60-tam-coluna)+"+")
    else:
        print("+" + " " *58 + "+")