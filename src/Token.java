public class Token {


    TokenType tokenType;
    Object value;

    public Token(TokenType tokenType , Object value){
        this.tokenType=tokenType;
        this.value=value;
    }


    @Override
    public String toString() {
        return "Token{" +
                "Type=" + tokenType +
                (tokenType==TokenType.ID ? ", lexeme= " +SymbolTable.get((Integer) value) : "")+
                ", value=" + value +
                '}';
    }
}
