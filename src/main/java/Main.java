import core.Issue;

import java.util.ArrayList;
import java.util.Scanner;

public class Main {

    private static Scanner input;

    public static void main(String[] args){
        input=new Scanner(System.in);
        menu();
    }

    private static void menu(){
        boolean exit=false;
        do{
            System.out.print("KOT: Keep On Track\n"+
                    "1. Crear nuevo\n"+
                    "2. Ver existente\n"+
                    "3. Listar todos\n"+
                    "0. Salir\n"+
                    "Opcion?: ");
            try {
                int option=Integer.parseInt(input.nextLine());
                switch(option){
                    case 1: createIssue(); break;
                    case 2: loadIssue(); break;
                    case 3: listIssues(); break;
                    case 0: exit=true; break;
                    default: System.out.println("Opcion no válida"); break;
                }
            }catch(NumberFormatException nfe){
                System.out.println("Opcion no válida");
            }
        } while (!exit);
    }

    private static Issue newIssue(){
        Issue issue=new Issue();
        System.out.print("Autor: ");
        issue.setAuthor(input.nextLine());
        System.out.print("Descripción: ");
        issue.setDescription(input.nextLine());
        return issue;
    }

    private static void createIssue(){
        Issue issue=newIssue();
        issue.save();
    }

    private static void loadIssue(){
        System.out.print("ID?: ");
        Long id=null;
        Issue issue=null;
        try{
            id=Long.parseLong(input.nextLine());
            issue=Issue.load((long) id);
        } catch (NumberFormatException nfe){
            System.out.println("ID no válido");
        }
        if (issue!=null){
            boolean printEverything=true;
            System.out.println(issue.toString(printEverything));
        }
    }

    private static void listIssues(){
        boolean printEverything=false;
        ArrayList<Issue> issues=Issue.get();
        for (Issue i: issues) {
            System.out.println(i.toString(printEverything));
        }
    }
}
