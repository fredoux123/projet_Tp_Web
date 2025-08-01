package controller;

import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/supprimerDuPanier")
public class SupprimerDuPanierServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();

        List<Produit> panier = (List<Produit>) session.getAttribute("panier");

        if (panier != null) {
            panier.removeIf(p -> p.getId() == id);
            session.setAttribute("panier", panier);
        }

        response.sendRedirect("panier.jsp");
    }
}
