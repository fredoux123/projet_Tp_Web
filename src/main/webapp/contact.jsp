<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
    if (bundle == null) {
        // Chargement par défaut en français si aucune session n'est définie
        bundle = ResourceBundle.getBundle("messages", request.getLocale());
    }

    List<String> erreurs = (List<String>) request.getAttribute("erreurs");
    int panierCount = 0;
    List<?> panier = (List<?>) session.getAttribute("panier");
    if (panier != null)
        panierCount = panier.size();
%>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8" />
        <title><%= bundle.getString("contact.title")%></title>
        <link rel="stylesheet" href="css/styleMenu.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    </head>
    <body class="d-flex flex-column min-vh-100">

        <!-- Inclusion navbar -->
        <jsp:include page="includes/navbar.jsp" />

        <!-- Contenu principal -->
        <div class="container mt-4">
            <div class="row align-items-stretch">
                <!-- Colonne 1 : Infos -->
                <div class="col-sm-12 col-md-4 h-100">
                    <h4><%= bundle.getString("contact.heading")%></h4>
                    <p>
                        <strong><%= bundle.getString("contact.address.label")%></strong><br>
                        <%= bundle.getString("contact.address.value")%>
                    </p>
                    <p>
                        <strong><%= bundle.getString("contact.phone.label")%></strong><br>
                        <%= bundle.getString("contact.phone.value")%>
                    </p>
                    <p>
                        <strong><%= bundle.getString("contact.email.label")%></strong><br>
                        <a href="mailto:<%= bundle.getString("contact.email.value")%>">
                            <%= bundle.getString("contact.email.value")%>
                        </a>
                    </p>
                </div>

                <!-- Colonne 2 : Formulaire -->
                <div class="col-sm-12 col-md-4 h-100 d-flex flex-column">
                    <form id="contact-form" method="post" action="contact" class="d-flex flex-column h-100">
                        <div class="mb-3">
                            <input type="text" class="form-control" id="nom" name="nom" placeholder="<%= bundle.getString("contact.form.nom")%>"
                                   value="<%= request.getAttribute("nom") != null ? request.getAttribute("nom") : ""%>" />
                        </div>
                        <div class="mb-3">
                            <input type="text" class="form-control" id="prenom" name="prenom" placeholder="<%= bundle.getString("contact.form.prenom")%>"
                                   value="<%= request.getAttribute("prenom") != null ? request.getAttribute("prenom") : ""%>" />
                        </div>
                        <div class="mb-3">
                            <input type="email" class="form-control" id="email" name="email" placeholder="<%= bundle.getString("contact.form.email")%>"
                                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : ""%>" />
                        </div>
                        <div class="mb-3">
                            <textarea class="form-control" id="message" name="message" rows="4"
                                      placeholder="<%= bundle.getString("contact.form.message")%>"><%= request.getAttribute("message") != null ? request.getAttribute("message") : ""%></textarea>
                        </div>

                        <!-- Messages -->
                        <div id="form-message" class="mt-2">
                            <% if (request.getAttribute("messageSucces") != null) {%>
                            <div class="alert alert-success alert-dismissible fade show" role="alert" id="successMessage">
                                <%= bundle.getString("contact.success")%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                            </div>
                            <% } %>

                            <% if (request.getAttribute("erreurTechnique") != null) {%>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert" id="errorMessage">
                                <%= bundle.getString("contact.error.technique")%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                            </div>
                            <% } %>

                            <% if (erreurs != null && !erreurs.isEmpty()) { %>
                            <div class="alert alert-warning alert-dismissible fade show" role="alert" id="warningMessage">
                                <ul>
                                    <% for (String erreur : erreurs) {
                                            switch (erreur) {
                                                case "Le prénom est obligatoire.":
                                                    out.print("<li>" + bundle.getString("contact.error.prenom") + "</li>");
                                                    break;
                                                case "Le nom est obligatoire.":
                                                    out.print("<li>" + bundle.getString("contact.error.nom") + "</li>");
                                                    break;
                                                case "L'email est obligatoire.":
                                                    out.print("<li>" + bundle.getString("contact.error.email") + "</li>");
                                                    break;
                                                case "Le message est obligatoire.":
                                                    out.print("<li>" + bundle.getString("contact.error.message") + "</li>");
                                                    break;
                                                default:
                                                    out.print("<li>" + erreur + "</li>");
                                        }
                                    } %>
                                </ul>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                            </div>
                            <% }%>
                        </div>

                        <button type="submit" class="btn btn-dark btn-envoyer mt-auto">
                            <%= bundle.getString("contact.form.envoyer")%>
                        </button>
                    </form>
                </div>

                <!-- Colonne 3 : Carte -->
                <div class="col-sm-12 col-md-4 h-100">
                    <img src="images/cofee_map.JPG"
                         alt="<%= bundle.getString("contact.map.alt")%>"
                         class="w-100 h-100"
                         style="object-fit: cover;" />
                </div>
            </div>

            <hr class="my-5" />

            <!-- Image supplémentaire -->
            <div class="row text-center mb-5">
                <div>
                    <img src="images/image-acceuil.jpg" class="img-fluid img-offre" alt="<%= bundle.getString("contact.image.alt")%>" />
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/contact.js"></script>
    </body>
</html>
