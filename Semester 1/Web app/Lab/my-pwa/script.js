if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('./serviceWorker.js')
            .then(registration => {
                console.log('ServiceWorker registration successful:', registration.scope);
            })
            .catch(err => {
                console.error('ServiceWorker registration failed:', err);
            });
    });
}

window.addEventListener('online', updateOnlineStatus);
window.addEventListener('offline', updateOnlineStatus);

function updateOnlineStatus() {
    const statusDiv = document.getElementById('offline-status');
    if (navigator.onLine) {
        statusDiv.hidden = true;
    } else {
        statusDiv.hidden = false;
    }
}
