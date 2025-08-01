package controller;

import dao.ProduitDAOImpl;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ajouterProduit")
public class ServletAjouterProduit extends HttpServlet {

    private ProduitDAOImpl produitDAO;

    @Override
    public void init() {
        produitDAO = new ProduitDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("login.jsp"); // ou erreur 403
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String nom = request.getParameter("nom");
        String categorie = request.getParameter("categorie");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        String prixStr = request.getParameter("prix");

        List<String> erreurs = new ArrayList<>();
        double prix = 0;

        //  Validation
        if (nom == null || nom.trim().isEmpty()) {
            erreurs.add("Le nom est obligatoire.");
        }

        if (categorie == null || categorie.trim().isEmpty()) {
            erreurs.add("La catégorie est obligatoire.");
        }

        if (prixStr == null || prixStr.trim().isEmpty()) {
            erreurs.add("Le prix est obligatoire.");
        } else {
            try {
                prix = Double.parseDouble(prixStr);
                if (prix < 0) {
                    erreurs.add("Le prix ne peut pas être négatif.");
                }
            } catch (NumberFormatException e) {
                erreurs.add("Le prix doit être un nombre valide.");
            }
        }

        //  Si erreurs → retour formulaire avec messages
        if (!erreurs.isEmpty()) {
            request.setAttribute("erreurs", erreurs);
            request.setAttribute("nom", nom);
            request.setAttribute("categorie", categorie);
            request.setAttribute("description", description);
            request.setAttribute("image", image);
            request.setAttribute("prix", prixStr);
            request.getRequestDispatcher("/WEB-INF/admin/ajouterProduit.jsp").forward(request, response);
            return;
        }

        // Création de l'objet produit
        Produit produit = new Produit();
        produit.setNom(nom);
        produit.setCategorie(categorie);
        produit.setDescription(description);
        produit.setImage(image);
        produit.setPrix(prix);

        try {
            produitDAO.addProduit(produit);
            request.getSession().setAttribute("messageSucces", "✅ Produit ajouté avec succès !");
            response.sendRedirect("menu");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erreurTechnique", "Une erreur est survenue lors de l’ajout du produit.");
            request.getRequestDispatcher("/WEB-INF/admin/ajouterProduit.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("login.jsp"); // ou erreur 403
            return;
        }

        request.getRequestDispatcher("/WEB-INF/admin/ajouterProduit.jsp").forward(request, response);
    }

}
