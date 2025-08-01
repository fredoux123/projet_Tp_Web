package controller;

import dao.ProduitDAO;
import dao.ProduitDAOImpl;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class ServletProduit extends HttpServlet {

    private ProduitDAO produitDAO;

    @Override
    public void init() throws ServletException {
        produitDAO = new ProduitDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Servlet /menu appelé");

        String action = request.getParameter("action");
        String categorie = request.getParameter("categorie");
        String search = request.getParameter("search");

        if ("supprimer".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            produitDAO.deleteProduit(id);
            response.sendRedirect("menu");
            return;
        }

        List<Produit> produits;

        //  Si une recherche est saisie
        if (search != null && !search.trim().isEmpty()) {
            produits = produitDAO.findAll().stream()
                    .filter(p -> p.getNom().toLowerCase().contains(search.toLowerCase())
                    || p.getCategorie().toLowerCase().contains(search.toLowerCase()))
                    .toList();
            System.out.println("Recherche avec le mot-clé : " + search);
        } // Sinon filtre par catégorie
        else if (categorie != null && !categorie.isEmpty()) {
            produits = produitDAO.findByCategorie(categorie);
        } // Sinon afficher tous les produits
        else {
            produits = produitDAO.findAll();
        }

        System.out.println("produits = " + produits.size());
        request.setAttribute("produits", produits);
        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }

}
