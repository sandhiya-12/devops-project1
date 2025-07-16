# Prometheus setup
### pre-requisites
1. Kubernetes cluster
2. helm

## Setup Prometheus

1. Create a dedicated namespace for prometheus 
   ```sh
   kubectl create namespace monitoring
   ```

2. Add Prometheus helm chart repository
   ```sh
   helm repo add prometheus-grafana-community https://prometheus-community.github.io/helm-charts 
   ```

3. Update the helm chart repository
   ```sh
   helm repo update
   helm repo list
   ```

4. Install the prometheus and grafana

   ```sh
    helm install prometheus prometheus-grafana-community/kube-prometheus-stack --namespace monitoring
   ```

5. Above helm create all services as ClusterIP. To access Prometheus out side of the cluster, `we should change the service type from ClusterIP to load balancer`
   ```sh 
   kubectl edit svc prometheus-kube-prometheus-prometheus -n monitoring
   ```
6. Now a load balancers with 2 instances are automatically created since we are already in AWS EC2 instance. see in EC2 --> Load Balancer

7. Loginto Prometheus dashboard to monitor application
   https://<ELB-DNS-name>:9090

8. Check for node_load15 executor to check cluster monitoring 

9. We check similar graphs in the Grafana dashboard itself. for that, we should `change the service type of Grafana to LoadBalancer`
   ```sh 
   kubectl edit svc prometheus-grafana -n monitoring
   ```
   ```

10.  To login to Grafana account, use the below username and password 
    ```sh
    username: admin
    password: prom-operator
    ```
11. Here we should check for "Node Exporter/USE method/Node" and "Node Exporter/USE method/Cluster"
    USE - Utilization, Saturation, Errors
   
12. Even we can check the behavior of each pod, node, and cluster


Note: If we are running Helm on EC2 instance and the service type of prometheus and grafana from ClutserIP to Loadbalancer, you can access 
Prometheus: https://<Prometheus-ELB-DNS-name>:9090
Grafana: https://<Grafana-ELB-DNS-name>:80

These ELB DNS name can be viewed in EC2 -> LoadBalancers (or) 
kubectl get svc -n monitoring --> Look for EXTERNAL-IP

If you use minikube or kind, use below port-forwards, change of service type not needed.
```sh
kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090   ---> http://localhost:9090
kubectl port-forward svc/prometheus-grafana -n monitoring 7080:80          ---> http://localhost:7080
```

Uninstall prometheus using
```sh
helm list -A
helm uninstall prometheus -n monitoring
k get all -n monitoring
```