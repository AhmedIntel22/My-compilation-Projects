%{
#include "interpreteur.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap
%option yylineno

%%

[ \t\n\r]   {  }
"//".*      {  }

","         { return VIRGULE; }
";"         { return FIN_INSTRUCTION; }
"="         { return AFFECTATION; }
"si"        { return SI; }
"alors"     { return ALORS; }
"sinon"     { return SINON; }
"fin"       { return FIN; }
"tant que"  { return TANTQUE; }
"repeter"   { return REPETER; }
"jusqua"    { return JUSQUA; }
"print"     { return AFFICHER; }
"fonction"    { return FONCTION; }
"retourner" { return RETOURNER; }
"("         { return OUVRE_PARENTHESE; }
")"         { return FERME_PARENTHESE; }
"["         { return CROCHET_OUV; }
"]"         { return CROCHET_FER; }
"+"         { return PLUS; }
"-"         { return MOINS; }
"*"         { return FOIS; }
"/"         { return DIVISE; }
"=="        { return EGAL; }
"!="        { return DIFF; }
"<"         { return INF; }
">"         { return SUP; }
"<="        { return INFEG; }
">="        { return SUPEG; }
"&&"        { return ET; }
"||"        { return OU; }
"!"         { return NON; }

[0-9]+(\.[0-9]+)?      { yylval.reel = atof(yytext); return NOMBRE; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.chaine = strdup(yytext); return VARIABLE; }

.           { fprintf(stderr, "Erreur Lexicale a la ligne %d : Caractere inconnu [%s]\n", yylineno, yytext); }

%%