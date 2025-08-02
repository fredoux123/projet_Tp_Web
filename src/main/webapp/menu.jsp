<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Produit, model.Utilisateur" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
%>

<%
    List<Produit> produits = (List<Produit>) request.getAttribute("produits");
    String role = (String) session.getAttribute("role");
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

    String cat = request.getParameter("categorie");
    String search = request.getParameter("search");

    String messageSucces = (String) session.getAttribute("messageSucces");
    if (messageSucces != null) {
        request.setAttribute("messageSucces", messageSucces);
        session.removeAttribute("messageSucces");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= bundle.getString("menu.title")%></title>
        <link rel="stylesheet" href="css/styleMenu.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .card-footer .btn {
                margin: 2px;
            }
            .card {
                min-height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .card-body {
                flex-grow: 1;
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">

        <jsp:include page="includes/navbar.jsp" />
        <jsp:include page="includes/modals.jsp" />

        <div class="container mt-4">

            <!--  Message de succès -->
            <% if (request.getAttribute("messageSucces") != null) {%>
            <div class="alert alert-success alert-dismissible fade show" role="alert" id="successMessage">
                <%= bundle.getString("menu.success.message")%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="<%= bundle.getString("menu.close")%>"></button>
            </div>
            <% }%>

            <!--  Filtrage + Recherche + Ajouter produit -->
            <div class="row mb-4 justify-content-center align-items-center g-2 flex-wrap">
                <!-- Boutons Catégorie -->
                <div class="col-lg-auto col-md-12 text-center">
                    <div class="btn-group mb-2 mb-lg-0" role="group" aria-label="<%= bundle.getString("menu.filters.category")%>">
                        <a href="menu" class="btn <%= (cat == null || cat.isEmpty()) ? "btn-primary" : "btn-outline-primary"%>">🛒 <%= bundle.getString("menu.category.all")%></a>
                        <a href="menu?categorie=boisson" class="btn <%= "boisson".equalsIgnoreCase(cat) ? "btn-info" : "btn-outline-info"%>">🥤 <%= bundle.getString("menu.category.drink")%></a>
                        <a href="menu?categorie=plat" class="btn <%= "plat".equalsIgnoreCase(cat) ? "btn-success" : "btn-outline-success"%>">🍽️ <%= bundle.getString("menu.category.dish")%></a>
                        <a href="menu?categorie=dessert" class="btn <%= "dessert".equalsIgnoreCase(cat) ? "btn-warning" : "btn-outline-warning"%>">🍰 <%= bundle.getString("menu.category.dessert")%></a>
                    </div>
                </div>

                <!-- Recherche -->
                <div class="col-lg col-md-8">
                    <form class="input-group" method="get" action="menu">
                        <input type="text" name="search" class="form-control" placeholder="<%= bundle.getString("menu.search.placeholder")%>" value="<%= search != null ? search : ""%>">
                        <button class="btn btn-primary" type="submit">🔍</button>
                        <a href="menu" class="btn btn-outline-secondary">↺</a>
                    </form>
                </div>

                <!-- Ajouter Produit -->
                <% if ("admin".equals(role)) {%>
                <div class="col-lg-auto col-md-12 text-center mt-2 mt-lg-0">
                    <a href="ajouterProduit" class="btn btn-outline-success w-100">
                        ➕ <%= bundle.getString("menu.add.product")%>
                    </a>
                </div>
                <% } %>
            </div>

            <!-- 🔽 Affichage produits -->
            <% if (produits == null || produits.isEmpty()) {%>
            <div class="alert alert-warning"><%= bundle.getString("menu.no.products")%></div>
            <% } else { %>
            <div class="row">
                <% for (Produit p : produits) {%>
                <div class="col-md-4 mb-4 d-flex">
                    <div class="card w-100">
                        <img src="images/<%= p.getImage()%>" class="card-img-top" alt="<%= p.getNom()%>" style="height:200px;object-fit:cover;">
                        <div class="card-body">
                            <h5 class="card-title"><%= p.getNom()%></h5>
                            <p class="card-text"><%= p.getDescription()%></p>
                            <p class="fw-bold"><%= p.getPrix()%> $</p>
                        </div>
<div class="card-footer d-flex flex-wrap justify-content-center">

    <%-- Bouton Commander (clients uniquement) --%>
    <% if (utilisateur != null && !"admin".equals(role)) { %>
        <button type="button" class="btn btn-outline-success btn-sm commander-btn" data-id="<%= p.getId()%>">
            <%= bundle.getString("menu.button.order")%> 🛒
        </button>
    <% } else if (utilisateur == null) { %>
        <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#connexionModal">
            <%= bundle.getString("menu.button.order")%> 🛒
        </button>
    <% } %>

    <%-- Bouton Détails (accessible à tous) --%>
    <a href="detailsProduit?id=<%= p.getId()%>" class="btn btn-outline-primary btn-sm">
        <%= bundle.getString("menu.button.details")%> 🔍
    </a>

    <%-- Actions Admin : Modifier / Supprimer --%>
    <% if ("admin".equals(role)) { %>
        <a href="editProduit?id=<%= p.getId()%>" class="btn btn-outline-warning btn-sm">
            <%= bundle.getString("menu.button.edit")%>
        </a>
        <form method="post" action="supprimerProduit" onsubmit="return confirm('<%= bundle.getString("menu.confirm.delete")%>');" class="d-inline">
            <input type="hidden" name="id" value="<%= p.getId()%>">
            <button type="submit" class="btn btn-outline-danger btn-sm">
                <%= bundle.getString("menu.button.delete")%>
            </button>
        </form>
    <% } %>

</div>

                    </div>
                </div>
                <% } %>
            </div>
            <% }%>
        </div>

        <!-- Modal Connexion requise -->
        <div class="modal fade" id="connexionModal" tabindex="-1" aria-labelledby="connexionLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-danger" id="connexionLabel"><%= bundle.getString("menu.modal.login.title")%></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="<%= bundle.getString("menu.close")%>"></button>
                    </div>
                    <div class="modal-body">
                        <%= bundle.getString("menu.modal.login.message")%>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" id="openLoginFromConnexion"><%= bundle.getString("menu.modal.login.button.login")%></button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><%= bundle.getString("menu.modal.login.button.cancel")%></button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/menu.js"></script>

    </body>
</html>

