package controller;

import dao.UtilisateurDAO;
import dao.UtilisateurDAOImpl;
import model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() {
        utilisateurDAO = new UtilisateurDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");

        if (nom == null || nom.trim().isEmpty() || nom.length() < 2) {
            request.setAttribute("registerErreur", "auth.register.error.name");
            request.setAttribute("registerModal", true);
            request.getRequestDispatcher("accueil.jsp").forward(request, response);
            return;
        }

        if (email == null || !email.matches("^[\\w-.]+@[\\w-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("registerErreur", "auth.register.error.email");
            request.setAttribute("registerModal", true);
            request.getRequestDispatcher("accueil.jsp").forward(request, response);
            return;
        }

        if (motDePasse == null || motDePasse.length() < 6) {
            request.setAttribute("registerErreur", "auth.register.error.password");
            request.setAttribute("registerModal", true);
            request.getRequestDispatcher("accueil.jsp").forward(request, response);
            return;
        }

        if (utilisateurDAO.findByEmail(email) != null) {
            request.setAttribute("registerErreur", "auth.register.error.email.exists");
            request.setAttribute("registerModal", true);
            request.getRequestDispatcher("accueil.jsp").forward(request, response);
            return;
        }

        Utilisateur nouvelUtilisateur = new Utilisateur(nom, email, motDePasse, "user");
        utilisateurDAO.save(nouvelUtilisateur);
        Utilisateur utilisateurAvecId = utilisateurDAO.findByEmail(email); 

        HttpSession session = request.getSession();
        session.setAttribute("utilisateur", utilisateurAvecId);
        session.setAttribute("role", "user");
        session.setAttribute("nom", nouvelUtilisateur.getNom());

       session.setAttribute("messageSucces", "auth.success.register"); 
        response.sendRedirect("accueil.jsp");
    }
}
