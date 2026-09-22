 public class her {
    String email;
    int numberuser;
    String type;
    public her (String email, int numberuser, String type){
        this.email=email;
        this.numberuser=numberuser;
        this.type=type;
    }
    public static void main(String[] args) {
        her h = new her("carl solon", 2014,"email");
            h.setEmail("carlsolon2");
            h.setNumberuser(1212);
            h.setType("email");

            System.out.println(h.getEmail());
            System.out.println(h.getNumberuser());
            System.out.println(h.getType());
        
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public int getNumberuser() {
        return numberuser;
    }
    public void setNumberuser(int numberuser) {
        this.numberuser = numberuser;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
}
