 document.addEventListener("DOMContentLoaded", () => {
    // Commander
    document.querySelectorAll(".commander-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        const id = btn.getAttribute("data-id");
        window.location.href = "ajouterPanier?id=" + id;
      });
    });

    // Ouvrir modal de connexion
    const openLoginBtn = document.getElementById("openLoginFromConnexion");
    if (openLoginBtn) {
      openLoginBtn.addEventListener("click", function () {
        const connexionModal = bootstrap.Modal.getInstance(document.getElementById('connexionModal'));
        connexionModal.hide();
        const loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
        loginModal.show();
      });
    }

    // ✅ Auto-fermeture du message succès
    const successMessage = document.getElementById("successMessage");
    if (successMessage) {
      setTimeout(() => {
        const alert = bootstrap.Alert.getOrCreateInstance(successMessage);
        alert.close();
      }, 2000);
    }
  });