%{
#include <stdio.h>
#include <stdlib.h>
#include "part3.tab.h"
%}
%%
[0-9]+          { yylval = atoi(yytext); return NB; }
"somme"         { return SOM; }
"produit"       { return PROD; }
"soustraction"  { return SUB; }
"division"      { return DIV; }
","                            { return ','; }
"."             { return '.'; }
"$"             { return FIN; }
[ \t\n]+        { ; }
.                               { printf("Error: %s\n", yytext); }
%%
int yywrap() {
return 1;
}