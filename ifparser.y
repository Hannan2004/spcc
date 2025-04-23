%{
#include <stdio.h>
#include <stdlib.h>

int nesting_level = 0;
int yylex();
void yyerror(const char *s);
%}

%token IF ID

%%

program:
    stmt_list
    ;

stmt_list:
      stmt_list stmt
    | stmt
    ;

stmt:
      IF '(' ID ')' stmt    {
                              nesting_level++;
                              printf("IF statement at level: %d\n", nesting_level);
                              nesting_level--;
                            }
    | ID ';'                // A dummy statement like `x;`
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter nested if statements. Press Ctrl+D to end:\n");
    yyparse();
    return 0;
}
