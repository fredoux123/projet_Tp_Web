package controller;

import model.*;
import dao.*;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/passerCommande")
public class PasserCommandeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Produit> panier = (List<Produit>) session.getAttribute("panier");

        if (panier == null || panier.isEmpty()) {
            response.sendRedirect("panier.jsp");
            return;
        }

        Commande commande = new Commande();
        commande.setDateCommande(new Date());

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur"); // ou "user", selon ton appli
        if (utilisateur != null) {
            commande.setUtilisateurId(utilisateur.getId()); // client
        } else {
            response.sendRedirect("login.jsp"); // ou autre traitement
            return;
        }
        for (Produit produit : panier) {
            DetailCommande detail = new DetailCommande();
            detail.setProduitId(produit.getId());
            detail.setQuantite(produit.getQuantite());
            detail.setPrixUnitaire(produit.getPrix());
            commande.addDetail(detail);
        }

        CommandeDAO dao = new CommandeDAOImpl();
        dao.sauvegarderCommande(commande);

        session.removeAttribute("panier"); // Vider le panier
        // Après avoir enregistré la commande et vidé le panier
        session.removeAttribute("panier");
        session.setAttribute("messageSucces", "cart.success");
       session.setAttribute("paiementPret", true);

       response.sendRedirect("panier.jsp");



    }
}
