%{
#include "calc.tab.h"  // Include YACC definitions
%}

%%
[0-9]+          { yylval = atoi(yytext); return NUMBER; }
[+\-*/()]{1}    { return yytext[0]; }
[ \t]+          ;    // Ignore whitespace
\n              { return '\n'; }
.               { printf("Invalid character: %s\n", yytext); }
<<EOF>>         { return 0; }

%%
