%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER

%left '+' '-'
%left '*' '/'

%%

input:
      /* empty */
    | input expr '\n'   { printf("= %d\n", $2); }
    ;

expr:
      NUMBER            { $$ = $1; }
    | expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | expr '*' expr     { $$ = $1 * $3; }
    | expr '/' expr     { 
                          if ($3 == 0) {
                              yyerror("Division by zero");
                              exit(1);
                          }
                          $$ = $1 / $3; 
                        }
    | '(' expr ')'      { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Simple Calculator (press Ctrl+D to exit)\n");
    yyparse();
    return 0;
}

int yywrap() { return 1; }