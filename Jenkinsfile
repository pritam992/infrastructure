pipeline {
    agent {
        label 'terraform-node'
    }

    stages {
        stage('Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan -input=false -out=tfplan'
            }
        }

        stage('Apply') {
            steps {
                // Applies the exact plan generated in the previous stage without prompting
                sh 'terraform apply -input=false -auto-approve tfplan'
            }
        }
    }
}
