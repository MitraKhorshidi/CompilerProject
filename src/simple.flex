
//my project
import java_cup.runtime.*;
%%


%class Lexer
%public
%type Symbol
%cup
%line //count input lines
%state COMMENT
%state SINGLE_LINE_COMMENT
//%debug

%{
  private int comment_count = 0;
    private Symbol symbol(int tokenType){
      return new Symbol(tokenType,yytext());
    }
    private Symbol symbol(int tokenType,Object value){
      return new Symbol(tokenType,value);
    }
%}




ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n
WHITE_SPACE_CHAR={NONNEWLINE_WHITE_SPACE_CHAR}|{NEWLINE}
STRING_TEXT=(\\\"|[^\n\r\"]|\\{WHITE_SPACE_CHAR}+\\)*
//COMMENT_TEXT=([^*/\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])+
ID = {ALPHA}({ALPHA}|{DIGIT}|_)*
INT_NUMBER={DIGIT}+
FLOAT_NUMBER={DIGIT}+(\.{DIGIT}+)
//number= [+-]?{DIGIT}+(\.{DIGIT}+)?




%%

<YYINITIAL> {
            
  "if"    {return symbol(sym.IF);}  
  "else"    {return symbol(sym.ELSE);}   
  "for"    {return symbol(sym.FOR);}  
  "while"    {return symbol(sym.WHILE);}  
  "then"    {return symbol(sym.THEN);}  
  "break"    {return symbol(sym.BREAK);}  
  "static"    {return symbol(sym.STATIC);}  
  "main"    {return symbol(sym.MAIN);}
  "void"    {return symbol(sym.VOID);}
  "public"    {return symbol(sym.PUBLIC);}
  "default"    {return symbol(sym.DEFAULT);}  
  "continue"    {return symbol(sym.CONTINUE);} 
  "return"    {return symbol(sym.RETURN);}

  "System.in.read"    {return symbol(sym.READ);}
  "System.out.println"    {return symbol(sym.WRITE);}


  "int"    {return symbol(sym.PRI_TYPE,ValueType.INT);}
  "boolean"    {return symbol(sym.PRI_TYPE,ValueType.BOOLEAN);}
  "float"    {return symbol(sym.PRI_TYPE,ValueType.FLOAT);}
  "String"    {return symbol(sym.PRI_TYPE,ValueType.STRING);}


  "="    {return symbol(sym.ASSIGN);}  
  "!"    {return symbol(sym.NOT);}

  "+"    {return symbol(sym.MATH_OP);}
  "-"    {return symbol(sym.MATH_OP);}
  "*"    {return symbol(sym.MATH_OP);}
  "/"    {return symbol(sym.MATH_OP);}
  "%"    {return symbol(sym.MATH_OP);}
  "&&"   {return symbol(sym.LOGIC_OP);}
  "||"   {return symbol(sym.LOGIC_OP);}

  "=="    {return symbol(sym.COMP_OP);}
  "!="    {return symbol(sym.COMP_OP);}
  "<"    {return symbol(sym.COMP_OP);}
  ">"    {return symbol(sym.COMP_OP);}
  "<="    {return symbol(sym.COMP_OP);}
  ">="    {return symbol(sym.COMP_OP);}

  "++"    {return symbol(sym.INC_DEC);}
  "--"    {return symbol(sym.INC_DEC);}

  "false"    {return symbol(sym.TRUE_FALSE);}
  "true"    {return symbol(sym.TRUE_FALSE);}

  "("    {return symbol(sym.LPAR);}  
  ")"    {return symbol(sym.RPAR);}  
  "{"    {return symbol(sym.LBLOCK);}  
  "}"    {return symbol(sym.RBLOCK);} 
  "["    {return symbol(sym.LBRACKET);}  
  "]"    {return symbol(sym.RBRACKET);}  
  ";"    {return symbol(sym.SEMICOLON);}  
  ","    {return symbol(sym.COMMA);}  

  


  {INT_NUMBER}  {
    return symbol(sym.INT_NUMBER,Integer.parseInt(yytext()));
    }

  {FLOAT_NUMBER}  {
      return symbol(sym.FLOAT_NUMBER,Float.parseFloat(yytext()));
      }


  {ID} {
    String id=yytext();
    SymbolEntry entry=SymbolTable.curScope.register(id);
    return symbol(sym.ID,entry);
    }


  \"{STRING_TEXT}\" {
      String str =  yytext().substring(1,yylength()-1);
      return symbol(sym.STRING_TEXT,str);
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
