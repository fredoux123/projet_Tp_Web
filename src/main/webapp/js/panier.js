document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('paymentForm');
    const exp = form.expDate;
    const card = form.cardNumber;
    const name = form.querySelector('input[type="text"]:not([name])'); // champ nom sur la carte
    const cvv = form.cvv;

    const expFeedback = exp.nextElementSibling;
    const expiredMsg = exp.dataset.expiredMsg;
    const formatMsg = exp.dataset.formatMsg;

    exp.addEventListener('input', () => {
        exp.setCustomValidity('');
        exp.classList.remove('is-invalid');
        expFeedback.textContent = formatMsg;
    });

    form.addEventListener('submit', ev => {
        let valid = true;

        // === Validation du champ expDate ===
        const pattern = /^(0[1-9]|1[0-2])\/\d{2}$/;

        if (!pattern.test(exp.value)) {
            exp.setCustomValidity('invalid format');
            exp.classList.add('is-invalid');
            expFeedback.textContent = formatMsg;
            valid = false;
        } else {
            const [mm, yy] = exp.value.split('/').map(Number);
            const expiryDate = new Date(2000 + yy, mm - 1, 1);
            const now = new Date();
            const currentMonth = new Date(now.getFullYear(), now.getMonth(), 1);

            if (expiryDate < currentMonth) {
                exp.setCustomValidity('expired');
                exp.classList.add('is-invalid');
                expFeedback.textContent = expiredMsg;
                valid = false;
            } else {
                exp.setCustomValidity('');
                exp.classList.remove('is-invalid');
            }
        }

        // === Validation HTML5 classique pour les autres champs ===
        const fields = [card, name, cvv];
        fields.forEach(f => {
            if (!f.checkValidity()) {
                f.classList.add('is-invalid');
                valid = false;
            } else {
                f.classList.remove('is-invalid');
            }
        });

        if (!valid) {
            ev.preventDefault();
            ev.stopPropagation();
            form.classList.add('was-validated');
        }
    });
});
