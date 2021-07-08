httpProxy = require('http-proxy');

// run the mediawiki docker containers requests through the local machine
// to reach the kubernetes NodePort
var proxy = httpProxy.createProxyServer({target:'http://192.168.49.2:30000'});

proxy.on('proxyReq', function(proxyReq, req, res, options) {
    console.log(req.method + ' ' + req.url);
});

proxy.listen(8234);