/* global bootstrap, showLoginModal, loginErrorMessage, showRegisterModal, registerErrorMessage */

document.addEventListener("DOMContentLoaded", function () {
  // 🟢 Gestion login modal avec message
  if (showLoginModal && loginErrorMessage) {
    const modal = new bootstrap.Modal(document.getElementById('loginModal'));
    modal.show();
    const body = document.querySelector("#loginModal .modal-body");
    const div = document.createElement("div");
    div.className = "alert alert-danger";
    div.innerText = loginErrorMessage;
    body.prepend(div);
  }

  // 🟢 Gestion register modal avec message
  if (showRegisterModal && registerErrorMessage) {
    const modal = new bootstrap.Modal(document.getElementById('registerModal'));
    modal.show();
    const body = document.querySelector("#registerModal .modal-body");
    const div = document.createElement("div");
    div.className = "alert alert-danger";
    div.innerText = registerErrorMessage;
    body.prepend(div);
  }

  // 🟢 Auto-fermeture des alertes success
  const alert = document.getElementById("successAlert");
  if (alert) {
    setTimeout(() => {
      const bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
      bsAlert.close();
    }, 2000);
  }
});
