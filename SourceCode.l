%{
#include <stdio.h>
%}
%option noyywrap
%%

[ \t]+               
[01]+               { printf("NUMERO BINARIO: %s\n", yytext); }
[+-/*]              { printf("OPERADOR ARITMETICO: %s\n", yytext); }
or|and|xor|not      { printf("OPERADOR BOOLEANO: %s\n", yytext); }
[(]                 { printf("PARENTESIS ABRE\n"); }
[)]                 { printf("PARENTESIS CIERRA\n"); }
.                   { printf("ERROR LEXICO!!: %s\n", yytext); }

%%

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Error: archivo de entrada no especificado.\n");
        return 1;
    }
    FILE* archivo_entrada = fopen(argv[1], "r");
    if (!archivo_entrada) {
        printf("Error: no se pudo abrir el archivo de entrada.\n");
        return 1;
    }
    yyin = archivo_entrada;

    FILE* archivo_salida = fopen("salida.txt", "w");
    if (!archivo_salida) {
        printf("Error: no se pudo crear el archivo de salida.\n");
        return 1;
    }
    yyout = archivo_salida;

    yylex();

    fclose(archivo_entrada);
    fclose(archivo_salida);

    return 0;
}
