
import java.util.Scanner;

public class car {
    Scanner s = new Scanner(System.in);

    void fullthrottle(){
        System.out.print("Choose your throttle Full(F), middle(M), slow(S): ");
        String wow = s.nextLine();

        if(wow.equals("F")){
            System.out.println("your throttle is Full");
        }if(wow.equals("M")){
            System.out.println("your throttle is Medium");
        }if(wow.equals("S")){
            System.out.println("your throttle is SLOW");
        }

    }


    void speed(){
    }


}
