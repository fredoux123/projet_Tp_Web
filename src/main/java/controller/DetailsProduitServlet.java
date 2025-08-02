package controller;

import dao.ProduitDAO;
import dao.ProduitDAOImpl;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/detailsProduit")
public class DetailsProduitServlet extends HttpServlet {

    private ProduitDAO produitDAO;

    @Override
    public void init() throws ServletException {
        produitDAO = new ProduitDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");

        if (idParam == null) {
            resp.sendRedirect("menu");
            return;
        }

        try {
            req.setCharacterEncoding("UTF-8");
            int id = Integer.parseInt(idParam);
            Produit produit = produitDAO.findById(id);

            if (produit == null) {
                req.setAttribute("error", "Produit introuvable");
            } else {
                req.setAttribute("produit", produit);
            }

            req.getRequestDispatcher("detailsProduit.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("menu");
        }
    }
}
