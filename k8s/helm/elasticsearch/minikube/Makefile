default: test

RELEASE := helm-es-minikube
TIMEOUT := 1200s

install:
	helm upgrade --debug --wait --timeout=$(TIMEOUT) --install  --values ../values.yaml --values values.local.yaml $(RELEASE) ../../../../charts/elasticsearch/dependencies/helm-charts/elasticsearch/

test: install
	helm test $(RELEASE)

purge:
	helm del $(RELEASE)
	kubectl delete pvc --all

member:
	kubectl get pods --namespace=default -l app=elasticsearch-master