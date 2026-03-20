#include <stdio.h>

int main() {
    int c200, c100, c50, c20, c10, c5, c2;
    int sc200, sc100, sc50, sc20, sc10, sc5, sc2;
    int total, saque;

    // Solicita quantidade de cedulas
    printf("Digite o número de cedulas de 200: ");
    scanf("%i", &c200);
    printf("Digite o número de cedulas de 100: ");
    scanf("%i", &c100);
    printf("Digite o número de cedulas de 50: ");
    scanf("%i", &c50);
    printf("Digite o número de cedulas de 20: ");
    scanf("%i", &c20);
    printf("Digite o número de cedulas de 10: ");
    scanf("%i", &c10);
    printf("Digite o número de cedulas de 5: ");
    scanf("%i", &c5);
    printf("Digite o número de cedulas de 2: ");
    scanf("%i", &c2);

    // Verifica se ha cedulas disponiveis para saque
    while (c200 > 0 || c100 > 0 || c50 > 0 || c20 > 0 || c10 > 0 || c5 > 0 || c2 > 0) {
        
        // Exibe valor total disponivel
        total = c200*200 + c100*100 + c50*50 + c20*20 + c10*10 + c5*5 + c2*2;
        printf("\nTotal disponivel para saque: R$ %d\n", total);
        
        // Exibe quantidade de cedulas disponiveis
        printf("Cedulas disponiveis:\n");
        if (c200) printf("%d x 200\n", c200);
        if (c100) printf("%d x 100\n", c100);
        if (c50)  printf("%d x 50\n", c50);
        if (c20)  printf("%d x 20\n", c20);
        if (c10)  printf("%d x 10\n", c10);
        if (c5)   printf("%d x 5\n", c5);
        if (c2)   printf("%d x 2\n", c2);
        
        printf("\nDigite o valor do saque: ");
        scanf("%i", &saque);
        
        if (saque == 0) break;
        
        // Variaveis para cedulas sacadas
        sc200 = sc100 = sc50 = sc20 = sc10 = sc5 = sc2 = 0;
        
        // Conta quantas cedulas de cada serao sacadas
        while (saque >= 200 && c200 > 0){
            sc200++; 
            c200--; 
            saque -= 200; 
        }
        while (saque >= 100 && c100 > 0){
            sc100++; 
            c100--; 
            saque -= 100;
        }
        while (saque >= 50 && c50 > 0){
            sc50++;  
            c50--;  
            saque -= 50;  
        }
        while (saque >= 20 && c20 > 0){
            sc20++;  
            c20--;  
            saque -= 20;
        }
        while (saque >= 10 && c10 > 0){
            sc10++;  
            c10--;  
            saque -= 10;
        }
        while (saque >= 5 && c5 > 0){
            sc5++;   
            c5--;   
            saque -= 5;
        }
        while (saque >= 2 && c2 > 0){
            sc2++;
            c2--;   
            saque -= 2;
        }
        
        // Verifica se tem o valor disponivel para saque
        if (saque == 0) {
            // Exibe quantidade de cedulas sacadas
            printf("Voce sacou: \n");
            if (sc200) printf("%d x 200\n", sc200);
            if (sc100) printf("%d x 100\n", sc100);
            if (sc50)  printf("%d x 50\n", sc50);
            if (sc20)  printf("%d x 20\n", sc20);
            if (sc10)  printf("%d x 10\n", sc10);
            if (sc5)   printf("%d x 5\n", sc5);
            if (sc2)   printf("%d x 2\n", sc2);
        } else {
            printf("Valor indisponivel para saque. Cedulas insuficientes.\n");
            
            // Devolve as cedulas retiradas
            c200 += sc200;
            c100 += sc100;
            c50 += sc50;
            c20 += sc20;
            c10 += sc10;
            c5 += sc5;
            c2 += sc2;
        }
    }

    printf("\nNao ha cedulas disponiveis para saque.\n");
    return 0;
}