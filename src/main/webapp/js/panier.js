document.addEventListener('DOMContentLoaded', () => {
    const buttons = document.querySelectorAll('.commander-btn');
    const cartCount = document.getElementById('cart-count');

    buttons.forEach(button => {
        button.addEventListener('click', async () => {
            const id = button.getAttribute('data-id');

            try {
                const response = await fetch(`ajouterPanier?id=${id}`, {
                    method: 'GET'
                });

                if (response.ok) {
                    // 🔄 Mise à jour du compteur (incrément localement)
                    let currentCount = parseInt(cartCount.textContent) || 0;
                    cartCount.textContent = currentCount + 1;
                } else {
                    alert("Erreur lors de l'ajout au panier");
                }
            } catch (error) {
                console.error("Erreur AJAX:", error);
                alert("Impossible d'ajouter au panier");
            }
        });
    });
});

