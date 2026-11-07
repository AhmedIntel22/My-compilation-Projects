%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(char *);
%}
%%
mot : S '$' { printf("correct word\n"); };

S : '(' S ')'
  | '(' ')'
  | S '(' S ')'
  ;

%%

int yylex(){
    char c = getchar();
    if (c == EOF)
        return 0;
    while (c == ' ' || c == '\n'){
        c = getchar();
        if (c == EOF)
            return 0;
    }
    if (c == '(' || c == ')' || c == '$')
        return c;
    return c;
}

int yyerror(char *s){
    int c;
    printf("incorrect word\n");
    while ((c = getchar()) != '\n' && c != EOF);
    return 0;
}

int main(){
    while (!feof(stdin)){
        yyparse();
    }
    return 0;
}