<%@page import="java.util.ResourceBundle"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Contact" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
%>

<%
    List<Contact> messages = (List<Contact>) request.getAttribute("messages");
    String messageSucces = (String) session.getAttribute("messageSucces");
    String messageErreur = (String) session.getAttribute("messageErreur");
%>

<!DOCTYPE html>
<html>
<head>
    <title>📬 <%= bundle.getString("message.title") %></title>
    <link rel="stylesheet" href="css/styleMenu.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">

<jsp:include page="/includes/navbar.jsp" />

<div class="container wide-container mt-4">
    <h3>📥 <%= bundle.getString("message.header") %></h3>

    <% if (messageSucces != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="successMessage">
            <%= messageSucces %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="<%= bundle.getString("message.close") %>"></button>
        </div>
        <% session.removeAttribute("messageSucces"); %>
    <% } %>

    <% if (messageErreur != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert" id="errorMessage">
            <%= messageErreur %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="<%= bundle.getString("message.close") %>"></button>
        </div>
        <% session.removeAttribute("messageErreur"); %>
    <% } %>

    <% if (messages == null || messages.isEmpty()) { %>
        <div class="alert alert-warning"><%= bundle.getString("message.no_messages") %></div>
    <% } else { %>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>👤 <%= bundle.getString("message.table.name") %></th>
                    <th>📧 <%= bundle.getString("message.table.email") %></th>
                    <th>💬 <%= bundle.getString("message.table.message") %></th>
                    <th>🗑️ <%= bundle.getString("message.table.action") %></th>
                    <th>✅ <%= bundle.getString("message.table.status") %></th>
                </tr>
            </thead>
            <tbody>
                <% for (Contact c : messages) { %>
                    <tr class="<%= !c.isLu() ? "table-warning" : "" %>">
                        <td><%= c.getNomComplet() %></td>
                        <td><%= c.getEmail() %></td>
                        <td><%= c.getMessage() %></td>
                        <td>
                            <form method="post" action="supprimerMessage" class="d-inline">
                                <input type="hidden" name="id" value="<%= c.getId() %>">
                                <button class="btn btn-sm btn-outline-danger" onclick="return confirm('<%= bundle.getString("message.confirm_delete") %>')">
                                    🗑️ <%= bundle.getString("message.delete") %>
                                </button>
                            </form>
                        </td>
                        <td>
                            <form method="post" action="marquerMessageLu" class="d-inline">
                                <input type="hidden" name="id" value="<%= c.getId() %>">
                                <% if (!c.isLu()) { %>
                                    <button class="btn btn-sm btn-outline-success">✔️ <%= bundle.getString("message.mark_read") %></button>
                                <% } else { %>
                                    <span class="badge bg-success">✅ <%= bundle.getString("message.read") %></span>
                                <% } %>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>

<jsp:include page="/includes/footer.jsp" />

<!--  Script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!--  Script pour fermer les messages automatiquement -->
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const success = document.getElementById("successMessage");
    if (success) {
      setTimeout(() => {
        bootstrap.Alert.getOrCreateInstance(success).close();
      }, 2000);
    }

    const error = document.getElementById("errorMessage");
    if (error) {
      setTimeout(() => {
        bootstrap.Alert.getOrCreateInstance(error).close();
      }, 2000);
    }
  });
</script>

</body>
</html>
