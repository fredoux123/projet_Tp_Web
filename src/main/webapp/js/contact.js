 document.addEventListener("DOMContentLoaded", function () {
                const alerts = ["successMessage", "errorMessage", "warningMessage"];
                alerts.forEach(id => {
                    const el = document.getElementById(id);
                    if (el) {
                        setTimeout(() => {
                            const alert = bootstrap.Alert.getOrCreateInstance(el);
                            alert.close();
                        }, 2000);
                    }
                });
            });