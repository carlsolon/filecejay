import java.util.Scanner;
public class Main {
    public static void main(String[] args) throws Exception {
        car c = new car();
        Scanner s = new Scanner(System.in);

            c.fullthrottle();
  

        System.out.println("Set the speed you want: ");
        int sp = s.nextInt();

        if(sp == sp){
            c.speed();
        }
    }
}
