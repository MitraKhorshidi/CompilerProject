
//my project
%%


%class Lexer
%public
%type Token

%{
  private int comment_count = 0;
  private Token symbol(TokenType tokenType){
    return new Token(tokenType,null);
  }
  private Token symbol(TokenType tokenType,Object value){
    return new Token(tokenType,value);
  }
  String str="\"string";
%}

%line //count input lines
%state COMMENT
%state SINGLE_LINE_COMMENT
// %debug


ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n
WHITE_SPACE_CHAR={NONNEWLINE_WHITE_SPACE_CHAR}|{NEWLINE}
STRING_TEXT=(\\\"|[^\n\r\"]|\\{WHITE_SPACE_CHAR}+\\)*
//COMMENT_TEXT=([^*/\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])+
Id = {ALPHA}({ALPHA}|{DIGIT}|_)*
number= [+-]?{DIGIT}+(\.{DIGIT}+)?




%%

<YYINITIAL> {
            
  "if"    {return symbol(TokenType.IF);}  
  "else"    {return symbol(TokenType.ELSE);}   
  "for"    {return symbol(TokenType.FOR);}  
  "while"    {return symbol(TokenType.WHILE);}  
  "then"    {return symbol(TokenType.THEN);}  
  "break"    {return symbol(TokenType.BREAK);}  
  "static"    {return symbol(TokenType.STATIC);}  
  "void"    {return symbol(TokenType.VOID);}  
  "public"    {return symbol(TokenType.PUBLIC);}  
  "default"    {return symbol(TokenType.DEFAULT);}  
  "continue"    {return symbol(TokenType.CONTINUE);} 
  "return"    {return symbol(TokenType.RETURN);}


  "long"    {return symbol(TokenType.LONG);}  
  "int"    {return symbol(TokenType.INT);}  
  "double"    {return symbol(TokenType.DOUBLE);}  
  "char"    {return symbol(TokenType.CHAR);}  
  "String"    {return symbol(TokenType.STRING);}  
  "boolean"    {return symbol(TokenType.BOOLEAN);}  
  "float"    {return symbol(TokenType.FLOAT);}  


  "="    {return symbol(TokenType.ASSIGN);}  

  "+"    {return symbol(TokenType.PLUS);}
  "-"    {return symbol(TokenType.MINUS);}
  "*"    {return symbol(TokenType.MUL);}
  "/"    {return symbol(TokenType.DIV);}  
  "%"    {return symbol(TokenType.MOD);}  
  "&&"   {return symbol(TokenType.AND);}
  "||"   {return symbol(TokenType.OR);}

  "=="    {return symbol(TokenType.EQ);}
  "!="    {return symbol(TokenType.NEQ);}  
  "<"    {return symbol(TokenType.LT);}  
  ">"    {return symbol(TokenType.GT);}  
  "<="    {return symbol(TokenType.LTEQ);}  
  ">="    {return symbol(TokenType.GTEQ);} 

  "++"    {return symbol(TokenType.INC);}  
  "--"    {return symbol(TokenType.DEC);}  

  "false"    {return symbol(TokenType.FALSE);}  
  "true"    {return symbol(TokenType.TRUE);}  

  "("    {return symbol(TokenType.LPAR);}  
  ")"    {return symbol(TokenType.RPAR);}  
  "{"    {return symbol(TokenType.LBLOCK);}  
  "}"    {return symbol(TokenType.RBLOCK);} 
  "["    {return symbol(TokenType.LBRACKET);}  
  "]"    {return symbol(TokenType.RBRACKET);}  
  ";"    {return symbol(TokenType.SEMICOLON);}  
  ","    {return symbol(TokenType.COMMA);}  

  


  {number}  {
    Double num=Double.parseDouble(yytext());
    return symbol(TokenType.NUMBER,num);
    }


  {Id} {
    String id=yytext();
    int index=SymbolTable.register(id);
    return symbol(TokenType.ID,index);
    }


  \"{STRING_TEXT}\" {
      String str =  yytext().substring(1,yylength()-1);
      return symbol(TokenType.STRING_TEXT,str);
    }

    \"{STRING_TEXT} {
      String str =  yytext();
      ErrorHandler.error(yyline,str);
    }

  

  {NONNEWLINE_WHITE_SPACE_CHAR }+ {}
  
  "//" { yybegin(SINGLE_LINE_COMMENT); }


  "/*" { yybegin(COMMENT);
//         comment_count++;
      }
  

}

<SINGLE_LINE_COMMENT>{
  {NEWLINE} { yybegin(YYINITIAL); }
  . {}
}

<COMMENT> {
//  "/*" { comment_count++; }
//  "*/" { if (--comment_count == 0) yybegin(YYINITIAL); }
    "*/" {  yybegin(YYINITIAL); }
//  {COMMENT_TEXT} { }
  . {}
}

  {NEWLINE} { }

 . {ErrorHandler.error(yyline,yytext());}
