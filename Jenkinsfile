pipeline {
    agent any

  stages {
        stage('Checkout') {
            steps {
                // Pulls code from the repository
                git branch: 'main', url: 'https://github.com/kalyan2360/terraform-tf-files.git'
            }
        }
        /*
      // moving  to the looptest directory 
        stage('move to looptest dir'){
           steps{
             sh 'cd terraform-tf-files/looptest'
        }
        }
        */
        stage('Terraform Init') {
            steps {
                //sh 'cd looptest && terraform fmt'
                 // Navigate to the specific folder and run Terraform init
               // dir('terraform-tf-files/looptest')
                // Initialize Terraform
             sh 'cd looptest && terraform init'
            }
        }
         stage('terraform code formating'){
            steps{
                sh 'cd looptest && terraform fmt'
            }
        }
        stage('Validating the code'){
            steps{
                sh 'cd looptest && terraform validate'
            }
        }
        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                sh 'cd looptest && terraform plan'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                // Apply the Terraform plan
                sh 'cd looptest && terraform apply -auto-approve=true'
            }
        }
        
   }

  }
