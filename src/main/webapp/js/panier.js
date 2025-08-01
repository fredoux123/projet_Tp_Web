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