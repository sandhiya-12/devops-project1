# Helm setup in maven slave

1. Install helm
   ```sh 
   curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
   chmod 700 get_helm.sh
   ./get_helm.sh
   ```
1. Validate helm installation 
   ```sh
   helm version
   helm list      ====> list the deployments
   ```
1. [optional] Download .kube/config file to build the node 
   ```sh
   aws eks update-kubeconfig --region ap-south-1 --name java-eks-01
   ```

1. Setup helm repo 
   ```sh 
   helm repo list                ===> list the repos
   helm repo add stable https://charts.helm.sh/stable       ===> add the repo
   helm repo update              ===> update repo
   helm search repo <helm-chart>    ===> search the repo
   helm search repo mysql        ===> displays the charts matching mysql from repo (like stable/mysql)
   helm search repo stable       ===> displays all the charts inside stable
   ```

1. Install mysql charts on Kubernetes 
   ```sh 
   helm install <ref-name> <chart>        ===> deploys the chart
   helm install demo-mysql stable/mysql
   helm list                              ===> after installing it has mysql entry
   kubectl get all                        ===> shows the service,deployment,pods,replicaset associated with mysql
   ```
1. To pull the package from repo to local 
   ```sh 
   helm pull stable/mysql 
   ```

  *Once you have downloaded the helm chart, it comes as a zip file. You should extract it.* 

  In this directory, you can find 
  - templates
  - values.yaml
  - README.md
  - Chart.yaml

  If you'd like to change the chart, please update your templates directory  and modify the version (1.6.9 to 1.7.0) in the chart.yaml

then you can run the command to pack it after your update
```sh
 helm package mysql
```

To deploy helm chat
```sh 
 helm install mysqldb mysql-1.7.0.tgz (or) helm install mysqldb mysql
```

Above command deploy MySQL 
To check deployment 
```sh 
 helm list
 kubectl get all
```
To uninstall 
```sh 
 helm uninstall mysqldb
 kubectl get all
```

To install nginx 
```sh 
 helm repo search nginx 
 helm install demo-nginx stable/nginx-ingress