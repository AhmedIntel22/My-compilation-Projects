#include <stdio.h>
#include <stdlib.h>

extern int yyparse(void);
extern FILE *yyin;
extern int yydebug;

int main(int argc, char **argv) {
    yydebug = 1;
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Impossible d'ouvrir %s\n", argv[1]);
            return 1;
        }
    } else {
        yyin = stdin;
    }
    printf("=== Interpreteur du mini-langage (Etendu) ===\n");
    if (yyin == stdin) {
        printf("Entrez vos instructions (Ctrl+D pour quitter) :\n");
    }

    yyparse();

    if (yyin != stdin) fclose(yyin);
    return 0;
}
