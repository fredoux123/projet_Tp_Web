package controller;

import dao.ContactDAO;
import dao.ContactDAOImpl;
import model.Contact;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/messages")
public class AdminMessagesServlet extends HttpServlet {

    private ContactDAO contactDAO;

    @Override
    public void init() {
        contactDAO = new ContactDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Vérification si l'utilisateur est connecté
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp"); // ou une page d'accès refusé
            return;
        }

        //  Vérification du rôle admin
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            response.sendRedirect("menu");
            return;
        }

        //  L'utilisateur est admin → récupération des messages
        List<Contact> messages = contactDAO.findAll();
        request.setAttribute("messages", messages);

        //  Mise à jour du nombre de messages non lus
        int nonLusCount = 0;
        for (Contact c : messages) {
            if (!c.isLu()) nonLusCount++;
        }
        session.setAttribute("nonLusCount", nonLusCount);

        // ️ Affichage de la page JSP
        request.getRequestDispatcher("/WEB-INF/admin/adminMessages.jsp").forward(request, response);
    }
}
