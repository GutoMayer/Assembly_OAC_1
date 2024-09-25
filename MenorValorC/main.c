#include <stdio.h>
#include <stdlib.h>

int main()
{
    #include <stdio.h>
#include <stdlib.h>
// Função que busca o indice do menor valor dentro de um vetor
int encontraMenorValor(){
float v[] = {1.01,2.24,3.36,0.9,6.26,0.95};
int n = 6;
int k = 1;
int i;
float menorValor = v[k];
int menorIndice = k;
for(i = k; i<=n; i++){
if(menorValor > v[i]) {
menorValor = v[i];
}
else{
continue;
}
menorIndice = i;
}
return menorIndice;
}
int main()
{
printf(" Indice: %i\n", encontraMenorValor());

return 0;
}
