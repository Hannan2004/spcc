%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
int tempCount = 0
char temp[10];

char* newTemp() {
    sprintf(temp, "t%d", tempCount++);
    return strdup(temp)
}
%}

%union{
    char* str;
}

%token <str>ID 
%token <str> NUM
%left '+' '-'
%left '*' '/'

%type <str> expr

%%
stmt: 
   ID '=' expr ';' {
    printf("%s = %s\n", $1, $3)
   }
expr:
   expr '+' expr {
    char* t = newTemp();
    printf("%s = %s + %s\n", t, $1, $3);
    $$ = t;
   }
   | expr '-' expr {
    char* t = newTemp();
    printf("%s = %s - %s\n", t, $1, $3);
    $$ = t;
   }
   | expr '*' expr {
    char* t = newTemp();
    printf("%s = %s * %s\n", t, $1, $3);
    $$ = t;
   }
   | expr '/' expr {
    char* t = newTemp();
    printf("%s = %s / %s\n", t, $1, $3);
    $$ = t;
   }
   | ID {$$ = $1;}
   | NUM {$$ = $1;}
   ;
%%

int main() {
    printf("Enter expression (e.g., a = b + c * d;):\n");
    yyparse();
    return 0;
}