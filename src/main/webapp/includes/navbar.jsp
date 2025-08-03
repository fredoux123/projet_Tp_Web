<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Produit, model.Utilisateur" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
    List<Produit> panier = (List<Produit>) session.getAttribute("panier");
    int panierCount = 0;
    if (panier != null) {
        for (Produit p : panier) panierCount += p.getQuantite();
    }
    String role = (String) session.getAttribute("role");
    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
    Integer nonLus = (Integer) session.getAttribute("nonLusCount");
    if(nonLus == null) nonLus = 0;
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light px-4">
  <a class="navbar-brand" href="accueil.jsp">☕ <%= bundle.getString("navbar.brand") %></a>
  <div class="collapse navbar-collapse">
    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      <li class="nav-item"><a class="nav-link" href="menu">📖<%= bundle.getString("navbar.menu") %></a></li>
      <li class="nav-item"><a class="nav-link" href="contact.jsp">📞<%= bundle.getString("navbar.contact") %></a></li>

      <% if ("admin".equals(role)) { %>
        <li class="nav-item position-relative">
          <a class="nav-link" href="messages">📬 <%= bundle.getString("navbar.messages") %>
            <% if (nonLus > 0) { %>
              <span class="badge rounded-pill bg-warning text-dark position-absolute top-25 start-100 translate-middle">
                <%= nonLus %>
              </span>
            <% } %>
          </a>
        </li>
      <% } %>
      
      <% 
   
    if ("admin".equals(role)) {
%>
    <li class="nav-item">
        <a class="nav-link" href="commandes">📋 <%= bundle.getString("navbar.orders") %></a>
    </li>
<% } %>


      <!--  Sélecteur de langue -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="langDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          🌐 <%= bundle.getString("navbar.language") %>
        </a>
        <ul class="dropdown-menu">
          <li><a class="dropdown-item" href="?lang=fr">🇫🇷 <%= bundle.getString("navbar.language.fr") %></a></li>
          <li><a class="dropdown-item" href="?lang=en">🇬🇧 <%= bundle.getString("navbar.language.en") %></a></li>
        </ul>
      </li>
    </ul>

    <a class="btn btn-outline-primary position-relative me-4" href="panier.jsp">
      🛒 <%= bundle.getString("navbar.cart") %>
      <span class="badge rounded-pill bg-danger position-absolute top-0 start-100 translate-middle">
        <%= panierCount %>
      </span>
    </a>

    <% if (user != null) { %>
      <span class="me-3">👤 <%= bundle.getString("navbar.welcome") %> <strong><%= user.getNom() %></strong> (<%= role %>)</span>
      <a class="btn btn-outline-danger" href="logout">🚪 <%= bundle.getString("navbar.logout") %></a>
    <% } else { %>
      <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#loginModal">
        <%= bundle.getString("navbar.login") %>
      </button>
    <% } %>
  </div>
</nav>

