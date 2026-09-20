package bubbleSort;

public class more {

    public static void sort(int[][] arr) {
        for (int i = 0; i < arr.length; i++) {
            sortArray(arr[i]);
        }
    }
    private static void sortArray(int[] arr) {
        for (int i = 0; i < arr.length - 1; i++) {
            for (int j = 0; j < arr.length - 1 - i; j++) {
                if (arr[j] > arr[j + 1]) {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
    }
    public static void main(String[] args) {
        int[][] carl = {
                {1, 2, 6, 4, 7},
                {44, 8, 5, 8, 8},
        };
        sort(carl);
        for (int[] subArray : carl) {
            for (int element : subArray) {
                System.out.print(element + " ");
            }
            System.out.println();
        }
    }
}

