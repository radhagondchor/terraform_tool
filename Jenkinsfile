 pipeline {
    agent any

    stages {
        stage('code check') {
            steps {
                git branch: 'main', url: 'https://github.com/radhagondchor/terraform_tool.git'
            }
        }
        stage('initialize code') {
            steps {
                sh "terraform init"
            }
        }
        stage('validate') {
            steps {
                sh "terraform validate"
            }
        }
        stage('plan') {
            steps {
                sh "terraform plan"
            }
        }
        stage('Apply') {
            steps {
                sh "terraform apply -auto-approve"
            }
        }
        stage('take user input') {
            input{
                message "Do you want continue"
            }
            steps {
                sh "terraform destroy  -auto-approve"
            }
        }
        
    }
}
