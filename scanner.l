%{
#include <y.tab.h>
#include <cstdio>
%}

d [0-9]
w [a-zA-Z_]
W [ \r\n\t]

%s NEUTRALIZED
%x BEGIN_REGEX

%%

const						{ return CONST; }

[/][*\/[]                   {
								fprintf(stderr, "Syntax Error: %s is not allowed here. (REGEX)\n", _strdup(yytext));
								exit(0);
							}
[/]							{ yylval.regexStart = _strdup(yytext); BEGIN(BEGIN_REGEX); return REGEX_START; }
<BEGIN_REGEX>{w}+			{ yylval.regexBody = _strdup(yytext); return REGEX_BODY; }
<BEGIN_REGEX>[/]            { yylval.regexEnd = _strdup(yytext); BEGIN(NEUTRALIZED); return REGEX_END; }


{w}+						{ yylval.ident = _strdup(yytext); return IDENT; }
[=]							{ return '='; }
[;]                         { return ';'; }

{W}

.                           {
                                fprintf(stderr, "invalid character '%c'\n", *yytext);
                                exit(0);
                            }
%%

int yywrap() {
    return 1;
}
