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
        stage('build docker images'){
            steps {
                dir('./spring-petclinic-angular/'){
                    sh "docker build -t luffy991/petclinic-frontend:latest ."
                }
                dir('./spring-petclinic-rest/'){
                    sh "docker build -t luffy991/petclinic-backend:latest ."
                } 
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'DockerPass', variable: 'DockerPass')]) {
                        sh 'sudo docker login -u luffy991 -p ${DockerPass}'
                    }
                    sh "docker push luffy991/petclinic-backend:latest"
                    sh "docker push luffy991/petclinic-frontend:latest"
                    sh "docker rmi luffy991/petclinic-frontend:latest"
                    sh "docker rmi luffy991/petclinic-backend:latest"
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