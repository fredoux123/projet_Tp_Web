package controller;

import dao.ProduitDAOImpl;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ajouterPanier")
public class ServletPanier extends HttpServlet {

    private ProduitDAOImpl produitDAO;

    @Override
    public void init() {
        produitDAO = new ProduitDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Produit nouveauProduit = produitDAO.findById(id);

        HttpSession session = request.getSession();
        List<Produit> panier = (List<Produit>) session.getAttribute("panier");

        if (panier == null) {
            panier = new ArrayList<>();
        }

        boolean existeDeja = false;

        for (Produit p : panier) {
            if (p.getId() == nouveauProduit.getId()) {
                p.setQuantite(p.getQuantite() + 1); //  Incrémente la quantité
                existeDeja = true;
                break;
            }
        }

        if (!existeDeja) {
            nouveauProduit.setQuantite(1); //  1ère fois qu'on l'ajoute
            panier.add(nouveauProduit);
        }

        session.setAttribute("panier", panier);
        response.sendRedirect("menu");
    }

}
