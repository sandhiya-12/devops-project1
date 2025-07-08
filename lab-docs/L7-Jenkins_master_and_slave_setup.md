# Jenkins Master and Slave Setup


1. Write playbook for jenkins setup in jenkins-master instance
   ```sh
   ansible-playbook -i /opt/hosts jenkins-master-setup.yaml --check
   ansible-playbook -i /opt/hosts jenkins-master-setup.yaml
   ```
   You can check by login to jenkins-master instance,
   java -version
   service jenkins status

2. If we give jenkins-master instance http://<public-ip>:8080 in browser, jenkins should show
   So add 8080 port to inbound security rules.

   cat /var/lib/jenkins/secrets/initialAdminPassword for jenkins password after adding rules and terraform apply
   setup jenkins in the browser


3. Write playbook for maven setup in jenkins-slave instance
   ```sh
   ansible-playbook -i /opt/hosts jenkins-slave-setup.yaml --check
   ansible-playbook -i /opt/hosts jenkins-slave-setup.yaml
   ```

4. You can check by login to build-node instance,
   ls /opt
   cd /opt/<apache-maven-dir>/bin
   export PATH=/opt/apache-maven-3.9.10/bin:$PATH
   mvn --version



1. Add credentials 
2. Add node
   
### Add Credentials 
1. Manage Jenkins --> Manage Credentials --> System --> Global credentials --> Add credentials
2. Provide the below info to add credentials   
   kind: `ssh username with private key`  
   Scope: `Global`     
   ID: `maven_slave`    
   Username: `ec2-user`  
   private key: `dpo.pem key content`  

### Add node 
   Follow the below setups to add a new slave node to the jenkins 
1. Goto Manage Jenkins --> Manage nodes and clouds --> New node --> Permanent Agent    
2. Provide the below info to add the node   
   Number of executors: `3`   
   Remote root directory: `/home/ec2-user/jenkins`  
   Labels: `maven`  
   Usage: `Use this node as much as possible`  
   Launch method: `Launch agents via SSH`  
        Host: `<Private_IP_of_Slave>`  
        Credentials: `<Jenkins_Slave_Credentials>`     
        Host Key Verification Strategy: `Non verifying Verification Strategy`     
   Availability: `Keep this agent online as much as possible`  