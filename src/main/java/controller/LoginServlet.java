package controller;

import dao.ContactDAO;
import dao.ContactDAOImpl;
import dao.UtilisateurDAO;
import dao.UtilisateurDAOImpl;
import model.Contact;
import model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() {
        utilisateurDAO = new UtilisateurDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");

        Utilisateur utilisateur = utilisateurDAO.findByEmailAndPassword(email, motDePasse);

        if (utilisateur != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateur);
            session.setAttribute("role", utilisateur.getRole());
            session.setAttribute("nom", utilisateur.getNom());

            // Si admin, calculer les messages non lus
            if ("admin".equals(utilisateur.getRole())) {
                ContactDAO contactDAO = new ContactDAOImpl();
                int nonLusCount = 0;
                for (Contact c : contactDAO.findAll()) {
                    if (!c.isLu()) {
                        nonLusCount++;
                    }
                }
                session.setAttribute("nonLusCount", nonLusCount);
            }

            //  Clé traduisible
            session.setAttribute("messageSucces", "auth.success.login");
            response.sendRedirect("accueil.jsp");

        } else {
            //  Clé traduisible
            request.setAttribute("erreur", "auth.error.credentials");
            request.setAttribute("loginModal", true);
            request.getRequestDispatcher("/accueil.jsp").forward(request, response);
        }
    }
}
