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
				printf("REGEXP_START (%s)\n", yylval.regexStart);
				break;
			}
			case REGEX_END: {
				printf("REGEXP_END (%s)\n", yylval.regexEnd);
				break;
			}
			case REGEX_BODY: {
				printf("REGEXP_BODY (%s)\n", yylval.regexBody);
				break;
			}
			case REGEX_FLAG: {
				printf("REGEXP_FLAG (%s)\n", yylval.regexFlag);
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
