// ── Character counter for title ────────────────────────
const titleInput = document.getElementById('title');
const titleCount = document.getElementById('titleCount');

function updateTitleCount() {
    const len = titleInput.value.length;
    const max = 255;
    titleCount.textContent = `${len} / ${max}`;

    titleCount.classList.remove('warning', 'danger');
    if (len >= max) {
        titleCount.classList.add('danger');
    } else if (len >= max * 0.85) {
        titleCount.classList.add('warning');
    }
}

// Run on load in case of back-navigation restoring input value
updateTitleCount();
titleInput.addEventListener('input', updateTitleCount);


// ── Prevent double submit ──────────────────────────────
const postForm   = document.getElementById('postForm');
const submitBtn  = document.getElementById('submitBtn');
const btnText    = submitBtn.querySelector('.btn-text');
const btnLoading = submitBtn.querySelector('.btn-loading');

postForm.addEventListener('submit', function () {
    submitBtn.disabled = true;
    btnText.style.display    = 'none';
    btnLoading.style.display = 'inline';
});


// ── Auto-hide error banner after 4 seconds ─────────────
const errorBanner = document.getElementById('errorBanner');
if (errorBanner) {
    setTimeout(() => {
        errorBanner.style.transition = 'opacity 0.5s ease';
        errorBanner.style.opacity    = '0';
        setTimeout(() => errorBanner.remove(), 500);
    }, 4000);
}
