%{
#include "ifparser.tab.h"
%}

%%

if              { return IF; }
[a-zA-Z_][a-zA-Z0-9_]*   { return ID; }
"("             { return '('; }
")"             { return ')'; }
";"             { return ';'; }
[ \t\n]+        ; // Ignore whitespace
.               { printf("Invalid char: %s\n", yytext); }

%%

int yywrap() { return 1; }
