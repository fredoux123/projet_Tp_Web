package controller;

import dao.ContactDAO;
import dao.ContactDAOImpl;
import model.Contact;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private ContactDAO contactDAO;

    @Override
    public void init() {
        contactDAO = new ContactDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("📩 Formulaire contact reçu !");
        request.setCharacterEncoding("UTF-8");

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        List<String> erreurs = new ArrayList<>();

        // Validation simple
        if (prenom == null || prenom.trim().isEmpty()) {
            erreurs.add("Le prénom est obligatoire.");
        }
        if (nom == null || nom.trim().isEmpty()) {
            erreurs.add("Le nom est obligatoire.");
        }
        if (email == null || email.trim().isEmpty()) {
            erreurs.add("L'email est obligatoire.");
        }
        if (message == null || message.trim().isEmpty()) {
            erreurs.add("Le message est obligatoire.");
        }

        if (!erreurs.isEmpty()) {
            // Renvoie au formulaire avec erreurs et valeurs remplies
            request.setAttribute("erreurs", erreurs);
            request.setAttribute("prenom", prenom);
            request.setAttribute("nom", nom);
            request.setAttribute("email", email);
            request.setAttribute("message", message);
            request.getRequestDispatcher("contact.jsp").forward(request, response);
            return;
        }

        // Création de l'objet contact
        String nomComplet = prenom + " " + nom;
        Contact contact = new Contact(nomComplet, email, message);

        try {
            contactDAO.save(contact);
            // Message de succès en session (pour affichage après redirection)
            request.getSession().setAttribute("messageSucces", "✅ Message envoyé avec succès !");
            response.sendRedirect("contact");  // Redirige pour éviter le repost du formulaire
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erreurTechnique", "Une erreur est survenue lors de l’envoi du message.");
            request.getRequestDispatcher("contact.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Transfert du message de succès de la session vers la requête (si présent)
        HttpSession session = request.getSession();
        String messageSucces = (String) session.getAttribute("messageSucces");
        if (messageSucces != null) {
            request.setAttribute("messageSucces", messageSucces);
            session.removeAttribute("messageSucces"); // éviter d'afficher plusieurs fois
        }

        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }

}
