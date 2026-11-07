%{
#include <stdio.h>
int yylex(void);
int yyerror (char*);
%}
%%
mot : S '$' {printf("mot correct\n"); getchar();}
;
S : 'a'S'a'
| 'b'S'b'
| 'c'
;
%%
int yylex()
{
char c=getchar();
if (c=='a'||c=='b'||c=='c'||c=='$') return(c);
else printf("erreur lexicale");
}
int yyerror(char *s){
printf("%s \n",s);
return 0;
}
int main(){
yyparse();
}