pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Pulls code from the repository
                git branch: 'main', url: 'https://github.com/kalyan2360/terraform-tf-files.git'
            }
        }
      // moving  to the looptest directory 
        stage('move to looptest dir'){
           steps{
             sh 'cd terraform-tf-files/looptest'
        }
        }
        stage('Terraform Init') {
            steps {
                 // Navigate to the specific folder and run Terraform init
               // dir('terraform-tf-files/looptest')
                // Initialize Terraform
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                sh 'terraform plan -out=tfplan'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                // Apply the Terraform plan
                sh 'terraform apply -input=false tfplan'
            }
        }
    }

    post {
        always {
            // Clean up workspace after the build
            cleanWs()
        }
    }
}
