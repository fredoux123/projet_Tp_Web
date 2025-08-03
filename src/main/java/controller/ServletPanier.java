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
    Produit produit = produitDAO.findById(id);
    // Ajout au panier (inchangée)
    HttpSession session = request.getSession();
    List<Produit> panier = (List<Produit>) session.getAttribute("panier");
    if (panier == null) {
        panier = new ArrayList<>();
    }
    boolean found = false;
    for (Produit p : panier) {
        if (p.getId() == produit.getId()) {
            p.setQuantite(p.getQuantite() + 1);
            found = true;
            break;
        }
    }
    if (!found) {
        produit.setQuantite(1);
        panier.add(produit);
    }
    session.setAttribute("panier", panier);

    // Redirection intelligente
    String goBack = request.getParameter("goBack");
    if ("details".equals(goBack)) {
        response.sendRedirect("detailsProduit?id=" + id);
    } else {
        response.sendRedirect("menu");
    }
}

}
