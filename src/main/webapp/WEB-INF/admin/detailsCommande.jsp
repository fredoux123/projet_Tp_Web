<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.Commande, model.DetailCommande, java.util.ResourceBundle" %>
<%@ page import="java.util.List" %>

<%
    Commande commande = (Commande) request.getAttribute("commande");
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
    if (bundle == null) {
        bundle = ResourceBundle.getBundle("messages_fr"); // fallback au français
    }
%>

<% if (commande == null) { %>
    <!DOCTYPE html>
    <html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title><%= bundle.getString("orders.notfound") %></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="d-flex flex-column min-vh-100">
    <jsp:include page="/includes/navbar.jsp" />
    <div class="container mt-5">
        <div class="alert alert-warning">
            <%= bundle.getString("orders.notfound") %>
        </div>
        <a href="commandes" class="btn btn-secondary">⬅ <%= bundle.getString("button.back") %></a>
    </div>
    <jsp:include page="/includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
<% } else { %>
    <!DOCTYPE html>
    <html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title><%= bundle.getString("orders.details.title") %> #<%= commande.getId() %></title>
        <link rel="stylesheet" href="css/styleMenu.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="d-flex flex-column min-vh-100">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4">📄 <%= bundle.getString("orders.details.title") %> #<%= commande.getId() %></h2>

        <div class="mb-3">
            <strong><%= bundle.getString("orders.details.client_name") %>:</strong> <%= commande.getUtilisateurNom() %><br>
            <strong><%= bundle.getString("orders.details.client_email") %>:</strong> <%= commande.getUtilisateurEmail() %><br>
            <strong><%= bundle.getString("orders.details.date") %>:</strong> <%= commande.getDateCommande() %>
        </div>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th><%= bundle.getString("orders.details.product_id") %></th>
                    <th><%= bundle.getString("orders.details.product_name") %></th>
                    <th><%= bundle.getString("orders.details.quantity") %></th>
                    <th><%= bundle.getString("orders.details.unit_price") %></th>
                    <th><%= bundle.getString("orders.details.line_total") %></th>
                </tr>
            </thead>
            <tbody>
                <%
                  double totalLignes = 0;
                  for (DetailCommande d : commande.getDetails()) {
                      double ligneTotal = d.getQuantite() * d.getPrixUnitaire();
                      totalLignes += ligneTotal;
                %>
                <tr>
                    <td><%= d.getProduitId() %></td>
                    <td><%= d.getProduitNom() %></td>
                    <td><%= d.getQuantite() %></td>
                    <td><%= String.format("%.2f", d.getPrixUnitaire()) %> $</td>
                    <td><%= String.format("%.2f", ligneTotal) %> $</td>
                </tr>
                <% } %>
            </tbody>
            <tfoot>
                <tr>
                    <th colspan="4" class="text-end"><%= bundle.getString("orders.details.total") %></th>
                    <th><%= String.format("%.2f", totalLignes) %> $</th>
                </tr>
            </tfoot>
        </table>

        <a href="commandes" class="btn btn-secondary mt-3">⬅ <%= bundle.getString("button.back") %></a>
    </div>

    <jsp:include page="/includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
<% } %>
