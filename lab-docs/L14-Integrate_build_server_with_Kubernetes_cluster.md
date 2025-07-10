## Integrate maven slave server with Kubernetes cluster 
sudo su -

1. Setup kubectl. Download the version matching the AWS EKS version from official kubernetes install page
   ```sh 
     curl -LO https://dl.k8s.io/release/v1.33.0/bin/linux/amd64/kubectl
     chmod +x ./kubectl
     mv ./kubectl /usr/local/bin
     kubectl version
   ``` 

2. Make sure you have installed awscli latest version in maven slave. If it has awscli version 1.X then remove it and install awscli 2.X  
    ```sh 
     yum remove awscli 
     curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
     apt install unzip
     unzip awscliv2.zip
     sudo ./aws/install --update
    ```

3. Configure awscli to connect with aws account  
    ```sh 
     aws configure
     Provide access_key, secret_key
    ```

4. Download Kubernetes credentials and cluster configuration (.kube/config file) from the cluster  

   ```sh 
    aws eks update-kubeconfig --region us-east-1 --name java-eks-01
   ```
5. Now kubectl is installed in our maven slave updated with aws eks, check with
   >kubectl get nodes


sudo su -
cd /opt
mkdir kubernetes
cd kubernetes
create the yaml files and apply it using the steps in kubernetes-jfrog/deploy.sh

>kubectl get all -n java-proj

2 pods, 1 deployment 1 service, 1 secret is created

But the image pull in the pod will fail beacuse the secret value is not updated with our token. This can be checked in
kubectl describe pod/java-app1-6b6d46768d-4prdz -n java-proj