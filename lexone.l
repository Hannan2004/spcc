%{
#include <stdio.h>
#include <stdlib.h>

int vowel_count = 0, consonant_count = 0;
%}

%%

[aAeEiIoOuU]     { vowel_count++; }
[a-zA-Z]         { consonant_count++; }
.|\n             { /* ignore all other characters */ }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter the input: \n");
    yylex();
    printf("Total Vowels: %d\n", vowel_count);
    printf("Total Consonants: %d\n", consonant_count);
    return 0;
}
