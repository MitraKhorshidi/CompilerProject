public class ErrorHandler {

    public static void error(int lineNum,String ch){
        System.out.println("Illegal character: <" + ch + "> in line: " + lineNum);
    }
}
