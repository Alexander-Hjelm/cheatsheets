<!--ts-->
* [Definitions](kubernetes.md#definitions)
* [Create a minikube cluster](kubernetes.md#create-a-minikube-cluster)
* [Manage deployments](kubernetes.md#manage-deployments)
* [Manage pods](kubernetes.md#manage-pods)
* [View events](kubernetes.md#view-events)
* [Services](kubernetes.md#services)
   * [Expose](kubernetes.md#expose)
   * [Manage services](kubernetes.md#manage-services)
   * [Manage addons](kubernetes.md#manage-addons)

<!-- Added by: runner, at: Fri May 28 11:15:44 UTC 2021 -->

<!--te-->

# Definitions

- **Pod**: a group of one or more containers
- **Deployment**: checks on the health of your Pod and restarts the Pod's Container if it terminates.
- **minikube**: a kubernetes virtual machine

# Create a minikube cluster

```bash
minikube start
minikube dashboard
```

# Manage deployments

```bash
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
kubectl get deployments
kubectl delete deployment hello-node
```

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
