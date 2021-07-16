<!--ts-->
* [Definitions](kubernetes.md#definitions)
* [minikube](kubernetes.md#minikube)
* [Create a minikube cluster](kubernetes.md#create-a-minikube-cluster)
* [push docker image to minikube repository](kubernetes.md#push-docker-image-to-minikube-repository)
* [Manage deployments](kubernetes.md#manage-deployments)
   * [apply](kubernetes.md#apply)
   * [Specific deployment settings](kubernetes.md#specific-deployment-settings)
* [Manage pods](kubernetes.md#manage-pods)
* [View events](kubernetes.md#view-events)
* [Services](kubernetes.md#services)
   * [Expose](kubernetes.md#expose)
   * [Manage services](kubernetes.md#manage-services)
   * [Manage addons](kubernetes.md#manage-addons)
* [Secrets](kubernetes.md#secrets)
   * [Add certificate as secret](kubernetes.md#add-certificate-as-secret)
* [Debug](kubernetes.md#debug)

<!-- Added by: runner, at: Fri Jul 16 10:45:47 UTC 2021 -->

<!--te-->

# Definitions

- **Pod**: a group of one or more containers
- **Deployment**: checks on the health of your Pod and restarts the Pod's Container if it terminates.
- **minikube**: a kubernetes virtual machine

# minikube

# Create a minikube cluster

```bash
minikube start
minikube dashboard
```

# push docker image to minikube repository
After building an image locally, you need to push it to the minikube repository before the pods can find it.
```bash
minikube cache add secret-scanner/web:latest
```

# Manage deployments

```bash
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
kubectl get deployments
kubectl delete deployment hello-node
```

## apply
```bash
kubectl apply -f api-deployment.yaml --namespace uat
```

## Specific deployment settings
- **imagePullPolicy: Never/Always**, should the pod pull a new image from upon restart?

# Manage pods

```bash
kubectl get pods
```

# View events

```bash
kubectl get events
```

# Services

## Expose
Expose the pod to the public internet. The --type=LoadBalancer flag indicates that you want to expose your Service outside of the cluster.
```bash
kubectl expose deployment hello-node --type=LoadBalancer --port=8080
```

## Manage services
```bash
kubectl get services
kubectl delete service hello-node
```

## Manage addons
```bash
minikube addons list
minikube addons enable metrics-server
minikube addons disable metrics-server
```

# Secrets

## Add certificate as secret
```bash
kubectl create secret tls knote-ingress-tls --namespace uat --key knote-ingress-tls.key --cert knote-ingress-tls.crt
```

# Debug
Debug certificates.
```bash
kubectl logs pod/ingress-nginx-controller-5d88495688-nb9x7 -n ingress-nginx | grep cert
```
