package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // récupère la session si elle existe
        if (session != null) {
            session.invalidate(); // supprime l'ancienne session
        }

        // Redémarre une nouvelle session uniquement pour stocker le message
        HttpSession newSession = request.getSession(true); // recrée une session propre
        newSession.setAttribute("messageSucces", "auth.success.logout");

        response.sendRedirect("accueil.jsp"); // redirection
    }
}
