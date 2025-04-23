%{
#include <stdio.h>
#include <stdlib.h>

int words = 0;
int characters = 0;
int lines = 0;
%}

%%
[a-zA-Z0-9_]+ {words++; characters += yyleng; }
[ \t]+        { characters += yyleng; }
\n            { characters++; lines++; }
.             { characters++; }
%%

int yywrap() { return 1; }

int main() {
    printf("Enter the word: \n");
    yylex();
    printf("Word: %d", words);
    printf("Characters: %d", characters);
    printf("Lines: %d", lines);
}