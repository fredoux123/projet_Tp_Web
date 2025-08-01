package model;

public class Contact {

    private int id;
    private String nomComplet;
    private String email;
    private String message;
    private boolean lu;

    public Contact() {
    }

    public Contact(String nomComplet, String email, String message) {
        this.nomComplet = nomComplet;
        this.email = email;
        this.message = message;
    }

    public Contact(int id, String nomComplet, String email, String message, boolean lu) {
    this.id = id;
    this.nomComplet = nomComplet;
    this.email = email;
    this.message = message;
    this.lu = lu;
}


    public int getId() {
        return id;
    }

    public String getNomComplet() {
        return nomComplet;
    }

    public void setNomComplet(String nomComplet) {
        this.nomComplet = nomComplet;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isLu() {
        return lu;
    }

    public void setLu(boolean lu) {
        this.lu = lu;
    }
}
