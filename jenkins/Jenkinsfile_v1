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