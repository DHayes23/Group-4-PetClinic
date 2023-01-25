pipeline {
    agent any
    stages {
        stage('Confirm Connection') {
            steps {
                echo 'Connection Confirmed'
            }
        }
        stage('Terraform Init') {
            steps {
                sh("terraform init")
            }
        }
        stage('Terraform Apply') {
            steps {
                sh("terraform apply --auto-approve")
            }
        }
    }
}