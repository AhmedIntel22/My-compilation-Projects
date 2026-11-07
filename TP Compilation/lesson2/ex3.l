slashtoile "/*"
autre .*
%%
{slashtoile} printf("<this is an %s SE de longeur, %d>",yytext, yyleng);
"*/" printf("<ASE>");
"\\n" printf("<ASN>");
"("|"["|"{" printf ("<P0>");
")"|"]"|"}" printf ("<PF>");
"?"+ printf(" <?, %d>",yyleng);
{autre} printf("<this is an %s other de longeur, %d>",yytext, yyleng);
%%
int yywrap(){
return 1;
}
int main() {
yylex() ;
return 0;
}