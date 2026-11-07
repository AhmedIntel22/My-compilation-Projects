%{
#include <stdio.h>
#include <stdlib.h>

int nbMots = 0;
int nbLignes = 1;
int nbCaracteres = 0;
long somme = 0;
%}

num [0-9]+
word [A-Za-z]+

%%
{num} {
nbCaracteres += yyleng;
somme += atol(yytext);
}

{word} {
nbMots++;
nbCaracteres += yyleng;
}

\n {
nbLignes++;
}

. {
nbCaracteres++;
}
%%

int yywrap() { return 1; }
int main(int argc, char *argv[]) {
FILE *fichierSortie;
if (argc != 2) {
printf("Usage: %s fichier.txt\n", argv[0]);
return 1;
}
yyin = fopen(argv[1], "r");
if (yyin == NULL) {
printf("Erreur ouverture fichier\n");
return 1;
}
yylex();
fclose(yyin);
fichierSortie = fopen("resultat.txt", "w");

fprintf(fichierSortie, "Number of words : %d\n", nbMots);
fprintf(fichierSortie, "Numbre of lines : %d\n", nbLignes);
fprintf(fichierSortie, "Nombre of characters : %d\n", nbCaracteres);
fprintf(fichierSortie, "Sum of numbers : %ld\n", somme);

fclose(fichierSortie);

return 0;
}