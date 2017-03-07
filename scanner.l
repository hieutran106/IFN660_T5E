%{
#include <y.tab.h>
#include <cstdio>
%}

d [0-9]
w [a-zA-Z_]
W [ \r\n\t]

%s __NEUTRALIZED
%x __REGEX_BEGIN
%x __REGEX_FLAG

%%

const						{ return CONST; }

[/][*\/[]                   {
								fprintf(stderr, "Syntax Error: %s is not allowed here. (REGEX_FIRST_CHARACTER)\n", _strdup(yytext));
								exit(0);
							}
[/]							{ yylval.regexStart = _strdup(yytext); BEGIN(__REGEX_BEGIN); return REGEX_START; }
<__REGEX_BEGIN>{w}+			{ yylval.regexBody = _strdup(yytext); return REGEX_BODY; }
<__REGEX_BEGIN>[/]/[gimuy]+ { yylval.regexEnd = _strdup(yytext); BEGIN(__REGEX_FLAG); return REGEX_END; }
<__REGEX_BEGIN>[/]          { yylval.regexEnd = _strdup(yytext); BEGIN(INITIAL); return REGEX_END; }
<__REGEX_FLAG>[gimuy]+		{ yylval.regexFlag = _strdup(yytext); BEGIN(INITIAL); return REGEX_FLAG; }


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
