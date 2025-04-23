%{
#include <stdio.h>
%}

%%

play|eat|sleep|study|walk|talk|run|[a-zA-Z]*ing         { printf("%s - Verb\n", yytext); }
gracefully|beautifully|hastily|[a-zA-Z]*ly              { printf("%s - Adverb\n", yytext); }
tall|short|dark|long|beautiful|hard|fast                { printf("%s - Adjective\n", yytext); }
[a-zA-Z]+                                               { printf("%s - Unsupported as of now\n", yytext); }
[ \t\n]+                                                ; // Skip whitespace
.                                                       ; // Skip other characters

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter English words (Ctrl+Z to end):\n");
    yylex();
    return 0;
}
