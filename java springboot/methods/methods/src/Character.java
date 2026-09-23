public class Character {
    String name, dialog; 
    int hp, mp, lvl;

    public Character(String name, String dialog, int hp, int mp, int lvl) {
        this.name = name;
        this.dialog = dialog;
        this.hp = hp;
        this.mp = mp;
        this.lvl = lvl;
    }

    void introduce() {
        System.out.println("Character: " + name + ", Dialog: " + dialog + ", HP: " + hp + ", MP: " + mp + ", Level: " + lvl);
    }
}
