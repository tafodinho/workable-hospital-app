pipeline {
    agent any
    options {
        disableConcurrentBuilds()
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker compose build'
            }
        }
        stage('Deliver') {
            steps {
                sh 'docker compose up'
            }
        }
    }
   
}