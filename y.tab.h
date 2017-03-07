#pragma once

enum yytokentype {
	NUMBER = 258,
	IDENT,
	IF,
	ELSE,
	VAR,
	CONST,
	LET,
	REGEXP
};

union YYSTYPE {
	char *var;
	double num;
	char *regexp;
};

extern YYSTYPE yylval;
