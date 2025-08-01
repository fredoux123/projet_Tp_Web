
package controller;

import dao.ProduitDAO;
import dao.ProduitDAOImpl;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/modifierProduit")
public class ModifierProduitServlet extends HttpServlet {

    private ProduitDAO produitDAO;

    @Override
    public void init() {
        produitDAO = new ProduitDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        List<String> erreurs = new ArrayList<>();

        String idStr = req.getParameter("id");
        String nom = req.getParameter("nom");
        String categorie = req.getParameter("categorie");
        String prixStr = req.getParameter("prix");
        String description = req.getParameter("description");
        String image = req.getParameter("image");

        int id = 0;
        double prix = 0.0;

        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            erreurs.add("ID du produit invalide.");
        }

        // Valider le prix
        try {
            prix = Double.parseDouble(prixStr);
            if (prix < 0) {
                erreurs.add("Le prix ne peut pas être négatif.");
            }
        } catch (NumberFormatException e) {
            erreurs.add("Le prix doit être un nombre valide.");
        }

        if (nom == null || nom.trim().isEmpty()) {
            erreurs.add("Le nom est requis.");
        }
        if (categorie == null || categorie.trim().isEmpty()) {
            erreurs.add("La catégorie est requise.");
        }
        if (description == null || description.trim().isEmpty()) {
            erreurs.add("La description est requise.");
        }

        // Si erreurs → on renvoie vers la page d’édition
        if (!erreurs.isEmpty()) {
            Produit p = produitDAO.findById(id); // pour préremplir
            req.setAttribute("produit", p);
            req.setAttribute("erreurs", erreurs);
            req.setAttribute("nom", nom);
            req.setAttribute("categorie", categorie);
            req.setAttribute("prix", prixStr);
            req.setAttribute("description", description);
            req.setAttribute("image", image);
            req.getRequestDispatcher("/WEB-INF/admin/editProduit.jsp").forward(req, resp);
            return;
        }

        // Sinon → update et redirection
        Produit p = new Produit(id, nom, categorie, prix, description, image);
        produitDAO.updateProduit(p);
        // Après updateProduit
        req.getSession().setAttribute("messageSucces", "✅ Produit modifié avec succès !");
        resp.sendRedirect("menu");

    }
}
