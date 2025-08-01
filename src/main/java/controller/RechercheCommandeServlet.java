package controller;

import dao.CommandeDAO;
import dao.CommandeDAOImpl;
import model.Commande;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ResourceBundle;

@WebServlet("/rechercheCommande")
public class RechercheCommandeServlet extends HttpServlet {
    private CommandeDAO commandeDAO;

    @Override
    public void init() {
        commandeDAO = new CommandeDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Vérifie rôle admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Récupère le bundle pour traductions
        ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");

        String searchId = request.getParameter("searchId");
        List<Commande> liste;
        if (searchId != null && !searchId.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(searchId);
                Commande c = commandeDAO.findById(id);
                liste = (c != null) ? List.of(c) : List.<Commande>of();
            } catch (NumberFormatException e) {
                liste = List.of();
            }
        } else {
            liste = commandeDAO.findAll();
        }

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (liste.isEmpty()) {
            out.println("<div class='alert alert-warning'>" + bundle.getString("orders.notfound") + "</div>");
        } else {
            out.println("<table class='table table-bordered table-striped'>");
            out.println("<thead class='table-dark'><tr>");
            out.printf("<th>%s</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th></tr></thead><tbody>",
                bundle.getString("orders.table.id"),
                bundle.getString("orders.table.user_id"),
                bundle.getString("orders.table.date"),
                bundle.getString("orders.table.amount"),
                bundle.getString("orders.table.actions"));

            for (Commande c : liste) {
                out.println("<tr>");
                out.printf("<td>%d</td><td>%s (%s)</td><td>%s</td><td>%.2f $</td>",
                    c.getId(),
                    c.getUtilisateurNom(),
                    c.getUtilisateurEmail(),
                    c.getDateCommande(),
                    c.getMontant());
                out.printf("<td><a href='detailsCommande?id=%d' class='btn btn-sm btn-info'>%s</a></td>",
                    c.getId(), bundle.getString("button.details"));
                out.println("</tr>");
            }

            out.println("</tbody></table>");
        }
        out.close();
    }
}
