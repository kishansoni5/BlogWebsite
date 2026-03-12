// Auto hide error message after 4 seconds
document.addEventListener('DOMContentLoaded', function () {
    const errorBox = document.querySelector('.error-box');
    if (errorBox) {
        setTimeout(function () {
            errorBox.style.transition = 'opacity 0.5s ease';
            errorBox.style.opacity = '0';
            setTimeout(() => errorBox.remove(), 500);
        }, 4000);
    }
});