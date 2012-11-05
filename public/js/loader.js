require.config({
    baseUrl: '/coffee',
    paths: {
        cs: '/js/lib/require/plugins/cs',
        'coffee-script': '/js/lib/require/plugins/coffee-script',
    }
});

require(['cs!app'], function(app) {
});