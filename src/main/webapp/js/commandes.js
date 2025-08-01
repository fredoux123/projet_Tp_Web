// commandes.js

function loadCommandes(searchId = "") {
  fetch("rechercheCommande?searchId=" + encodeURIComponent(searchId))
    .then(resp => resp.text())
    .then(html => {
      const container = document.getElementById("table-container");
      if (container) {
        container.innerHTML = html;
      }
    })
    .catch(err => {
      const container = document.getElementById("table-container");
      if (container) {
        container.innerHTML =
          "<div class='alert alert-danger'>Erreur lors du chargement des commandes.</div>";
      }
      console.error(err);
    });
}

document.addEventListener("DOMContentLoaded", () => {
  const input = document.getElementById("searchId");
  if (input) {
    input.addEventListener("keyup", () => loadCommandes(input.value.trim()));
  }
  loadCommandes();
});
