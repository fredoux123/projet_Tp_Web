<%@ page import="model.Produit" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
    Produit produit = (Produit) request.getAttribute("produit");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Détails du produit</title>
    <link rel="stylesheet" href="../../css/styleMenu.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">

<jsp:include page="/includes/navbar.jsp" />

<div class="container mt-4">
    <h3>🔍 <%= bundle.getString("menu.button.details") %></h3>

    <% if (produit == null) { %>
        <div class="alert alert-danger">Produit introuvable</div>
    <% } else { %>
        <div class="card mb-3">
            <div class="row g-0">
                <div class="col-md-4">
                    <img src="images/<%= produit.getImage() %>" class="img-fluid rounded-start" alt="<%= produit.getNom() %>">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><%= produit.getNom() %></h5>
                        <p class="card-text"><strong>Catégorie :</strong> <%= produit.getCategorie() %></p>
                        <p class="card-text"><strong>Prix :</strong> <%= produit.getPrix() %> $</p>
                        <p class="card-text"><strong>Description :</strong> <%= produit.getDescription() %></p>
                        <a href="menu" class="btn btn-secondary mt-3">⬅ Retour</a>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>

<jsp:include page="/includes/footer.jsp" />
</body>
</html>
