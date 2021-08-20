public class ErrorHandler {

    public static void error(int lineNum,String ch){
        System.out.println("Illegal character: <" + ch + "> in line: " + lineNum);
    }

    public static void error_stmt(parser p) {
        p.report_error("syntax error",null);
    }

    public static void error_type(parser p, ValueType type) {
        p.report_error("types mismatch",type);
    }

    public static void error_varDefined(parser p, SymbolEntry id) {
        p.report_error(" var already defined",id.name);
    }

    public static void error_varNotDefined(parser p, SymbolEntry id) {
        p.report_error("var not defined",id.name);
    }
}
