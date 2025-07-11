### Create a demo job using this slave node
1. Create a job --> give name --> freestyle project --> OK 
2. Select 'Restrict where this project can be run' --> Label : `maven`
3. Add Build step --> Execute shell 
4. echo "Hello, I am from slave" > /home/ubuntu/maven.txt
5. Save
6. Come out and click `Build Now` to see output and file will present in slave.

## Create the pipeline for java application
1. New Item --> give name --> Pipeline --> OK
2. Under Pipeline,
   either you can mention `Pipeline script` and use sample pipeline and Piepline syntax(to find syntax like to checkout git) at bottom to start with (or) use pipeline script from SCM

   pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    environment {
        PATH = "/opt/apache-maven-3.9.10/bin/:$PATH"
    }

    stages {
        stage('Checkout java project') {
            steps {
                git branch: 'main', url: 'https://github.com/sandhiya-12/java-project1.git'
            }
        }
        stage('Build project') {
            steps {
                sh 'mvn clean deploy'
            }
        }
    }
}

3. You can use `Configure` to change the pipeline job settings
4. To use Jenkinsfile from SCM, select `Pipeline script from SCM` --> SCM: `Git` --> give repo url and file path
5. If its public repo, no credentials required, if its private repo, create GitHub credentails using below and use it.
    1. Manage Jenkins --> Credentials --> System --> Global credentials --> Add credentials
    2. Provide the below info to add credentials   
   kind: `username with password`  
   Scope: `Global`     
   ID: `github-cred`    
   Username: `sandhiya-12`  
   password: Personal access token from github (Github settings --> devloper settings --> Personal access token --> Token (classic))



### Create a multibranch pipeline job (identifies branch using Jenkinsfile and austomatically adds pieline to that branch)
1. New Item --> give name --> Multibranch Pipeline --> OK
2. Give display name --> Build Sources: `Git` --> Project Repo: <java-project-github-url> and give above created github credentials
3. Build Configuration: by Jenkinsfile (default) --> Save

Now, whenever you add a new branch to this repo, `Scan Multibranch Pipeline Now` option checks if Jenkinsfile is present, if its present, add a new pipeline for that branch.
