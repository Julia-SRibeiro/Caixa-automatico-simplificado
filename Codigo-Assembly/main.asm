.data
# VARIAVEIS PARA SAIDA DE DADOS
string100: .asciiz "Digite o numero de cedulas 100: "
string10: .asciiz "Digite o numero de cedulas 10: "
stringTotal: .asciiz "\nTotal disponivel para saque: R$ "
stringNC: .asciiz "\nCedulas disponiveis: \n"
stringSemCedulas: .asciiz "\nNao ha cedulas disponiveis para saque"

stringSaque: .asciiz "Digite o valor do saque (0 para encerrar): "
stringFinal: .asciiz "Voce sacou: \n"
stringCem:.asciiz " x 100 \n"
stringDez:.asciiz " x 10 \n"
stringErro: .asciiz "Valor indisponivel para saque.\n"

# REGISTRADORES UTILIZADOS
# saque = $s0
# c100 = $s1
# c10 = $s2
# total = $t0
# sc100 = $t1
# sc10 = $t2

.text
main:
# SOLICITA QUANTIDADE DE CEDULAS DE 100
#Saida de dados
li $v0, 4
la $a0, string100
syscall
#Entrada de dados
li $v0, 5
syscall
#Salvamento de dados
move $s1, $v0

# SOLICITA QUANTIDADE DE CEDULAS DE 10
#Saida de dados
li $v0, 4
la $a0, string10
syscall
#Entrada de dados
li $v0, 5
syscall
#Salvamento de dados
move $s2, $v0

# VERIFICA SE HA CEDULAS DISPONIVEIS PARA SAQUE
Loop:
    bne $s1, $zero, modoOperacao
    bne $s2, $zero, modoOperacao
    
    # SE NAO HA, APRESENTA MENSAGEM DE ERRO E FINALIZA O PROGRAMA
    #Saída de dados
    li $v0, 4
    la $a0, stringSemCedulas
    syscall    

    j EndLoop

modoOperacao:
    # CALCULA TOTAL DE 100
    li $t3, 100
    mul $t4, $s1, $t3

    # CALCULA TOTAL DE 10
    li $t5, 10
    mul $t6, $s2, $t5

    # CALCULA TOTAL
    add $t0, $t4, $t6

    # EXIBE VALOR TOTAL DISPONIVEL
    #Saida de dados
    li $v0, 4
    la $a0, stringTotal
    syscall
    #Saida de dados
    li $v0, 1
    move $a0, $t0
    syscall

    # EXIBE QUANTIDADE DE CEDULAS DISPONIVEIS
    #Saida de dados
    li $v0, 4
    la $a0, stringNC
    syscall
    
    # CEDULAS DE 100
    #Saida de dados
    li $v0, 1
    move $a0, $s1
    syscall
    #Saida de dados
    li $v0, 4
    la $a0, stringCem
    syscall
    
    # CEDULAS DE 10
    #Saida de dados
    li $v0, 1
    move $a0, $s2
    syscall
    #Saida de dados
    li $v0, 4
    la $a0, stringDez
    syscall
    
    # PEDE VALOR DE SAQUE
    #Saida de dados
    li $v0, 4
    la $a0, stringSaque
    syscall
    #Entrada de dados
    li $v0, 5
    syscall
    #Salvamento de dados
    move $s0, $v0
    
    # SE FOR = 0, FINALIZA O PROGRAMA
    beq $s0, $zero, EndLoop
    
    # VARIAVEIS PARA CEDULAS SACADAS
    li $t1, 0
    li $t2, 0
    
    # QUANTIDADE DE CEDULAS DE 100 SACADAS
    contador100:
        beq $s1, $zero, contador10
        blt $s0, 100, contador10

        addi $t1, $t1, 1
        addi $s1, $s1, -1
        addi $s0, $s0, -100
                
        j contador100

    # QUANTIDADE DE CEDULAS DE 10 SACADAS
    contador10:
        beq $s2, $zero, finalizaOperacao
        blt $s0, 10, finalizaOperacao
        
        addi $t2, $t2, 1
        addi $s2, $s2, -1
        addi $s0, $s0, -10
                
        j contador10
                
finalizaOperacao:
    # VERIFICA SE TEM VALOR DISPONIVEL PARA SAQUE
    beq $s0, $zero, cedulasSacadas
    
    # SE NAO TEM, APRESENTA MENSAGEM DE ERRO
    #saida de dados
    li $v0, 4
    la $a0, stringErro
    syscall
    
    # DEVOLVE AS CEDULAS RETIRADAS
    add $s1, $s1, $t1
    add $s2, $s2, $t2
    
    j Loop
    	
cedulasSacadas:
    # MOSTRA QUANTIDADE DE CEDULAS SACADAS
    li $v0, 4
    la $a0, stringFinal
    syscall
    
    # VERIFICA SE FORAM SACADAS CEDULAS DE 100
    beq $t1, $zero, verifica10
    
    #Saida de dados
    li $v0, 1
    move $a0, $t1
    syscall
    #Saida de dados
    li $v0, 4
    la $a0, stringCem
    syscall
    
    # VERIFICA SE FORAM SACADAS CEDULAS DE 10
    verifica10:
    beq $t2, $zero, Loop
    
    #Saida de dados
    li $v0, 1
    move $a0, $t2
    syscall
    #Saida de dados
    li $v0, 4
    la $a0, stringDez
    syscall
   
    j Loop

# ENCERRA O PROGRAMA
EndLoop:
li $v0, 10
syscall
