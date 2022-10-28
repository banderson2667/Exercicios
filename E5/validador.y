%{
   // validador: a program used to determine whether
   // a given program is standards compliant.

   #include <stdio.h>

   void yyerror(const char* msg) {
      fprintf(stderr, "%s\n", msg);
   }

   extern int yylex();
%}

%token TOKEN_ERROR // declarar os demais tokens
%token TOKEN_INT
%token TOKEN_PLUS
%token TOKEN_MINUS
%token TOKEN_MUL
%token TOKEN_DIV
%token TOKEN_LPAREN
%token TOKEN_RPAREN
%token TOKEN_SEMI

%%


program: expr TOKEN_SEMI {parser_result=$1;}
    ;

expr: expr TOKEN_PLUS term {$$=$1+$3;}
   | expr TOKEN_MINUS term {$$=$1-$3;}
   | term {$$=$1;}
   ;
term: term TOKEN_MUL factor {$$=$1*$3;}
  | term TOKEN_DIV factor   {$$=$1/$3;}
  | factor {$$=$1;}
  ;
factor: TOKEN_MINUS factor {$$=-$2;}
   | TOKEN_LPAREN expr TOKEN_RPAREN {$$=$2;}
   | TOKEN_INT {$$=atoi(yytext);}
   ;

%%

int yywrap() { 
    return 0; 
    }


