%{
int nbL;
%}

ligne "\n"
autre .*

chiffre [0-9]
nb ({chiffre})*
test {chiffre}{1,3}

%%
{ligne} {printf("this is a return to the line");nbL= nbL+1;};
{nb} printf("<this is an %s number entier>",yytext);
{test} printf("this is an %s numbre compose de 1,2 ou 3 chiffre>",yytext);
{autre} printf("<this is an %s other de longueur>\n", yytext);
%%

int yywrap() { return 1; }
int main()
{
    yylex();
    printf("the number of lines is %d\n", nbL);
    return 0;
}