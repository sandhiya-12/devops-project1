def imageName = 'sandy-docker/java-project1'
def version   = '2.1.2'
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

        stage(" Docker Build ") {
          steps {
            script {
               echo '--------------- Docker Build Started ---------------'
               app = docker.build(imageName+":"+version)
               echo '--------------- Docker Build Ends ---------------'
            }
          }
        }
    }
}