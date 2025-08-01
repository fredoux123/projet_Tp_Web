document.addEventListener('DOMContentLoaded', () => {
    let count = 0;
    const cartCount = document.getElementById('cart-count');
    const buttons = document.querySelectorAll('.commander-btn');

    buttons.forEach(btn => {
        btn.addEventListener('click', () => {
            count++;
            cartCount.textContent = count;
        });
    });
});
