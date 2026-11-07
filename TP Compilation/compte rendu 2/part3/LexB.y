%{
#include <stdio.h>
int yylex(void);
int yyerror(char *s);
%}
%token NUMBER
%left '+' '-'
%left '*' '/'
%%
input:

    | input line
    ;

line:
      '\n'
    | E '$' { printf("Result = %d\n\n", $1); }
    | '$'   { return 0; }
    ;

E: E '+' E { $$ = $1 + $3; }
 | E '-' E { $$ = $1 - $3; }
 | E '*' E { $$ = $1 * $3; }
 | E '/' E { if($3 != 0) $$ = $1 / $3; else { yyerror("division by zero"); $$=0; } }
 | NUMBER { $$ = $1; }
 | '(' E ')' { $$ = $2; } ;
%%
#include "lex.yy.c"
int yyerror(char *s){
printf("%s\n", s);
return 0;
}
int main(){
yyparse();
return 0;
}