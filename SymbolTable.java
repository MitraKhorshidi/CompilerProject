import java.util.Vector;

public class SymbolTable {

    enum Type{
        UNKNOWN,LONG, INT, STRING, CHAR, BOOLEAN, DOUBLE, FLOAT,STRING_TEXT,
    }

    static class Symbol {
        int id;
        Type type;
        String name;
        Object value;

        public Symbol(int id, Type type, String name, Object value) {
            this.id = id;
            this.type = type;
            this.name = name;
            this.value = value;
        }
    }

    static Vector<Symbol> table = new Vector<>();
    static  int counter=1000;

    public static int register(String name){
        for(Symbol s:table){
            if (s.name.equals(name))
                return s.id;
        }
        counter++;
        table.add(new Symbol(counter,Type.UNKNOWN,name,null));
        return counter;

    }

    public static String get(int id){
        for(Symbol s:table){
            if (s.id==id)
                return s.name;
        }
        return null;
    }
}
