package model;
import java.io.Serializable;

public class Produit implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String nom;
    private String categorie;
    private double prix;
    private String description;
    private String image;
    private int quantite = 1;

    public Produit() {
    }

    public Produit(int id, String nom, String categorie, double prix, String description, String image) {
        this.id = id;
        this.nom = nom;
        this.categorie = categorie;
        this.prix = prix;
        this.description = description;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    @Override
    public String toString() {
        return "Produit{" + "id=" + id + ", nom=" + nom + ", categorie=" + categorie + ", prix=" + prix + ", description=" + description + ", image=" + image + '}';
    }

}
