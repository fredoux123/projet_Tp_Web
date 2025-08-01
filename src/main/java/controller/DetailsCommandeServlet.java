package controller;
import dao.CommandeDAO;
import dao.CommandeDAOImpl;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Commande;

@WebServlet("/detailsCommande")
public class DetailsCommandeServlet extends HttpServlet {
    private CommandeDAO dao;
    public void init(){ dao = new CommandeDAOImpl(); }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String sid = req.getParameter("id");
    if (sid == null) {
        resp.sendRedirect("commandes");
        return;
    }
    Commande c = dao.findById(Integer.parseInt(sid));
    if (c == null) {
        resp.sendRedirect("commandes");  // ou afficher un message param error
        return;
    }
    req.setAttribute("commande", c);
    req.getRequestDispatcher("/WEB-INF/admin/detailsCommande.jsp").forward(req, resp);
}
}
