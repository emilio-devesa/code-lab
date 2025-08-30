import java.util.Scanner;
import java.lang.NumberFormatException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Implementation of the Look-and-Say sequence
 * https://en.wikipedia.org/wiki/Look-and-say_sequence
 * https://emiliodevesa.wordpress.com/2023/08/22/look-and-say-conways-constant/
 *
 * @author Emilio Devesa (http://emiliodevesa.wordpress.com)
 * @version 0.1
 */
public class ConwaysConstant {

    static private String WIKIPEDIA_URL="https://en.wikipedia.org/wiki/Look-and-say_sequence";

    /**
     * Retrieves the seed from user input.
     *
     * @param input Scanner object for user input.
     * @return The user-provided seed.
     */
    private static String getSeed(Scanner input){
        String seed;
        do {
            System.out.print("Seed (0-9)? ");
            seed=input.nextLine();
        } while (!seed.matches("[0-9]"));
        return seed;
    }

    /**
     * Retrieves the number of iterations from user input.
     *
     * @param input Scanner object for user input.
     * @return The number of iterations.
     */
    private static int getIterations(Scanner input){
        int iterations=Integer.MIN_VALUE;
        do {
            try{
                System.out.print("Iterations (min. 0, max. 70, default 10)? ");
                iterations = Integer.parseInt(input.nextLine());
            } catch (NumberFormatException nfe){
            }
        } while (iterations<0 || 70<iterations);
        return iterations;
    }

    /**
     * Generates the next line in the Look-and-Say sequence.
     *
     * @param line The input line to process.
     * @return The generated next line.
     */
    static String getNextLine(String line) {
        StringBuilder nextLine=new StringBuilder();
        int count=1;
        for (int i = 0; i < line.length(); i++) {
            if (i == line.length() - 1 || line.charAt(i) != line.charAt(i + 1)) {
                nextLine.append(count).append(line.charAt(i));
                count = 1;
            } else {
                count++;
            }
        }
        return nextLine.toString();
    }

    /**
     * Prints the Look-and-Say sequence along with the number of characters in each line.
     *
     * @param line       The seed line.
     * @param iterations The number of iterations to perform.
     */
    static void printSequence(String line, int iterations){
        for (int i = 0; i <= iterations; i++) {
            System.out.println(i + ": " + line + "\t\t (" + line.length() + ")");
            line = getNextLine(line);
        }
    }

    /**
     * Prints the complexity of each line in the Look-and-Say sequence.
     *
     * @param line       The seed line.
     * @param iterations The number of iterations to perform.
     */
    static void printComplexity(String line, int iterations) {
        float length=line.length();
        for (int i = 0; i <= iterations; i++) {
            line=getNextLine(line);
            System.out.println("Line "+i+" Complexity = "+line.length()/length);
            length=line.length();
        }
    }

    /**
     * Opens a URL in the default web browser.
     *
     * @param url The URL to open.
     */
    static void openURL(String url){
        String osName = System.getProperty("os.name").toLowerCase();
        String[] openBrowserCommand;
        if (osName.contains("win")) {
            openBrowserCommand = new String[]{"rundll32", "url.dll,FileProtocolHandler", url};
        } else if (osName.contains("linux")) {
            openBrowserCommand = new String[]{"xdg-open", url};
        } else if (osName.contains("mac")) {
            openBrowserCommand = new String[]{"open", url};
        } else {
            System.err.println("ERROR: Unsupported operating system");
            return;
        }
        try {
            Runtime.getRuntime().exec(openBrowserCommand);            
        } catch (IOException ioe) {
            System.err.println("ERROR: Can't open URL\n"+ioe.getMessage());
        }
    }

    /**
     * The main method that runs the Look-and-Say sequence program.
     *
     * @param args Command-line arguments.
     */
    public static void main(String[] args){
        Scanner input=new Scanner(System.in);
        try {
            Map<Integer, Runnable> menuOptions = new HashMap<>();
            menuOptions.put(1, () -> printSequence(getSeed(input), getIterations(input)));
            menuOptions.put(2, () -> printComplexity(getSeed(input), getIterations(input)));
            menuOptions.put(3, () -> openURL(WIKIPEDIA_URL));
            menuOptions.put(0, () -> { return; });

            int option=Integer.MIN_VALUE;
            while (option!=0) {
                try {
                    System.out.println("\n\t LOOK AND SAY SEQUENCE (CONWAY'S CONSTANT) \n\t ----------------------------------------- ");
                    System.out.println("1. Print sequence and the number of characters of each line");
                    System.out.println("2. Print complexity of each line of the sequence");
                    System.out.println("3. Open the Wikipedia article page on the Look-and-Say sequence");
                    System.out.println("0. Exit");
                    System.out.print("Option? ");
                    option=Integer.parseInt(input.nextLine());
                    if (menuOptions.containsKey(option)) {
                        menuOptions.get(option).run();
                    } else {
                        System.out.println("ERROR: Invalid option");
                    }
                }catch (NumberFormatException nfe) {
                    System.out.println("ERROR: Invalid option\n"+nfe.getMessage());
                }
            }
        } finally {
            System.out.println();
            input.close();
        }
    }
}