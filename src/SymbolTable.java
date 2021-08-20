import java.util.Vector;

public class SymbolTable {

    public static final SymbolTable GLOBAL_SCOPE = new SymbolTable(null);
    public static SymbolTable curScope = GLOBAL_SCOPE;

    public static void enterScope() {
        curScope = new SymbolTable(curScope);
    }

    public static void exitScope() {
        curScope = curScope.parent;
    }

    public SymbolTable(SymbolTable parent) {
        this.parent = parent;
    }

    final SymbolTable parent;
    final Vector<SymbolEntry> table = new Vector<>();
    static int counter = 1000;

    public SymbolEntry get(int id) {
        for (SymbolEntry s : table) {
            if (s.id == id)
                return s;
        }
        if (parent != null)
            return parent.get(id);
        return null;
    }

    public SymbolEntry get(String lexeme) {
        for (SymbolEntry s : table) {
            if (s.name.equals(lexeme))
                return s;
        }
        if (parent != null)
            return parent.get(lexeme);
        return null;
    }

    public SymbolEntry register(String lexeme) {
        for (SymbolEntry s : table) {
            if (s.name.equals(lexeme))
                return s;
        }
        counter++;
        SymbolEntry entry = new SymbolEntry(counter, ValueType.UNKNOWN, lexeme, null);
        curScope.table.add(entry);
        return entry;

    }

}
