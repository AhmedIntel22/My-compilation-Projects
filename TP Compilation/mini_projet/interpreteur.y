%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
int execute_flag = 1;

// Table des symboles
typedef struct {
    char nom[32];
    double valeur;
    double valeurs[100];
    int est_tableau;
} Symbole;

Symbole table[100];
int nb_symbols = 0;

double executer_fonction(char *nom, double param) {
    if (strcmp(nom, "carre") == 0) return param * param;
    if (strcmp(nom, "racine") == 0) return sqrt(param);
    if (strcmp(nom, "abs") == 0) return fabs(param);
    printf("Erreur : Fonction '%s' non definie\n", nom);
    return 0;
}

double chercher_variable(char *nom, int index) {
    for (int i = 0; i < nb_symbols; i++) {
        if (strcmp(table[i].nom, nom) == 0) {
            if (table[i].est_tableau) return table[i].valeurs[index];
            return table[i].valeur;
        }
    }
    return 0;
}

void definir_variable(char *nom, double valeur) {
    for (int i = 0; i < nb_symbols; i++) {
        if (strcmp(table[i].nom, nom) == 0) {
            table[i].valeur = valeur;
            table[i].est_tableau = 0;
            return;
        }
    }
    strcpy(table[nb_symbols].nom, nom);
    table[nb_symbols].valeur = valeur;
    table[nb_symbols].est_tableau = 0;
    nb_symbols++;
}

void definir_element_tableau(char *nom, int index, double valeur) {
    for (int i = 0; i < nb_symbols; i++) {
        if (strcmp(table[i].nom, nom) == 0) {
            table[i].valeurs[index] = valeur;
            table[i].est_tableau = 1;
            return;
        }
    }
    strcpy(table[nb_symbols].nom, nom);
    table[nb_symbols].valeurs[index] = valeur;
    table[nb_symbols].est_tableau = 1;
    nb_symbols++;
}

int yylex(void);
extern int yylineno;
void yyerror(const char *s) {
    fprintf(stderr, "Erreur ligne %d : %s\n", yylineno, s);
}
%}

%debug

%union {
    double reel;
    char *chaine;
}

%token <reel> NOMBRE
%token <chaine> VARIABLE
%token AFFECTATION FIN_INSTRUCTION
%token AFFICHER
%token OUVRE_PARENTHESE FERME_PARENTHESE
%token CROCHET_OUV CROCHET_FER
%token FONCTION RETOURNER VIRGULE
%token PLUS MOINS FOIS DIVISE
%token EGAL DIFF INF SUP INFEG SUPEG
%token ET OU NON
%token SI ALORS SINON FIN TANTQUE REPETER JUSQUA

%type <reel> expression

%left OU
%left ET
%left EGAL DIFF INF SUP INFEG SUPEG
%left PLUS MOINS
%left FOIS DIVISE
%right NON

%%

programme:
    instruction_list
    ;

instruction_list:
    instruction_list instruction
    | /* vide */
    ;

instruction:
    VARIABLE AFFECTATION expression FIN_INSTRUCTION {
        if(execute_flag) definir_variable($1, $3);
        free($1);
    }
    | VARIABLE CROCHET_OUV expression CROCHET_FER AFFECTATION expression FIN_INSTRUCTION {
        if(execute_flag) definir_element_tableau($1, (int)$3, $6);
        free($1);
    }
    | AFFICHER OUVRE_PARENTHESE expression FERME_PARENTHESE FIN_INSTRUCTION { if(execute_flag) printf("%g\n", $3); }
    | conditionnelle
    | boucle
    | error FIN_INSTRUCTION { yyerrok; }
    ;

conditionnelle:
    SI OUVRE_PARENTHESE expression FERME_PARENTHESE ALORS { if($3 == 0) execute_flag = 0; } 
    instruction_list suite_conditionnelle FIN { execute_flag = 1; printf("[Info] Bloc SI-SINON reconnu\n"); }
    ;

suite_conditionnelle:
    /* vide */
    | SINON { if(execute_flag == 1) execute_flag = 0; else execute_flag = 1; } 
    instruction_list
    ;

boucle:
    TANTQUE OUVRE_PARENTHESE expression FERME_PARENTHESE ALORS instruction_list FIN {
        printf("[Info] Boucle TANT QUE reconnue\n");
    }
    | REPETER instruction_list JUSQUA OUVRE_PARENTHESE expression FERME_PARENTHESE FIN_INSTRUCTION {
        printf("[Info] Boucle REPETER reconnue\n");
    }
    ;

expression:
    NOMBRE { $$ = $1; }
    | VARIABLE { $$ = chercher_variable($1, 0); free($1); }
    | VARIABLE CROCHET_OUV expression CROCHET_FER { $$ = chercher_variable($1, (int)$3); free($1); }
    | VARIABLE OUVRE_PARENTHESE expression FERME_PARENTHESE { $$ = executer_fonction($1, $3); free($1); }
    | expression PLUS expression { $$ = $1 + $3; }
    | expression MOINS expression { $$ = $1 - $3; }
    | expression FOIS expression { $$ = $1 * $3; }
    | expression DIVISE expression { if($3 != 0) $$ = $1 / $3; else { yyerror("division par zero"); $$ = 0; } }
    | OUVRE_PARENTHESE expression FERME_PARENTHESE { $$ = $2; }
    | expression EGAL expression { $$ = ($1 == $3); }
    | expression DIFF expression { $$ = ($1 != $3); }
    | expression INF  expression { $$ = ($1 < $3); }
    | expression SUP  expression { $$ = ($1 > $3); }
    | expression INFEG expression { $$ = ($1 <= $3); }
    | expression SUPEG expression { $$ = ($1 >= $3); }
    | expression ET expression { $$ = ($1 && $3); }
    | expression OU expression { $$ = ($1 || $3); }
    | NON expression           { $$ = !($2); }
    ;

%%