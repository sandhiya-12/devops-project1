# devops-project1

This contains devops setup files and setup for java-project1

Steps followed:
1. Setup Terraform for creating EC2 instance with VPC
2. Provision 3 EC2 instances for Jenkins master, build node, and Ansible using Terraform
3. Setup Ansible server in the created EC2 instances
4. Install and Configure Jenkins master and build node(maven-slave) using Ansible
5. Create Jenkins pipeline job for building the java code and creating jar file
6. Create multibranch pipeline for the java-poroject1, so if any new branches added with Jenkinsfile, it will create a pipeline job for it by default.
7. Enable webhook on GitHub so that any commits to git will automatically trigger the multibranch pipeline.
8. Create an JFrog Artifactory Account with repositories to store docker image and jar file.
9. add necessary plugins in Jenkins and push the jar file created to JFrog artifactory
10. Create a docker image for the jar file and push it to Jfrog artifactory
11. Create AWS EKS cluster and Auto-scaling backend nodes(2) using Terraform
12. Install kubectl in maven-slave instance and attach it to EKS.
13. Write kubernetes yaml files to deploy the docker image and execute it. Now the application is accessible from the port given in service.yaml
14. Seup Helm in maven-slave Deploy Kubernetes using Helm Charts
15. Setup Prometheus and Grafana using Helm Charts
16. Monitor the Kubernetes Cluster using Prometheus

