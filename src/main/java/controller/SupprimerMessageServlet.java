package controller;

import dao.ContactDAO;
import dao.ContactDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/supprimerMessage")
public class SupprimerMessageServlet extends HttpServlet {

    private ContactDAO contactDAO;

    @Override
    public void init() {
        contactDAO = new ContactDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = (String) request.getSession().getAttribute("role");

        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("menu");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            contactDAO.delete(id);
            request.getSession().setAttribute("messageSucces", "Message supprimé !");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", "Erreur lors de la suppression !");
        }

        response.sendRedirect("messages");
    }
}
