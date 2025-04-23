%{
#include <stdio.h>

int printf_count = 0;
int scanf_count = 0;
%}

%%

"printf"        { printf_count++; }
"scanf"         { scanf_count++; }

[ \t\n]+        ;   // Ignore whitespace
.               ;   // Ignore all other characters

%%

int yywrap() { return 1; }

int main() {
    printf("Enter your C code (Ctrl+Z to end input on Windows):\n");
    yylex();
    printf("\nCount of printf statements: %d\n", printf_count);
    printf("Count of scanf statements: %d\n", scanf_count);
    return 0;
}
