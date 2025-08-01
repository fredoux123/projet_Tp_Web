package dao;

import model.Utilisateur;


public interface UtilisateurDAO {
    Utilisateur findByEmail(String email);
    Utilisateur findByEmailAndPassword(String email, String password);
    void save(Utilisateur utilisateur);
   
}
       


