package controller;

import dao.CommandeDAO;
import dao.CommandeDAOImpl;
import model.Commande;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/commandes")
public class ListeCommandesServlet extends HttpServlet {

    private CommandeDAO commandeDAO;

    @Override
    public void init() {
        commandeDAO = new CommandeDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/accueil.jsp");
            return;
        }

        String searchIdParam = request.getParameter("searchId");
        List<Commande> commandes = new ArrayList<>();

        if (searchIdParam != null && !searchIdParam.trim().isEmpty()) {
            try {
                int searchId = Integer.parseInt(searchIdParam.trim());
                Commande commande = commandeDAO.findById(searchId);
                if (commande != null) {
                    commandes.add(commande);
                }
            } catch (NumberFormatException e) {
               
            }
        } else {
            commandes = commandeDAO.findAll();
        }

        request.setAttribute("commandes", commandes);
        request.getRequestDispatcher("/WEB-INF/admin/listeCommandes.jsp").forward(request, response);
    }
}
