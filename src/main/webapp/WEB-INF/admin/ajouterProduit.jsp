<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
%>

<%
    List<String> erreurs = (List<String>) request.getAttribute("erreurs");
    String erreurTechnique = (String) request.getAttribute("erreurTechnique");
%>

<% if (erreurTechnique != null) {%>
<div class="alert alert-danger"><%= erreurTechnique%></div>
<% } %>

<% if (erreurs != null && !erreurs.isEmpty()) { %>
<div class="alert alert-warning">
    <ul>
        <% for (String err : erreurs) {%>
        <li><%= err%></li>
            <% } %>
    </ul>
</div>
<% }%>

<!DOCTYPE html>
<html>
    <head>
        <title><%= bundle.getString("produit.title.add")%></title>
        <link rel="stylesheet" href="./css/styleMenu.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-LN+7fdVzj6u52u30Kp6jO...5mcr" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ...O5Q" crossorigin="anonymous"></script>
    </head>
    <body class="d-flex flex-column min-vh-100">

        <!--  Inclusion de la barre de navigation -->
        <jsp:include page="/includes/navbar.jsp" />

        <div class="container mt-4">
            <h3>➕ <%= bundle.getString("produit.header.add")%></h3>
            <form method="post" action="ajouterProduit">
                <div class="mb-3">
                    <label for="nom" class="form-label"><%= bundle.getString("produit.label.nom")%></label>
                    <input type="text" class="form-control" name="nom" required
                           value="<%= request.getAttribute("nom") != null ? request.getAttribute("nom") : ""%>">
                </div>

                <div class="mb-3">
                    <label for="categorie" class="form-label"><%= bundle.getString("produit.label.categorie")%></label>
                    <select class="form-select" name="categorie" required>
                        <%
                            String selectedCat = (String) request.getAttribute("categorie");
                            String[] categories = {"Plat", "Boisson", "Dessert"};
                            for (String cat : categories) {
                        %>
                        <option value="<%= cat%>" <%= cat.equals(selectedCat) ? "selected" : ""%>><%= cat%></option>
                        <% }%>
                    </select>
                </div>


                <div class="mb-3">
                    <label for="prix" class="form-label"><%= bundle.getString("produit.label.prix")%></label>
                    <input type="number" step="0.01" class="form-control" name="prix" required
                           value="<%= request.getAttribute("prix") != null ? request.getAttribute("prix") : ""%>">
                </div>

                <div class="mb-3">
                    <label><%= bundle.getString("produit.label.description")%></label>
                    <textarea class="form-control" name="description" required><%= request.getAttribute("description") != null ? request.getAttribute("description") : ""%></textarea>
                </div>

                <div class="mb-3">
                    <label><%= bundle.getString("produit.label.image")%></label>
                    <input type="text" class="form-control" name="image"
                           value="<%= request.getAttribute("image") != null ? request.getAttribute("image") : ""%>">
                </div>

                <button type="submit" class="btn btn-primary"><%= bundle.getString("produit.button.add")%></button>
            </form>
        </div>

        <jsp:include page="/includes/footer.jsp" />
    </body>
</html>
