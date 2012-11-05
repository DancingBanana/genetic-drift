require.config({
    baseUrl: '/coffee',
    paths: {
        cs: '/js/lib/require/plugins/cs',
        'coffee-script': '/js/lib/require/plugins/coffee-script',
        boxbox: '/js/lib/boxbox/boxbox'
    },
    shim: {
        boxbox: {
            deps: ['/js/lib/boxbox/Box2dWeb-2.1.a.3'],
            exports: 'boxbox'
        }
    }
});

require(['cs!app'], function(app) {
});