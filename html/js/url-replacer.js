// Substitui URLs dinamicas baseadas em ENV_CONFIG
document.addEventListener('DOMContentLoaded', function() {
    // Links com data-sistema-url (MGsis, MGLara, MGUplon, etc)
    document.querySelectorAll('a[data-sistema-url]').forEach(function(link) {
        const path = link.getAttribute('data-sistema-url');
        link.href = ENV_CONFIG.SISTEMA_URL + path;
    });

    // Links com data-mgspa-url
    document.querySelectorAll('a[data-mgspa-url]').forEach(function(link) {
        const path = link.getAttribute('data-mgspa-url');
        link.href = ENV_CONFIG.MGSPA_URL + path;
    });

    // Links com data-pessoas-url
    document.querySelectorAll('a[data-pessoas-url]').forEach(function(link) {
        const path = link.getAttribute('data-pessoas-url');
        link.href = ENV_CONFIG.PESSOAS_URL + path;
    });

    // Links com data-negocios-url
    document.querySelectorAll('a[data-negocios-url]').forEach(function(link) {
        const path = link.getAttribute('data-negocios-url');
        link.href = ENV_CONFIG.NEGOCIOS_URL + path;
    });

    // Links com data-notas-url
    document.querySelectorAll('a[data-notas-url]').forEach(function(link) {
        const path = link.getAttribute('data-notas-url');
        link.href = ENV_CONFIG.NOTAS_URL + path;
    });
});
