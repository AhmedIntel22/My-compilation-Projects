%{
#include <stdio.h>
#include <stdlib.h>
int nb_lignes = 1;
int nb_erreurs = 0;
%}

entier [0-9]+
reel [+-]?[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?|[+-]?[0-9]+[eE][+-]?[0-9]+
ident [a-zA-Z][a-zA-Z0-9_]*
motcle "if"|"else"|"while"

%x STR COMM

%%
[ \t]+ { /* ignore spaces */ }
"\n" { nb_lignes++; }

{motcle} { printf("MOTCLE : %s\n", yytext); }
{ident} { printf("IDENT : %s\n", yytext); }
{reel} { printf("REEL : %f\n", atof(yytext)); }
{entier} { printf("ENTIER : %s\n", yytext); }

"+"|"-"|"*"|"/" { printf("OP-ARTHM : %s\n", yytext); }
"<"|">"|"<="|">="|"=="|"!=" { printf("OP-REL : %s\n", yytext); }
"=" { printf("AFFECT : %s\n", yytext); }

"#" { BEGIN(COMM); }
<COMM>"#" { printf("COMMENTAIRE : à ignorer\n"); BEGIN(INITIAL); }
<COMM>\n { 
printf("# *** ligne %d *** # attendu\n", nb_lignes);
nb_erreurs++; nb_lignes++; BEGIN(INITIAL); 
}
<COMM>. { /* Ignore string content */ }

"\"" { BEGIN(STR); printf("CHAINE : \""); }
<STR>"\"" { printf("\"\n"); BEGIN(INITIAL); }
<STR>\n { 
printf("\n*** Erreur ligne %d : fin de chaîne attendue\n", nb_lignes); 
nb_erreurs++; nb_lignes++; BEGIN(INITIAL); 
}
<STR>. { printf("%s", yytext); }

[0-9]+[eE] { printf("%s *** ligne %d *** exposant attendu\n", yytext, nb_lignes); nb_erreurs++; }
[0-9]+[a-zA-Z_]+ { printf("%s *** ligne %d *** identificateur erroné\n", yytext, nb_lignes); nb_erreurs++; }

. { printf("%s *** ligne %d *** Erreur Lexicale\n", yytext, nb_lignes); nb_erreurs++; }

%%

int main(int argc, char **argv) {
if (argc > 1) {
yyin = fopen(argv[1], "r");
if(!yyin) { perror("File error"); return 1; }
}
yylex();
if(nb_erreurs > 0) printf("\nTOTAL : %d ERRORS\n", nb_erreurs);
return 0;
}

int yywrap() { return 1; }