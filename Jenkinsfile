// Runs Terraform for one folder under terraform/environments/.
//
// Each environment needs:
//   backend.hcl in its folder            - remote state settings (S3 bucket, key, region)
//   Jenkins credential aws-role-<folder> - "Secret text" holding the role ARN to assume,
//                                          e.g. aws-role-Development

pipeline {
    agent { label 'terraform-node' }

    parameters {
        string(name: 'ENVIRONMENT', defaultValue: 'Development', trim: true,
               description: 'Folder name under terraform/environments/')
        choice(name: 'ACTION', choices: ['plan', 'apply'],
               description: 'apply shows the plan, waits for approval, then applies (main branch only)')
    }

    options {
        timeout(time: 60, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '30'))
    }

    environment {
        TF_DIR           = "terraform/environments/${params.ENVIRONMENT ?: 'Development'}"
        AWS_CONFIG_FILE  = "${WORKSPACE}/.aws-config"   // AWS settings for this build only
        TF_IN_AUTOMATION = 'true'
    }

    stages {
        stage('Check') {
            steps {
                script {
                    def envName = params.ENVIRONMENT ?: 'Development'

                    if (!fileExists(env.TF_DIR)) {
                        def folders = sh(returnStdout: true, script: 'ls terraform/environments').trim()
                        error "Folder ${env.TF_DIR} not found. Available: ${folders}"
                    }
                    if (!fileExists("${env.TF_DIR}/backend.hcl")) {
                        error "Missing ${env.TF_DIR}/backend.hcl (remote state settings)."
                    }
                    if (params.ACTION == 'apply' && env.BRANCH_NAME != 'main') {
                        error 'Apply is only allowed from the main branch.'
                    }

                    // Terraform assumes this role using the Jenkins EC2 instance profile. No keys are stored.
                    // The role ARN comes from the Jenkins credential aws-role-<folder>; Jenkins masks it in logs.
                    withCredentials([string(credentialsId: "aws-role-${envName}", variable: 'ROLE_ARN')]) {
                        writeFile file: '.aws-config',
                                  text: "[default]\nrole_arn = ${env.ROLE_ARN}\ncredential_source = Ec2InstanceMetadata\n"
                    }
                    echo "Environment: ${env.TF_DIR} | Action: ${params.ACTION ?: 'plan'}"
                }
            }
        }

        stage('Plan') {
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform init -input=false -backend-config=backend.hcl'
                    sh 'terraform validate'
                    sh 'terraform plan -input=false -out=tfplan'
                    sh 'terraform show -no-color tfplan > plan.txt'   // readable copy for reviewers
                }
                archiveArtifacts artifacts: "${env.TF_DIR}/plan.txt"
            }
        }

        stage('Approve') {
            when { expression { params.ACTION == 'apply' } }
            steps {
                timeout(time: 30, unit: 'MINUTES') {
                    // Change 'devops-admins' to the Jenkins user or group allowed to approve.
                    input message: "Apply plan.txt to ${params.ENVIRONMENT}?", ok: 'Apply', submitter: 'devops-admins'
                }
            }
        }

        stage('Apply') {
            when { expression { params.ACTION == 'apply' } }
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform apply -input=false tfplan'   // applies exactly the approved plan
                }
            }
        }
    }

    post {
        always {
            sh "rm -f .aws-config ${env.TF_DIR}/tfplan ${env.TF_DIR}/plan.txt"
        }
    }
}
