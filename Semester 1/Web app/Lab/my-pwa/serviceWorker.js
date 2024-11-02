const CACHE_NAME = 'pwa-cache-v1';
const ASSETS_TO_CACHE = [
    '/',
    '/index.html',
    '/styles.css',
    '/script.js',
    '/images/icon-192x192.png',
    '/images/icon-512x512.png'
];

self.addEventListener('install', event => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => {
                console.log('Cache opened');
                return Promise.all(
                    ASSETS_TO_CACHE.map(url => {
                        // Convert relative paths to absolute paths
                        const request = new Request(url, { mode: 'no-cors' });
                        return cache.add(request).catch(error => {
                            console.error(`Failed to cache ${url}:`, error);
                        });
                    })
                );
            })
            .catch(error => {
                console.error('Cache installation failed:', error);
            })
    );
});

self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.map(cacheName => {
                    if (cacheName !== CACHE_NAME) {
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
});

self.addEventListener('fetch', event => {
    event.respondWith(
        caches.match(event.request)
            .then(response => {
                return response || fetch(event.request);
            })
    );
});
