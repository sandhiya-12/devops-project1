# Enable Webhook
1. Install "multibranch scan webhook trigger" plugin  
    From dashboard --> Manage jenkins --> Plugins --> Available Plugins  
    Search for "Multibranch Scan webhook Trigger" plugin and install it. 

2. Go to multibranch pipeline job
     job --> configure --> Scan Multibranch Pipeline Triggers --> Scan Multibranch Pipeline Triggers  --> Scan by webhook   
     Trigger token: `<token_name>`

     Token: `java-trigger-token`
     URL:  http://3.82.44.97:8080/multibranch-webhook-trigger/invoke?token=java-trigger-token

3. Add webhook to GitHub repository
   Github repo --> Project settings --> webhooks --> Add webhook  
   Payload URl: `<jenkins_IP>:8080/multibranch-webhook-trigger/invoke?token=<token_name>`  
   Content type: `application/json`  
   Which event would you like to trigger this webhook: `just the push event` 


Once it is enabled make changes to source to trigger the build. 

If the jenkins-master instance is stopped and restarted, this webhook has to be modified.
