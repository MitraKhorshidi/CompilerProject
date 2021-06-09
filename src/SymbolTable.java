import java.util.Vector;

public class SymbolTable {
    static Vector<String> table = new Vector<>();

    public static int register(String id){
        int index=table.indexOf(id);
        if(index!=-1)
            return index;
        table.add(id);
        return table.size()-1;

    }

    public static String get(int index){
        return table.get(index);
    }
}
