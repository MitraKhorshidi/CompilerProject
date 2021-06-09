
public class scanner {

    public static void main(String[] args) {

        try {
            java.io.Reader buffer = new java.io.InputStreamReader(new java.io.FileInputStream(args[0]));
            Lexer lexer = new Lexer(buffer);
            do {
                Token token=lexer.yylex();
                System.out.println(token);
            } while (!lexer.yyatEOF());

        } catch (java.io.FileNotFoundException e) {
            System.out.println("File not found : \"" + args[0] + "\"");
        } catch (java.io.IOException e) {
            System.out.println("IO error scanning file \"" + args[0] + "\"");
            System.out.println(e);
        } catch (Exception e) {
            System.out.println("Unexpected exception:");
            e.printStackTrace();

        }



    }
}
