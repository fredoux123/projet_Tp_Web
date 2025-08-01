document.addEventListener("DOMContentLoaded", function () {
    const success = document.getElementById("successMessage");
    if (success) {
      setTimeout(() => {
        bootstrap.Alert.getOrCreateInstance(success).close();
      }, 2000);
    }

    const error = document.getElementById("errorMessage");
    if (error) {
      setTimeout(() => {
        bootstrap.Alert.getOrCreateInstance(error).close();
      }, 2000);
    }
  });