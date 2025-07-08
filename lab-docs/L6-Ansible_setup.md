
# Setup Ansible
1. Login to ansible EC2 instance using ssh -i <pem-file> ubuntu@<public-ip>
2. change to root to install ansible
   sudo su -

3. Install ansibe on Ubuntu 24.04 
   ```sh 
   sudo apt update
   sudo apt install software-properties-common
   sudo add-apt-repository --yes --update ppa:ansible/ansible
   sudo apt install ansible
   ```
   Check with 
   ansible --version

4. Add Jenkins master and slave as hosts 
Add jenkins master and slave private IPs in the inventory file 
in this case, we are using /opt is our working directory for Ansible.

 # scp -i <pem-file> <source-in-local> ubuntu@<public-ip>:<dest>
    scp -i .\devopsdemo.pem .\devopsdemo.pem ubuntu@54.144.202.35:/home/ubuntu
    sudo su -
    cp /home/ubuntu/devopsdemo.pem /opt
    chmod 400 /opt/devopsdemo.pem

cd /opt
vi hosts
   ```
    [jenkins-master]
    18.209.18.194    ===> private ip of jenkins-master ec2 instance , bcoz public ip keeps changing
    [jenkins-master:vars]
    ansible_user=ubuntu      ===> same user as ec2 instance
    ansible_ssh_private_key_file=/opt/dpo.pem      ===> use the key pair created for ec2, copy to /opt dir using scp
    
    
    [jenkins-slave]
    54.224.107.148      ===> private ip of jenkins-master ec2 instance , bcoz public ip keeps changing
    [jenkins-slave:vars]
    ansible_user=ubuntu
    ansible_ssh_private_key_file=/opt/dpo.pem
   ```

5. Test the connection for each host separately
   ```sh
   ansible all -i hosts -m ping
   ```
