%%

"/*" printf("<SE>");
"*/" printf("<ASE>");
"\\n" printf("<ASN>");
"("|"["|"{" printf ("<P0>");
")"|"]"|"}" printf ("<PF>");
"?"+ printf("<?;%d>",yyleng);
. ;

%%
int yywrap() {return 1;}
int main() {
yylex();
return 0;
}