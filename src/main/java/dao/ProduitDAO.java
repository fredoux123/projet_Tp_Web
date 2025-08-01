/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import model.Produit;


/**
 *
 * @author gorgu
 */
public interface ProduitDAO {
   List<Produit> findAll();
   List<Produit> findByCategorie(String cat);
   Produit findById(int id);
   void addProduit(Produit p);
   void updateProduit(Produit p);
   void deleteProduit(int id);
}
