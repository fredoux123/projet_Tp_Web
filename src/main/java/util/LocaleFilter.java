package util;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebFilter("/*")
public class LocaleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        // Toujours définir l'encodage en premier
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        res.setContentType("text/html; charset=UTF-8");

        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();

        String langParam = request.getParameter("lang");
        Locale locale;

        if (langParam != null && !langParam.isEmpty()) {
            locale = new Locale(langParam);
            session.setAttribute("lang", langParam);
        } else {
            String sessionLang = (String) session.getAttribute("lang");
            if (sessionLang != null) {
                locale = new Locale(sessionLang);
            } else {
                locale = new Locale("fr"); // langue par défaut
                session.setAttribute("lang", "fr");
            }
        }

        try {
            ResourceBundle bundle = ResourceBundle.getBundle("i18n.messages", locale);
            session.setAttribute("bundle", bundle);
        } catch (MissingResourceException e) {
            e.printStackTrace(); // Pour voir l’erreur dans les logs
            // fallback vers le français si erreur
            session.setAttribute("bundle", ResourceBundle.getBundle("i18n.messages", new Locale("fr")));
            session.setAttribute("lang", "fr");
        }

        chain.doFilter(req, res);
    }
}

