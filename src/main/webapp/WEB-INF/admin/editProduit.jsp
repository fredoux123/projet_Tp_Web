<%@page import="java.util.ResourceBundle"%>
<%@ page import="model.Produit" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
%>

<%
    List<String> erreurs = (List<String>) request.getAttribute("erreurs");
%>
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
        <title><%= bundle.getString("produit.title.edit")%></title>
        <link rel="stylesheet" href="css/styleMenu.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-LN+7fdVzj6u52u30Kp6jO...5mcr" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ...O5Q" crossorigin="anonymous"></script>
    </head>
    <body class="d-flex flex-column min-vh-100">

        <jsp:include page="/includes/navbar.jsp" />
        <div class="container mt-4">
            <h3>✏️ <%= bundle.getString("produit.header.edit")%></h3>

            <%
                Produit p = (Produit) request.getAttribute("produit");
                if (p == null) {
            %>
            <div class="alert alert-danger"><%= bundle.getString("produit.error.notfound")%></div>
            <%
            } else {
            %>
            <form method="post" action="modifierProduit">
                <input type="hidden" name="id" value="<%= p.getId()%>">

                <div class="mb-3">
                    <label><%= bundle.getString("produit.label.nom")%></label>
                    <input type="text" name="nom" class="form-control"
                           value="<%= request.getAttribute("nom") != null ? request.getAttribute("nom") : p.getNom()%>" required>
                </div>

                <div class="mb-3">
                    <label><%= bundle.getString("produit.label.categorie")%></label>
                    <select name="categorie" class="form-select" required>
                        <%
                            String selectedCat = (String) request.getAttribute("categorie");
                            if (selectedCat == null) {
                                selectedCat = p.getCategorie();
                            }
                            String[] categories = {"Plat", "Boisson", "Dessert"};
                            for (String cat : categories) {
                        %>
                        <option value="<%= cat%>" <%= cat.equalsIgnoreCase(selectedCat) ? "selected" : ""%>><%= cat%></option>
                        <%
                            }
                        %>
                    </select>
                </div>


                <div class="mb-3">
                    <label><%= bundle.getString("produit.label.prix")%> ($)</label>
                    <input type="number" step="0.01" name="prix" class="form-control"
                           value="<%= request.getAttribute("prix") != null ? request.getAttribute("prix") : p.getPrix()%>" required>
                </div>

                <div class="mb-3">
                    <label><%= bundle.getString("produit.label.description")%></label>
                    <textarea name="description" class="form-control"><%= request.getAttribute("description") != null ? request.getAttribute("description") : p.getDescription()%></textarea>
                </div>

                <div class="mb-3">
                    <label><%= bundle.getString("produit.label.image")%> (<%= bundle.getString("produit.label.imageFile")%>)</label>
                    <input type="text" name="image" class="form-control"
                           value="<%= request.getAttribute("image") != null ? request.getAttribute("image") : p.getImage()%>">
                </div>

                <button type="submit" class="btn btn-primary"><%= bundle.getString("produit.button.edit")%></button>
                <a href="menu" class="btn btn-secondary"><%= bundle.getString("produit.button.cancel")%></a>
            </form>
            <% }%>
        </div>
        <jsp:include page="/includes/footer.jsp" />
    </body>
</html>
