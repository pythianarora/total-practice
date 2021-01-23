Create Ingress Resource? 

1. Create a namespace called app-space to host the default backend

kubectl create namespace app-space

2. Create a deployment for the default backend.

kubectl create deployment default-backend --image=nginx --port=8080 -n app-space

3. Create a service to expose the default backend.

kubectl -n app-space expose deployment default-backend --port=80 --target-port=8080 --name default-http-backend

4. Create a namespace called 'ingress-space'

kubectl create namespace ingress-space

5. Create a ConfigMap object in the ingress-space namespace. This will be used by NGINX Ingress Controller.

kubectl create configmap nginx-configuration --namespace ingress-space

6. Create a ServiceAccount in the ingress-space namespace.

kubectl create serviceaccount ingress-serviceaccount --namespace ingress-space

7. Create Role and Role Bindings for Ingress Controller

kubectl apply -f https://raw.githubusercontent.com/pythianarora/total-practice/master/ingress-controller/ingress-role.yaml
kubectl apply -f https://raw.githubusercontent.com/pythianarora/total-practice/master/ingress-controller/ingress-role-binding.yaml

8. Deploy the Ingress Controller 

kubectl apply -f https://raw.githubusercontent.com/pythianarora/total-practice/master/ingress-controller/ingress-controller.yaml

9. Deploy the Ingress Service Using NodePort

kubectl apply -f https://raw.githubusercontent.com/pythianarora/total-practice/master/ingress-controller/ingress-service.yaml

Test and Verify Ingress Resource?

10. Deploy the Echo Deployment and Service

kubectl apply -f https://raw.githubusercontent.com/pythianarora/total-practice/master/ingress-controller/echoserver-deployment-n-service.yaml

11. Create an Ingress Resource

kubectl apply -f https://raw.githubusercontent.com/pythianarora/total-practice/master/ingress-controller/echo-ingress.yaml

12. Get the cluster IP and test using below:

kubectl get service -n ingress-space

13. Test using the Cluster IP Obtained from the previous command.

curl http://{cluster-ip}/echo 
