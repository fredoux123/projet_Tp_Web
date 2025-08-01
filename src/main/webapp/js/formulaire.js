document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('contact-form');
    const nom = document.getElementById('nom');
    const prenom = document.getElementById('prenom');
    const email = document.getElementById('email');
    const message = document.getElementById('message');
    const feedback = document.getElementById('form-message');

    form.addEventListener('submit', (e) => {
        e.preventDefault();

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (
            nom.value.trim() === '' ||
            prenom.value.trim() === '' ||
            email.value.trim() === '' ||
            message.value.trim() === ''
        ) {
            feedback.textContent = "❌ Tous les champs sont obligatoires.";
            feedback.className = "alert alert-danger mt-2";
        } else if (!emailPattern.test(email.value.trim())) {
            feedback.textContent = "❌ Veuillez entrer une adresse email valide.";
            feedback.className = "alert alert-warning mt-2";
        } else {
            feedback.textContent = "✅ Message envoyé avec succès !";
            feedback.className = "alert alert-success mt-2";
            form.reset(); // Réinitialiser les champs
        }
    });
});
