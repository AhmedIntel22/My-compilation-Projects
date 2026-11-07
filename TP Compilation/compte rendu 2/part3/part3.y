%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(char *s);
%}

%token FIN SOM PROD SUB DIV NB
%start liste

%%
liste: 
    FIN { return 0; }
    | SOM listesom '.' { printf("Somme = %d\n", $2); } liste
    | PROD listeprod '.' { printf("Produit = %d\n", $2); } liste
    | SUB listesub '.' { printf("Soustraction = %d\n", $2); } liste
    | DIV listediv '.' { printf("Division = %d\n", $2); } liste
    ;

listesom:
    NB { $$ = $1; }
    | listesom ',' NB { $$ = $1 + $3; }
    ;

listeprod:
    NB { $$ = $1; }
    | listeprod ',' NB { $$ = $1 * $3; }
    ;

listesub: 
    NB { $$ = $1; } 
    | listesub ',' NB { $$ = $1 - $3; } 
    ;

listediv: 
    NB { $$ = $1; } 
    | listediv ',' NB { 
        if ($3 == 0) { yyerror("Error: Division by zero!"); $$ = $1; }
        else { $$ = $1 / $3; }
    } 
    ;

%%
#include "lex.yy.c"

int yyerror(char *s) { printf("%s\n", s); return 0; }
int main() {
    yyparse();
    return 0;
}