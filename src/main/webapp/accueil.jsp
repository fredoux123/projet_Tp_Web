<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Produit" %>
<%@ page import="java.util.ResourceBundle" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
    Boolean loginModal = (Boolean) request.getAttribute("loginModal");
    String erreur = (String) request.getAttribute("erreur");
    Boolean registerModal = (Boolean) request.getAttribute("registerModal");
    String registerErreur = (String) request.getAttribute("registerErreur");
%>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title><%= bundle.getString("home.title")%></title>
        <link rel="stylesheet" href="css/styleMenu.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="d-flex flex-column min-vh-100">

        <jsp:include page="includes/navbar.jsp" />
        <jsp:include page="includes/modals.jsp" />

        <%
            HttpSession currentSession = request.getSession(false);
            if (currentSession != null) {
                String messageSucces = (String) currentSession.getAttribute("messageSucces");
                if (messageSucces != null) {
                    request.setAttribute("messageSucces", messageSucces);
                    currentSession.removeAttribute("messageSucces");
                }
            }
        %>

        <% if (request.getAttribute("messageSucces") != null) {%>
        <div class="container mt-3">
            <div class="alert alert-success alert-dismissible fade show" role="alert" id="successAlert">
                <%= bundle.getString((String) request.getAttribute("messageSucces"))%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>
        <% }%>

        <!--  CONTENU -->
        <div class="container my-5 text-center">
            <h1 class="text-success mb-4">👋 <%= bundle.getString("home.welcome")%></h1>
            <img src="images/Bann2.jpg" class="img-fluid img-bann3 mb-4 mx-auto d-block" alt="Café du Centre">
            <p class="lead mx-auto w-75"><%= bundle.getString("home.description")%></p>
        </div>

        <div class="container mt-5 text-center">
            <h3><%= bundle.getString("home.promotions.title")%></h3>
            <h4 class="text-primary">☀️ <%= bundle.getString("home.promotions.summer")%></h4>
            <p class="mx-auto w-75"><%= bundle.getString("home.promotions.details")%></p>
            <div class="row g-3">
                <div class="col-6 col-md-3">
                    <img src="images/promo1.jpg" class="img-fluid same-size-image" alt="Promo 1">
                </div>
                <div class="col-6 col-md-3">
                    <img src="images/promo2.jpg" class="img-fluid same-size-image" alt="Promo 2">
                </div>
                <div class="col-6 col-md-3">
                    <img src="images/promo3.jpg" class="img-fluid same-size-image" alt="Promo 3">
                </div>
                <div class="col-6 col-md-3">
                    <img src="images/promo2.jpg" class="img-fluid same-size-image" alt="Promo 4">
                </div>
            </div>
        </div>

        <div class="container mt-5 text-center">
            <h3>🎶 <%= bundle.getString("home.music.title")%></h3>
            <p class="mx-auto w-75"><%= bundle.getString("home.music.details")%></p>
            <div class="row justify-content-center">
                <div class="col-md-6 mb-3">
                    <img src="images/Raina-Rai.jpg" class="img-fluid mx-auto d-block"
                         style="width: 100%; height: 300px; object-fit: cover;">
                </div>
                <div class="col-md-6 mb-3">
                    <img src="images/soiree.jpg" class="img-fluid mx-auto d-block"
                         style="width: 100%; height: 300px; object-fit: cover;">
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            const showLoginModal = <%= Boolean.TRUE.equals(loginModal)%>;
            const loginErrorMessage = <%= erreur != null ? "\"" + bundle.getString(erreur).replace("\"", "\\\"") + "\"" : "null"%>;

            const showRegisterModal = <%= Boolean.TRUE.equals(registerModal)%>;
            const registerErrorMessage = <%= registerErreur != null ? "\"" + bundle.getString(registerErreur).replace("\"", "\\\"") + "\"" : "null"%>;
        </script>
        <script src="js/accueil.js"></script>


    </body>
</html>
