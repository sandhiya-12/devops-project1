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
6. Now a load balancers qith 2 instances are created in the EC2 --> Load Balancer

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
