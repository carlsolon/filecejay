
import java.util.Scanner;


public class Main {
    public static void main(String[] args) throws Exception {
        Scanner s = new Scanner(System.in);
        input in = new input();


        System.out.print("your first name is: ");
        String firstName = s.nextLine();
        System.out.print("your last Name is: ");
        String lastName = s.nextLine();
        System.out.print("your age is: ");
        int age = s.nextInt();

        in.user();
        System.out.println(firstName);
        System.out.println(lastName);
        System.out.println(age);
        
    }
}
