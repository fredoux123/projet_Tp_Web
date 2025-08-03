 document.addEventListener("DOMContentLoaded", () => {
    // Commander
    document.querySelectorAll(".commander-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        const id = btn.getAttribute("data-id");
        window.location.href = "ajouterPanier?id=" + id;
      });
    });
});
