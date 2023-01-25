pipeline {
    agent any
    stages {
        stage('Confifrm Connection') {
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
                sh("terraform destroy --auto-approve")
            }
        }
    }
}