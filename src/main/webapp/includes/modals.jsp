<%@ page import="java.util.ResourceBundle" %>
<%
  ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
%>
<!-- MODAL LOGIN -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <form method="post" action="login">
        <div class="modal-header">
          <h5 class="modal-title" id="loginModalLabel"><%= bundle.getString("auth.login.title") %></h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label><%= bundle.getString("auth.label.email") %></label>
            <input type="email" name="email" class="form-control" required />
          </div>
          <div class="mb-3">
            <label><%= bundle.getString("auth.label.password") %></label>
            <input type="password" name="motDePasse" class="form-control" required />
          </div>
        </div>
        <div class="modal-footer d-flex flex-column align-items-start">
          <button type="submit" class="btn btn-primary w-100 mb-2"><%= bundle.getString("auth.login.button") %></button>
          <p class="mb-0"><%= bundle.getString("auth.login.noaccount") %>
            <a href="#" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#registerModal" data-bs-dismiss="modal">
              <%= bundle.getString("auth.register.link") %>
            </a>
          </p>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL REGISTER -->
<div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <form method="post" action="register">
        <div class="modal-header">
          <h5 class="modal-title" id="registerModalLabel"><%= bundle.getString("auth.register.title") %></h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label><%= bundle.getString("auth.label.name") %></label>
            <input type="text" name="nom" class="form-control" required />
          </div>
          <div class="mb-3">
            <label><%= bundle.getString("auth.label.email") %></label>
            <input type="email" name="email" class="form-control" required />
          </div>
          <div class="mb-3">
            <label><%= bundle.getString("auth.label.password") %></label>
            <input type="password" name="motDePasse" class="form-control" required />
          </div>
        </div>
        <div class="modal-footer d-flex flex-column align-items-start">
          <button type="submit" class="btn btn-success w-100 mb-2"><%= bundle.getString("auth.register.button") %></button>
          <p class="mb-0"><%= bundle.getString("auth.register.already") %>
            <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" data-bs-dismiss="modal">
              <%= bundle.getString("auth.login.link") %>
            </a>
          </p>
        </div>
      </form>
    </div>
  </div>
</div>