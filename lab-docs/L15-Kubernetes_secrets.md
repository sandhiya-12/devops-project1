## Integrate Jfrog with Kubernetes cluster
  
1. Create a dedicated user to use for a docker login   
     user menu --> new user  
     `user name`: jfrogcred  
     `email address`: <myemail>@gmail.com  
     `password`: <password>  

2. To pull an image from jfrog at the docker level, we should log into jfrog using username and password   
```sh 
 docker login sandy01.jfrog.io
```

Login was failing with created user, so used access token created for jenkins push to jfrog

3. genarate encode value for ~/.docker/config.json file 
  ```sh 
   cat ~/.docker/config.json | base64 -w0
   ```
   
`Note:` For more refer to [Kuberenetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)  
Make sure secret value name `jfrogcred` is updated in the deployment file.  

  `copy auth value to encode`
  cat ~/.docker/config.json | base64 -w0
  `use above command output in the secret`


After updating this in secret.yaml and executing kubernetes yaml files in Maven slave
image is pulled from jfrog successfully in the pods.

Service node port is 30082, so application will be accessable from that port

Add 30082 and 0.0.0.0/0 to inbound security rules of created 2 eks backend instances.
http://<backend-ec2-inst-public-ip>:30082 will show application `Greatings from Hello World`

