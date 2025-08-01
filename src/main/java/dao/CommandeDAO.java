package dao;

import java.util.List;
import model.Commande;

public interface CommandeDAO {
    void sauvegarderCommande(Commande commande);
    List<Commande> findAll();
    Commande findById(int id);
}
