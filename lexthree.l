%{
#include<stdio.h>
#include<stdlib.h>

int keyword = 0;
int identifier = 0;
int operators = 0;
%}

%%
if|else|break|int|float|double|char   {keyword++;}
[a-zA-Z_][a-zA-Z0-9_]                 {identifier++;}
[-+\*/%]                              {operators++;}
[ \t\n]+                              ; 
.                                     ;
%%

int yywrap() { return 1; }

int main() {
    printf("Enter the input: \n");
    yylex();
    printf("Keyword:%d \n", keyword);
    printf("Identifier:%d \n", identifier);
    printf("Operators:%d \n", operators);
    return 0;
}