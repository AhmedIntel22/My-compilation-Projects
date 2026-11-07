id [A-Za-z][A-Za-z0-9]*
nb [0-9]*
other .*

%%
{id} printf ("a valid ID\n");
{nb} printf ("c'est un entier\n");
{other} printf ("not an ID\n");
%%
int yywrap(){return 1;}
int main() {
yylex();
return 0;
}