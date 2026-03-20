.data
# VARIÁVEIS PARA SAÍDA DE DADOS
string100: .asciiz "Digite o número de cédulas 100: "
string10: .asciiz "Digite o número de cédulas 10: "
stringTotal: .asciiz "\nTotal disponível para saque: R$ "
stringNC: .asciiz "\nCédulas disponíveis: \n"
stringSemCedulas: .asciiz "\nNão há cédulas disponíveis para saque"

stringSaque: .asciiz "Digite o valor do saque (0 para encerrar): "
stringFinal: .asciiz "Você sacou: \n"
stringCem:.asciiz " x 100 \n"
stringDez:.asciiz " x 10 \n"
stringErro: .asciiz "Valor indisponível para saque.\n"

# REGISTRADORES UTILIZADOS
# saque = $s0
# c100 = $s1
# c10 = $s2
# total = $t0
# sc100 = $t1
# sc10 = $t2

.text
main:
# SOLICITA QUANTIDADE DE CÉDULAS DE 100
#Saída de dados
li $v0, 4
la $a0, string100
syscall
#Entrada de dados
li $v0, 5
syscall
#Salvamento de dados
move $s1, $v0

# SOLICITA QUANTIDADE DE CéDULAS DE 10
#Saída de dados
li $v0, 4
la $a0, string10
syscall
#Entrada de dados
li $v0, 5
syscall
#Salvamento de dados
move $s2, $v0

# VERIFICA SE HÁ CÉDULAS DISPONÍVEIS PARA SAQUE
Loop:
    bne $s1, $zero, modoOperacao
    bne $s2, $zero, modoOperacao
    
    # SE NÃO HÁ, APRESENTA MENSAGEM DE ERRO E FINALIZA O PROGRAMA
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

    # EXIBE VALOR TOTAL DISPONíVEL
    #saída de dados
    li $v0, 4
    la $a0, stringTotal
    syscall
    #saída de dados
    li $v0, 1
    move $a0, $t0
    syscall

    # EXIBE QUANTIDADE DE CÉDULAS DISPONÍVEIS
    #saida de dados
    li $v0, 4
    la $a0, stringNC
    syscall
    
    # CÉDULAS DE 100
    #saida de dados
    li $v0, 1
    move $a0, $s1
    syscall
    #saida de dados
    li $v0, 4
    la $a0, stringCem
    syscall
    
    # CÉDULAS DE 10
    #saida de dados
    li $v0, 1
    move $a0, $s2
    syscall
    #saida de dados
    li $v0, 4
    la $a0, stringDez
    syscall
    
    # PEDE VALOR DE SAQUE
    #saida de dados
    li $v0, 4
    la $a0, stringSaque
    syscall
    #Entrada de dados
    li $v0, 5
    syscall
    #Salvamento de dados
    move $s0, $v0
    
    # SE FOR =0, FINALIZA O PROGRAMA
    beq $s0, $zero, EndLoop
    
    # VARIÁVEIS PARA CÉDULAS SACADAS
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
    # VERIFICA SE TEM VALOR DISPONÍVEL PARA SAQUE
    beq $s0, $zero, cedulasSacadas
    
    # SE NÃO TEM, APRESENTA MENSAGEM DE ERRO
    #saida de dados
    li $v0, 4
    la $a0, stringErro
    syscall
    
    # DEVOLVE AS CÉDULAS RETIRADAS
    add $s1, $s1, $t1
    add $s2, $s2, $t2
    
    j Loop
    	
cedulasSacadas:
    # MOSTRA QUANTIDADE DE CÉDULAS SACADAS
    li $v0, 4
    la $a0, stringFinal
    syscall
    
    # VERIFICA SE FORAM SACADAS CÉDULAS DE 100
    beq $t1, $zero, verifica10
    
    #saida de dados
    li $v0, 1
    move $a0, $t1
    syscall
    #saida de dados
    li $v0, 4
    la $a0, stringCem
    syscall
    
    # VERIFICA SE FORAM SACADAS CÉDULAS DE 10
    verifica10:
    beq $t2, $zero, Loop
    
    #saida de dados
    li $v0, 1
    move $a0, $t2
    syscall
    #saida de dados
    li $v0, 4
    la $a0, stringDez
    syscall
   
    j Loop

# ENCERRA O PROGRAMA
EndLoop:
li $v0, 10
syscall