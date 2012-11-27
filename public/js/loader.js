require.config({
    baseUrl: '/coffee',
    paths: {
        img: '/img',
        cs: '/js/lib/require/plugins/cs',
        'coffee-script': '/js/lib/require/plugins/coffee-script',
        image: '/js/lib/require/plugins/image',
        boxbox: '/js/lib/boxbox/boxbox',
        text: '/js/lib/require/plugins/text',
        json: '/js/lib/require/plugins/json'
    },
    shim: {
        boxbox: {
            deps: ['/js/lib/boxbox/Box2dWeb-2.1.a.3.js'],
            exports: 'boxbox'
        }
    }
});

require(['cs!app'], function(app) {
});