%{
#include "var_check.tab.h"
#include <string.h>

// C keywords
char *keywords[] = {
    "int", "char", "float", "double", "return", "for", "while", "do",
    "if", "else", "break", "continue", "void", "struct", "const", "unsigned", NULL
};

int is_keyword(char *word) {
    for (int i = 0; keywords[i] != NULL; i++) {
        if (strcmp(word, keywords[i]) == 0) return 1;
    }
    return 0;
}
%}

%%

[a-zA-Z_][a-zA-Z0-9_]* {
    if (is_keyword(yytext))
        return KEYWORD;
    else
        return ID;
}

.|\n    { return 0; }

%%

int yywrap() {
    return 1;
}
