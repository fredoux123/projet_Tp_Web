package controller;

import dao.ProduitDAO;
import dao.ProduitDAOImpl;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/editProduit")
public class EditProduitServlet extends HttpServlet {

    private ProduitDAO produitDAO;

    @Override
    public void init() throws ServletException {
        produitDAO = new ProduitDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Vérification d'authentification et de rôle admin
        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null || !"admin".equals(role)) {
            resp.sendRedirect("login.jsp"); // Ou afficher une page 403
            return;
        }

        // Traitement normal après validation du rôle
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

            req.getRequestDispatcher("/WEB-INF/admin/editProduit.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("menu");
        }
    }
}
