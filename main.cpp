#include <cstdio>
#include <y.tab.h>

int yylex();

YYSTYPE yylval;

extern FILE *yyin;

using namespace std;
void main(int argc, char *argv[]) {
	fopen_s(&yyin, argv[1], "r");
	int token;
	do {
		token = yylex();
		printf("Next Token: ");
		switch (token) {
			case REGEX_START: {
				printf("REGEX_START (%s)\n", yylval.regexStart);
				break;
			}
			case REGEX_END: {
				printf("REGEX_END (%s)\n", yylval.regexEnd);
				break;
			}
			case REGEX_BODY: {
				printf("REGEX_CHARS (%s)\n", yylval.regexBody);
				break;
			}
			case REGEX_CLASS_START: {
				printf("REGEX_CLASS_START (%s)\n", yylval.regexClassStart);
				break;
			}
			case REGEX_CLASS_BODY: {
				printf("REGEX_CLASS_CHARS (%s)\n", yylval.regexClassBody);
				break;
			}
			case REGEX_CLASS_END: {
				printf("REGEX_CLASS_END (%s)\n", yylval.regexClassEnd);
				break;
			}
			case REGEX_BACKSLASH_SEQ: {
				printf("REGEX_BACKSLASH_SEQ (%s)\n", yylval.regexBackSeq);
				break;
			}
			case REGEX_FLAG: {
				printf("REGEX_FLAG (%s)\n", yylval.regexFlag);
				break;
			}
			case IDENT: {
				printf("IDENT (%s)\n", yylval.ident);
				break;
			}
			case CONST: {
				printf("CONST\n");
				break;
			}
			case 0: {
				printf("EOF\n");
				break;
			}
			default: {
				printf("'%c'\n", token);
				break;
			}
		}
	} while (token != 0);
}
