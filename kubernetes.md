<!--ts-->
* [Definitions](kubernetes.md#definitions)
* [minikube](kubernetes.md#minikube)
   * [Create a minikube cluster](kubernetes.md#create-a-minikube-cluster)
   * [Images](kubernetes.md#images)
      * [push docker image to minikube repository](kubernetes.md#push-docker-image-to-minikube-repository)
      * [List images in the minikube repositiry](kubernetes.md#list-images-in-the-minikube-repositiry)
      * [Build an image directly to the minikube repository](kubernetes.md#build-an-image-directly-to-the-minikube-repository)
* [Manage namespace](kubernetes.md#manage-namespace)
   * [Get namespaces](kubernetes.md#get-namespaces)
   * [Set context / set namespace](kubernetes.md#set-context--set-namespace)
* [Manage deployments](kubernetes.md#manage-deployments)
   * [apply](kubernetes.md#apply)
   * [Specific deployment settings](kubernetes.md#specific-deployment-settings)
* [Manage pods](kubernetes.md#manage-pods)
   * [Get pods](kubernetes.md#get-pods)
   * [delete pods](kubernetes.md#delete-pods)
   * [exec, run a command in a pod/container](kubernetes.md#exec-run-a-command-in-a-podcontainer)
* [View events](kubernetes.md#view-events)
* [Services](kubernetes.md#services)
   * [Expose](kubernetes.md#expose)
   * [Manage services](kubernetes.md#manage-services)
   * [Manage addons](kubernetes.md#manage-addons)
* [Secrets](kubernetes.md#secrets)
   * [Add certificate as secret](kubernetes.md#add-certificate-as-secret)
* [Labels](kubernetes.md#labels)
* [Debug](kubernetes.md#debug)
   * [Debug certificates.](kubernetes.md#debug-certificates)
   * [tcpdump sidecar container](kubernetes.md#tcpdump-sidecar-container)

<!-- Added by: runner, at: Fri Jul 30 09:06:17 UTC 2021 -->

<!--te-->

# Definitions

- **Pod**: a group of one or more containers
- **Deployment**: checks on the health of your Pod and restarts the Pod's Container if it terminates.
- **minikube**: a kubernetes virtual machine

# minikube

## Create a minikube cluster

```bash
minikube start
minikube dashboard
```

## Images

### push docker image to minikube repository
After building an image locally, you need to push it to the minikube repository before the pods can find it.
```bash
minikube image load secret-scanner/web:latest
```

### List images in the minikube repositiry
```bash
minikube image ls
```

### Build an image directly to the minikube repository
```bash
minikube image build -t secret-scanner/web .
```

# Manage namespace

## Get namespaces
```bash
kubectl get namespace
```

## Set context / set namespace
```bash
kubectl config set-context --current --namespace=<NAME>
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
- **metadata**, contains the name and labels of an object, for example:
```yaml
metadata:
  name: secretscanner-web
  labels:
    app: secretscanner-web
```

# Manage pods

## Get pods
```bash
kubectl get pods
```

## delete pods
```bash
kubectl delete pod <pod name>
```

## exec, run a command in a pod/container
```bash
kubectl exec <pod name> --container <container name> -- echo "hello world"
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

# Labels

We can refer to objects using labels, since the name is regenerated on "restarting" a resource.

```bash
kubectl delete pods -l app=my-app
```

# Debug

## Debug certificates.
```bash
kubectl logs pod/ingress-nginx-controller-5d88495688-nb9x7 -n ingress-nginx | grep cert
```

## tcpdump sidecar container

To debug network traffic for a pod, add this container to the pod deployment:

```bash
- name: tcpdump
  image: corfr/tcpdump
  command:
    - /bin/sleep
    - infinity
```

Then run:

```bash
kubectl exec secretscanner-authprovider-79959c8478-x2lpb --container tcpdump -- tcpdump -v
```
