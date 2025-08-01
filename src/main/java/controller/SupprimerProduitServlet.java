
package controller;

import dao.ProduitDAOImpl;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/supprimerProduit")
public class SupprimerProduitServlet extends HttpServlet {

    private ProduitDAOImpl produitDAO;

    @Override
    public void init() {
        produitDAO = new ProduitDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        produitDAO.deleteProduit(id);
        request.getSession().setAttribute("messageSucces", "Produit supprimé avec succès !");
        response.sendRedirect("menu");
    }
}
