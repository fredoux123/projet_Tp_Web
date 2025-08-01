<%@page import="java.util.ResourceBundle"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Produit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
    if (bundle == null) {
        bundle = ResourceBundle.getBundle("messages", request.getLocale());
        session.setAttribute("bundle", bundle);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title><%= bundle.getString("cart.title")%></title>
        <link rel="stylesheet" href="css/styleMenu.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-LN+7fdVzj6u52u30Kp6jO...5mcr" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ...O5Q" crossorigin="anonymous"></script>

    </head>
    <body class="d-flex flex-column min-vh-100">
        <jsp:include page="includes/navbar.jsp" />
        <div class="container mt-5">
            <h2>🛒 <%= bundle.getString("cart.your_cart")%></h2>
            <%
    String messageSuccesKey = (String) session.getAttribute("messageSucces");
    if (messageSuccesKey != null && bundle.containsKey(messageSuccesKey)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= bundle.getString(messageSuccesKey) %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"
                aria-label="<%= bundle.getString("menu.close") %>"></button>
    </div>
<%
        session.removeAttribute("messageSucces");
    }
%>

            <%
                // Récupère la clé depuis la session
                String messagePaiementKey = (String) session.getAttribute("messagePaiement");
                if (messagePaiementKey != null && bundle.containsKey(messagePaiementKey)) {
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <!-- Affiche la valeur traduite -->
                <%= bundle.getString(messagePaiementKey)%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"
                        aria-label="<%= bundle.getString("menu.close")%>"></button>
            </div>
            <%
                    session.removeAttribute("messagePaiement");
                }
            %>

            <%
                List<Produit> panier = (List<Produit>) session.getAttribute("panier");
                Boolean paiementPret = (Boolean) session.getAttribute("paiementPret");
                if (paiementPret == null) {
                    paiementPret = false;
                }
                if (panier == null || panier.isEmpty()) {
            %>
            <div class="alert alert-warning"><%= bundle.getString("cart.empty")%></div>
            <%
            } else {
            %>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th><%= bundle.getString("cart.table.name")%></th>
                        <th><%= bundle.getString("cart.table.category")%></th>
                        <th><%= bundle.getString("cart.table.unit_price")%></th>
                        <th><%= bundle.getString("cart.table.quantity")%></th>
                        <th><%= bundle.getString("cart.table.total")%></th>
                        <th><%= bundle.getString("cart.table.delete")%></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        double total = 0;
                        for (Produit p : panier) {
                            double totalLigne = p.getPrix() * p.getQuantite();
                            total += totalLigne;
                    %>
                    <tr>
                        <td><%= p.getNom()%></td>
                        <td><%= p.getCategorie()%></td>
                        <td><%= String.format("%.2f", p.getPrix())%></td>
                        <td><%= p.getQuantite()%></td>
                        <td><%= String.format("%.2f", totalLigne)%> $</td>
                        <td>
                            <form method="post" action="supprimerDuPanier" style="display:inline;">
                                <input type="hidden" name="id" value="<%= p.getId()%>">
                                <button type="submit" class="btn btn-sm btn-outline-danger" title="<%= bundle.getString("cart.delete.tooltip")%>">
                                    🗑️
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="4" class="text-end"><%= bundle.getString("cart.total")%></th>
                        <th><%= String.format("%.2f", total)%> $</th>
                    </tr>
                </tfoot>

            </table>
            <% }%>

            <div class="row mt-4">
                <div class="col-md-4 mb-2">
                    <a href="menu" class="btn btn-primary w-100">
                        ⬅ <%= bundle.getString("cart.back_to_menu")%>
                    </a>
                </div>

                <div class="col-md-4 mb-2">
                    <form method="post" action="passerCommande">
                        <button type="submit" class="btn btn-success w-100"
                                <%= (panier == null || panier.isEmpty()) ? "disabled" : ""%>>
                            ✅ <%= bundle.getString("cart.place_order")%>
                        </button>
                    </form>
                </div>

                <div class="col-md-4 mb-2">
                    <button class="btn btn-outline-primary w-100"
                            data-bs-toggle="modal" data-bs-target="#paymentModal"
                            <%= paiementPret ? "" : "disabled"%>>
                        💳 <%= bundle.getString("cart.pay_now")%>
                    </button>
                </div>
            </div>

        </div>

        <!-- 💳 Modal de paiement -->
        <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form id="paymentForm" class="modal-content needs-validation" novalidate method="post" action="validerPaiement">
                    <div class="modal-header">
                        <h5 class="modal-title" id="paymentModalLabel"><%= bundle.getString("payment.title")%></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="<%= bundle.getString("menu.close")%>"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Nom sur la carte -->
                        <div class="mb-3">
                            <label class="form-label"><%= bundle.getString("payment.name")%></label>
                            <input type="text" class="form-control" required>
                        </div>
                        <!-- Numéro de carte -->
                        <div class="mb-3">
                            <label class="form-label"><%= bundle.getString("payment.card_number")%></label>
                            <input type="text" class="form-control" name="cardNumber"
                                   placeholder="1234 5678 9012 3456"
                                   pattern="\d{13,16}" required>
                            <div class="invalid-feedback"><%= bundle.getString("payment.invalid.card")%></div>
                        </div>
                        <!-- Date d'expiration + CVV -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><%= bundle.getString("payment.expiry")%> (MM/YY)</label>
                                <input type="text" class="form-control" name="expDate"
                                       placeholder="MM/YY"
                                       pattern="(?:0[1-9]|1[0-2])/[0-9]{2}"
                                       maxlength="5" required>
                                <div class="invalid-feedback"><%= bundle.getString("payment.invalid.expiry_format")%></div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><%= bundle.getString("payment.cvv")%></label>
                                <input type="text" class="form-control" name="cvv"
                                       placeholder="123" pattern="\d{3}" maxlength="3" required>
                                <div class="invalid-feedback"><%= bundle.getString("payment.invalid.cvv")%></div>
                            </div>
                        </div>
                        <p class="text-muted small mt-2">🔐 <%= bundle.getString("payment.note")%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary"><%= bundle.getString("payment.submit")%></button>
                    </div>
                </form>
            </div>
        </div>


        <jsp:include page="includes/footer.jsp" />
        <script>
// Validation HTML5 + gestion de l'expiration avec reset automatique du custom error
            (() => {
                const form = document.getElementById('paymentForm');
                const exp = form.expDate;

                // Dès que l'utilisateur tape, on réinitialise l'erreur personnalisée
                exp.addEventListener('input', () => {
                    exp.setCustomValidity('');
                });

                form.addEventListener('submit', ev => {
                    let valid = form.checkValidity();

                    if (exp.validity.valid) {
                        const [mm, yy] = exp.value.split('/').map(Number);
                        const expiryDate = new Date(2000 + yy, mm - 1, 1);
                        const now = new Date();
                        if (expiryDate < new Date(now.getFullYear(), now.getMonth(), 1)) {
                            exp.setCustomValidity('expired');
                            valid = false;
                            exp.nextElementSibling.textContent = '<%= bundle.getString("payment.invalid.expired")%>';
                        } else {
                            exp.setCustomValidity(''); // important pour lever l'erreur après correction
                        }
                    }

                    if (!valid) {
                        ev.preventDefault();
                        ev.stopPropagation();
                        form.classList.add('was-validated');
                    }
                });
            })();
        </script>

    </body>
</html>

<!-- Désactiver définitivement le bouton “Payer maintenant” après paiement -->
<% session.removeAttribute("paiementPret");%>


