%x COMMENT ML_COMMENT STRING

%%

"//" { BEGIN(COMMENT); }
<COMMENT>\n { BEGIN(INITIAL); }
<COMMENT>. { /* Ignore everything in line comments */ }

"/*" { BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/" { BEGIN(INITIAL); }
<ML_COMMENT>.|\n { /* Ignore everything in multi-line comments */ }

"\"" { BEGIN(STRING); }
<STRING>"\\\"" { /* Handle escaped quotes inside strings */ }
<STRING>"\"" { BEGIN(INITIAL); }
<STRING>. { /* Ignore string content */ }

[a-zA-Z_][a-zA-Z0-9_]*[ \t\n]*\( {
    char *name = yytext;
    int i = 0;
    while(name[i] != '(' && name[i] != ' ' && name[i] != '\t' && name[i] != '\n') {
        putchar(name[i]);
        i++;
    }
    printf(" ");
}

.|\n { /* Ignore everything else */ }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
    }
    yylex();
    printf("\n");
    return 0;
}

int yywrap() {
    return 1;
}