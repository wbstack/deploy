### Standard HTTPS in k8s

TBA docs..

### Custom Domains

#####Extra ingress / domains in ingress?
Right now the mediawiki ingress in k8s is just mediawiki.opencura.com which needs to change.

Better would be to have an ingress by default with NO hosts specified (if that is allowed)
Otherwise just add some null / foobar one..?

OR create an ingress per domain,... (probably best, easier to control)

The reading, specifically step7...
https://github.com/jetstack/cert-manager/blob/master/docs/tutorials/acme/quick-start/index.rst
And the example of multiple tls hosts in an ingress:
https://github.com/kubernetes/ingress-nginx/blob/master/docs/examples/multi-tls/multi-tls.yaml

```
spec:
  tls:
  - hosts:
    - domain1.com
    secretName: domain1.com-tls
  - hosts:
    - foobar.com
    secretName: foobar.com-tls
  rules:
  - host: domain1.com
    http:
      paths:
      - path: /servicePath
        backend:
          serviceName: servicename
          servicePort: 80
  - host: foobar.com
    http:
      paths:
      - path: /servicePath
        backend:
          serviceName: servicename
          servicePort: 80
```

#####VirtualServer and VirtualServerRoute
It sounds like the best way to support custom domains and HTTPS automagically would be
to use: https://github.com/nginxinc/kubernetes-ingress/blob/master/docs/virtualserver-and-virtualserverroute.md

The workflow of wiki creation would be:
 - Create a wiki and specify a domain
 - Write the details to the API DB, state PENDING_CREATION_ROUTING?
 - Contact the k8s API and create the VirtualServer AND TLS request for the domain?
 - Update the API DB, state PENDING_CREATION_HTTPS?
 - Check back and confirm TLS at some point, update status? NORMAL?

NOTE: maybe don't support name changes initially...?
Domain name changes would be:
 - API DB state to PENDING_NAMECHANGE_ROUTING? & update the domains records?
 - Create the new Virtual server? and TLS request?
 - Make sure the new virtual service is working?
 - PENDING_NAMECHANGE_HTTPS
 - Make sure new https is working?
 - PENDING_NAMECHANGE_CLEANUP
 - Remove old virtual server?
 - NORMAL ?

Restrictions:
 - Must be full specified domain, so wiki.foobar.com, then foobar.com or www. would not work

Notes:
 - Should we keep a record of all domain names used?
 - Should we keep redirects up for old renammed domains?
