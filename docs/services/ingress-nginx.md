**The chart**

Docs for the chart: https://hub.helm.sh/charts/stable/nginx-ingress

The chart doesnt really have release notes that I can find.
Just make sure you diff the deployment...

**The service in the chart**

The chart deploys https://github.com/kubernetes/ingress-nginx

The changelog for the service is https://github.com/kubernetes/ingress-nginx/blob/master/Changelog.md

You should look at this whenever the chart would bump the image version.

**Updating the service**

 - Find a new version of the chart to update to
 - Read the RELNOTES of the chart and also the service if needed
   - You can figure out if the service changes byt doing `helmfile diff`
 - `helmfile apply` the update
 - Make sure the ingress points still load
