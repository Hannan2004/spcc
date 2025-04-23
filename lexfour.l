%{
#include <stdio.h>
#include <stdlib.h>

int even = 0;
int odd = 0;
%}

%%

[0-9]+ {
    int num = atoi(yytext);
    if (num % 2 == 0) {
        printf("%d is even", num);
        even ++;
    }
    else {
        printf("%d is odd", num);
        odd ++;
    }
}

[ \t\n]+   ;     // Ignore whitespace
.          ;     // Ignore other characters

%%

int yywrap() { return 1; }

int main() {
    printf("Enter the input (Ctrl+Z to end):\n");
    yylex();
    printf("\nEven: %d\n", even);
    printf("Odd: %d\n", odd);
    return 0;
}
