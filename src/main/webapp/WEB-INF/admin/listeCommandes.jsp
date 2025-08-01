<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ResourceBundle" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
    if (bundle == null) {
        bundle = ResourceBundle.getBundle("messages_fr");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= bundle.getString("orders.title") %></title>
    <link rel="stylesheet" href="css/styleMenu.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4">📦 <%= bundle.getString("orders.title") %></h2>

        <!--  Recherche en direct via keyup -->
        <input type="number" id="searchId" class="form-control mb-4"
               placeholder="<%= bundle.getString("orders.search.placeholder") %>" />

        <!-- Conteneur où sera injecté le tableau -->
        <div id="table-container">
            <div class="alert alert-info">⏳ Chargement des commandes...</div>
        </div>
    </div>

    <script>
    function loadCommandes(searchId = "") {
        fetch("rechercheCommande?searchId=" + encodeURIComponent(searchId))
          .then(resp => resp.text())
          .then(html => document.getElementById("table-container").innerHTML = html)
          .catch(err => {
            document.getElementById("table-container").innerHTML =
              "<div class='alert alert-danger'>Erreur lors du chargement des commandes.</div>";
            console.error(err);
          });
    }

    document.addEventListener("DOMContentLoaded", () => {
        const input = document.getElementById("searchId");
        input.addEventListener("keyup", () => loadCommandes(input.value.trim()));
        loadCommandes();
    });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
