/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ContactDAO;
import dao.ContactDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Contact;

/**
 *
 * @author gorgu
 */
@WebServlet("/marquerMessageLu")
public class MarquerMessageLuServlet extends HttpServlet {

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
            contactDAO.marquerCommeLu(id);

            //  Recalcul du nombre de messages non lus
            int nonLusCount = 0;
            for (Contact contact : contactDAO.findAll()) {
                if (!contact.isLu()) {
                    nonLusCount++;
                }
            }

            //  Mise à jour de la session
            request.getSession().setAttribute("nonLusCount", nonLusCount);

            // Message de confirmation
            request.getSession().setAttribute("messageSucces", "📨 Message marqué comme lu.");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("messageErreur", "❌ Erreur lors du marquage.");
        }

        response.sendRedirect("messages");
    }
}
