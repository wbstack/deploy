https://cert-manager.io/

**Debugging Orders**

https://docs.cert-manager.io/en/latest/reference/orders.html


quickstart with nginx ingress:
https://docs.cert-manager.io/en/release-0.10/tutorials/acme/quick-start/index.html
gcloud dns01 docs:
https://docs.cert-manager.io/en/latest/tasks/issuers/setup-acme/dns01/google.html

During development one can run into issues with the DNS API and IAM stuff if one
keeps deleting and recreating role accounts with the same name / email.
HENCE now the user account is dns01a or something... to fix an hours worth of debugging issues..


**Seeing on cluster details:**

See the certificate for the main domain:

kubectl describe certificate wbstack-com-tls

This will list the current status and any current orders that are occurring.

You can then get the details of the order:

kubectl describe order wbstack-com-tls-356876054

Which will list a collection of challenges.

You can see the details of the challenges

kubectl describe challenge wbstack-com-tls-356876054-0
kubectl describe challenge wbstack-com-tls-356876054-1

You can see if DNS challenges have made it to our DNS by gong to:

https://console.cloud.google.com/net-services/dns?cloudshell=false&project=wbstack
