%{
#include "LexB.tab.h"
#include <stdlib.h>
%}
%%
[0-9]+   { yylval = atoi(yytext); return NUMBER; }
"+"      { return '+'; }
"-"      { return '-'; }
"*"      { return '*'; }
"/"      { return '/'; }
"("      { return '('; }
")"      { return ')'; }
"$"      { return '$'; }
[ \t\n]+ ; 
.        { printf("Lexical Error\n"); }
%%
int yywrap(){
return 1;
}