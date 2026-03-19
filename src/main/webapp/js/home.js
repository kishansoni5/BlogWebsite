// ── Auto-hide error banner after 4 seconds ─────────────
const errorBanner = document.getElementById('errorBanner');
if (errorBanner) {
    setTimeout(() => {
        errorBanner.style.transition = 'opacity 0.5s ease';
        errorBanner.style.opacity    = '0';
        setTimeout(() => errorBanner.remove(), 500);
    }, 4000);
}
