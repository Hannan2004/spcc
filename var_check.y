%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token ID KEYWORD

%%

input:
    ID         { printf("Valid C variable name.\n"); }
  | KEYWORD    { printf("Invalid: '%s' is a C keyword.\n", yytext); }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    printf("Enter a variable name: ");
    yyparse();
    return 0;
}
