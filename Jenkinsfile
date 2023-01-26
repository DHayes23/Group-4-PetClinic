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
        stage("Docker Build Backend") {
            steps {
                sh("sudo apt-get update")
                sh("sudo apt install curl -y")
                sh("curl https://get.docker.com | sudo bash")
                sh("sudo usermod -aG docker \$(whoami)")
                sh("git clone https://github.com/nok911/QATeam4-Petclinic.git")
                sh("cd QATeam4-Petclinic/spring-petclinic-rest/")
                sh("docker build -t luffy991/backend_image:1.2 .")
                sh("docker push backend_image:1.2")
            }
        }
        // stage("Docker Build Frontend") {
        //     steps {
        //         sh()
        //     }
        // }
        stage('Execute Ansible') {
            steps {
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'inventory.yml', playbook: 'playbook.yml'
            }
        }
    }
}