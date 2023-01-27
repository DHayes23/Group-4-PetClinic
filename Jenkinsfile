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
        stage('Destroy Existing Infrastructure') {
            steps {
                sh("terraform destroy --auto-approve")
                // echo 'Destruction Skipped'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh("terraform apply --auto-approve")
            }
        }
        stage('Build Docker Images'){
            steps {
                dir('./spring-petclinic-angular/'){
                    sh "sudo -S docker build -t luffy991/petclinic-frontend:latest ."
                }
                dir('./spring-petclinic-rest/'){
                    sh "sudo -S docker build -t luffy991/petclinic-backend:latest ."
                } 
            }
        }
        stage('Push Image to Hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'DockerPassword', variable: 'DockerPassword')]) {
    			        sh 'sudo -S docker login -u luffy991 -p ${DockerPassword}'
                    }
                    sh "sudo -S docker push luffy991/petclinic-backend:latest"
                    sh "sudo -S docker push luffy991/petclinic-frontend:latest"
                    sh "sudo -S docker rmi luffy991/petclinic-frontend:latest"
                    sh "sudo -S docker rmi luffy991/petclinic-backend:latest"
                }
            }
        }
        stage('Execute Ansible') {
            steps {
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'inventory.yml', playbook: 'playbook.yml'
            }
        }
    }
}