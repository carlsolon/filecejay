public class Main {
    public static void main(String[] args) throws Exception {
        Character c = new Character("Carl", "Hai", 2, 3, 4);
        c.name = "Carl";
        c.dialog = "Hello";
        c.hp = 100; 
        c.mp = 50;
        c.lvl = 1;

        c.introduce();
    }
}
