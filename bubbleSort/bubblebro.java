package bubbleSort;

import java.util.Arrays;
import java.util.Scanner;

public class bubblebro {

    public static void sorted(int[][] arr){
        for(int i = 0; i<arr.length; i++){
            sort(arr[i]);
        }
    }
    public static void sort(int array[]){
        for(int i = 0 ; i < array.length-1; i++){
            for(int j = 0 ; j < array.length- 1; j++){
                if(array[j] > array[j + 1]){
                    int tem = array[j];
                    array[j] = array[j + 1];
                    array[1+ j] = tem;
                }
            }
        }
    }
    public static void main(String[] args) {
    //     Scanner s = new Scanner(System.in);
    //     System.out.println("Enter a number you want to sort");
    //     int number = s.nextInt();
        
    //     int[] input = new int[number];

    //     for(int i =0 ; i < number; i ++){
    //         input[i] = s.nextInt();
    //     }
    // sort(input);
    // for(int i : input){
    //     System.out.print(i + ", ");
    // }

    int[][] carl = {

        {4,5,3,6,2,6,},
        {9,5,6,8,4,2,1},

    };
    sorted(carl);

    for(int[] i : carl){
        System.out.println("\n"+Arrays.toString(i));
    }

    }
}
