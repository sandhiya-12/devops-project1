# Create a custom Helm chart

1. To create a helm chart template 
   ```sh 
   helm create java-project
   ```

    by default, it contains 
    - values.yaml
    - templates
    - Charts.yaml
    - charts

2. `Replace the templates directory with the yaml files in kubernetes-jfrog and package it`
   ```sh
   helm package java-project
   ```
3. Change the version number in the 
   ```sh 
   helm install java-project java-project-0.1.0.tgz
   kubectl get all -n java-proj
   ```
4. Commit the java-project-0.1.0.tgz to java-project1 repository

5. Create a deploy stage to jenkins job for the deployment 
   ```sh 
   stage(" Deploy ") {
          steps {
            script {
               echo '<--------------- Helm Deploy Started --------------->'
               sh 'helm install java-project java-project-0.1.0.tgz'
               echo '<--------------- Helm deploy Ends --------------->'
            }
          }
        }
   ```

6. To list installed helm deployments
   ```sh 
   helm list -A            ---> list helm deployment in all namespaces
   ```

Other useful commands
1. to change the default namespace to valaxy
   ```sh
   kubectl config set-context --current --namespace=java-proj
   ```

You can delete the cluster using 
   ```sh 
   helm uninstall java-project
   kubectl get all -n java-proj
   ```