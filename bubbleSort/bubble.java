package bubbleSort;

import java.util.Arrays;
import java.util.Scanner;

public class bubble {
    
    public static void bubbleSort(int[]a){
        boolean sorted = false;
        int pass = 0;
        while (!sorted) {
            sorted = true;
            System.out.println("pass" + pass + Arrays.toString(a));
            for (int i = 0; i< a.length - 1; i++) {

                if (a[i] > a[i+1]) {
                int temp = a[i];
                a[i] = a[i+1];  
                a[i+1] = temp;
                sorted = false;
            }
            }
            pass++;
        }
        System.out.println(pass);

    }
    public static int [] input(){
        Scanner s = new Scanner(System.in);
        System.out.println("Enter how many number you want: ");
        int num = s.nextInt();

        int[] x = new int[num];



        for(int i = 0; i < x.length; i++){
            System.out.println("enter a " + num + "number here: " + num--);
            int nu = s.nextInt();
            x[i] = nu;
            
        }
        return x;
  
    }


    public static void main(String[] args) {
        // int[] carl = {1,2,3,4,5};
        int[] carl = input();
        bubbleSort(carl.clone());

        
    }
}