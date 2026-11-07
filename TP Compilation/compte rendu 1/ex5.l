car [0-9]{1,3}TUNIS[0-9]{1,4}#
other .*
%%
{car} printf ("This is a registered car\n");
{other} printf ("This is not a registered car\n");
%%
int yywrap(){return 1;}
int main() {
yylex();
return 0;
}