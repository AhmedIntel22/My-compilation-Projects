binaire (0|1)+
autre .
%%
{autre} printf ("ce n'est pas un %s nombre binaire ", yytext);
{binaire} printf ("c'est un %s nombre binaire ", yytext);
%%
int yywrap(){return 1;}
int main(int argc, char *argv[])
{
yylex();
return 1;
}