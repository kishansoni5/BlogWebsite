// post.js
// Currently minimal — single post view has no interactive behaviour.
// This file is here to keep the pattern consistent with other pages
// and ready for future features like reading time, share buttons, etc.

// ── Estimated reading time ─────────────────────────────
const postContent = document.querySelector('.post-content');
if (postContent) {
    const wordCount  = postContent.innerText.trim().split(/\s+/).length;
    const minutes    = Math.max(1, Math.round(wordCount / 200));
    const postMeta   = document.querySelector('.post-meta');

    if (postMeta) {
        const readTime    = document.createElement('span');
        readTime.className = 'post-readtime';
        readTime.textContent = `${minutes} min read`;

        const dot        = document.createElement('span');
        dot.className    = 'post-dot';
        dot.textContent  = '·';

        postMeta.appendChild(dot);
        postMeta.appendChild(readTime);
    }
}
