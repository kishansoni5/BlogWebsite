document.addEventListener('DOMContentLoaded', function () {

    // Auto hide error message after 4 seconds
    const errorBox = document.querySelector('.error-box');
    if (errorBox) {
        setTimeout(function () {
            errorBox.style.transition = 'opacity 0.5s ease';
            errorBox.style.opacity = '0';
            setTimeout(() => errorBox.remove(), 500);
        }, 4000);
    }

    // Auto hide success message after 4 seconds
    const successBox = document.querySelector('.success-box');
    if (successBox) {
        setTimeout(function () {
            successBox.style.transition = 'opacity 0.5s ease';
            successBox.style.opacity = '0';
            setTimeout(() => successBox.remove(), 500);
        }, 4000);
    }
});