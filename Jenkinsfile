
pipeline {
    agent { label 'terraform-node' }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['Development', 'Testing', 'Production'],
            description: 'Environment folder'
        )
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply'],
            description: 'Terraform action'
        )
    }

    options {
        timeout(time: 60, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '30'))
    }

    environment {
        TF_DIR = "terraform/environments/${params.ENVIRONMENT ?: 'Development'}"
        AWS_CONFIG_FILE = "${WORKSPACE}/.aws-config"
        AWS_DEFAULT_REGION = 'ap-south-1'
        AWS_REGION = 'ap-south-1'
        TF_IN_AUTOMATION = 'true'
        TF_CLI_ARGS = '-no-color'
        LANG = 'en_US.UTF-8'
        LC_ALL = 'en_US.UTF-8'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    def envName = params.ENVIRONMENT ?: 'Development'

                    if (!fileExists(env.TF_DIR)) {
                        error "Folder ${env.TF_DIR} not found."
                    }

                    if (!fileExists("${env.TF_DIR}/backend.hcl")) {
                        error "Missing backend.hcl in ${env.TF_DIR}"
                    }

                    if (params.ACTION == 'apply' && env.BRANCH_NAME != 'main') {
                        error 'Apply is only allowed from main branch.'
                    }

                    withCredentials([
                        string(
                            credentialsId: "aws-role-${envName}",
                            variable: 'ROLE_ARN'
                        )
                    ]) {
                        sh '''
                            cat <<EOF > .aws-config
[default]
role_arn = $ROLE_ARN
credential_source = Ec2InstanceMetadata
region = ap-south-1
EOF
                        '''
                    }

                    echo "Environment: ${env.TF_DIR} | Action: ${params.ACTION}"
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform init -input=false -reconfigure -backend-config=backend.hcl'
                }
            }
        }

        stage('Terraform Format') {
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform fmt -check -recursive'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform plan -input=false -out=tfplan'
                    sh 'terraform show tfplan > plan.txt'
                }
                archiveArtifacts artifacts: "${env.TF_DIR}/plan.txt"
            }
        }

        stage('Approve') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                timeout(time: 30, unit: 'MINUTES') {
                    input(
                        message: "Apply plan to ${params.ENVIRONMENT}?",
                        ok: 'Apply',
                        submitter: 'devops-admins'
                    )
                }
            }
        }

        stage('Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        always {
            sh 'rm -f .aws-config'
        }
        success {
            echo 'Terraform deployment successful!'
        }
        failure {
            echo 'Terraform deployment failed. Check console output.'
        }
    }
}
