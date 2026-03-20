''' Solicita quantidade de cedulas '''
c200 = int(input("Digite o numero de cedulas de 200: "))
c100 = int(input("Digite o numero de cedulas de 100: "))
c50 = int(input("Digite o numero de cedulas de 50: "))
c20 = int(input("Digite o numero de cedulas de 20: "))
c10 = int(input("Digite o numero de cedulas de 10: "))
c5 = int(input("Digite o numero de cedulas de 5: "))
c2 = int(input("Digite o numero de cedulas de 2: "))

''' Verifica se ha cedulas disponiveis para saque '''
while c200 > 0 or c100 > 0 or c50 > 0 or c20 > 0 or c10 > 0 or c5 > 0 or c2 > 0:
    
    
    ''' Exibe valor total disponivel '''
    total = c200*200 + c100*100 + c50*50 + c20*20 + c10*10 + c5*5 + c2*2
    print("\nTotal disponivel para saque: R$", total)
    
    ''' Exibe quantidade de cedulas disponiveis '''
    print("Cedulas disponiveis:")
    if c200 != 0: print(f"{c200} x 200")
    if c100 != 0: print(f"{c100} x 100")
    if c50 != 0: print(f"{c50} x 50")
    if c20 != 0: print(f"{c20} x 20")
    if c10 != 0: print(f"{c10} x 10")
    if c5 != 0: print(f"{c5} x 5")
    if c2 != 0: print(f"{c2} x 2")
    
    saque = int(input("Digite o valor do saque (0 para encerrar): "))
    
    if saque == 0: break
    
    ''' Variaveis para cedulas sacadas '''
    sc200 = sc100 = sc50 = sc20 = sc10 = sc5 = sc2 = 0

    ''' Conta quantas cedulas de cada serao sacadas '''
    while c200 != 0 and saque >= 200:
        sc200 += 1
        c200 -= 1
        saque -= 200
    while c100 != 0 and saque >= 100:
        sc100 += 1
        c100 -= 1
        saque -= 100
    while c50 != 0 and saque >= 50:
        sc50 += 1
        c50 -= 1
        saque -= 50
    while c20 != 0 and saque >= 20:
        sc20 += 1
        c20 -= 1
        saque -= 20
    while c10 != 0 and saque >= 10:
        sc10 += 1
        c10 -= 1
        saque -= 10
    while c5 != 0 and saque >= 5:
        sc5 += 1
        c5 -= 1
        saque -= 5
    while c2 != 0 and saque >= 2:
        sc2 += 1
        c2 -= 1
        saque -= 2
        
    ''' Verifica se tem o valor disponivel para saque '''
    if saque == 0:
        ''' Exibe quantidade de cedulas sacadas '''
        print("Voce sacou: \n")
        if sc200 != 0: print(f"{sc200} x 200")
        if sc100 != 0: print(f"{sc100} x 100")
        if sc50 != 0: print(f"{sc50} x 50")
        if sc20 != 0: print(f"{sc20} x 20")
        if sc10 != 0: print(f"{sc10} x 10")
        if sc5 != 0: print(f"{sc5} x 5")
        if sc2 != 0: print(f"{sc2} x 2")
    else:
        print("Valor indisponivel para saque. Cedulas insuficientes")
        
        ''' Devolve as cedulas retiradas '''
        c200 += sc200
        c100 += sc100
        c50  += sc50
        c20  += sc20
        c10  += sc10
        c5   += sc5
        c2   += sc2
        
print("\nNao ha cedulas disponiveis para saque.")