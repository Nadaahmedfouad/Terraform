pipeline {
    agent any
    
    options {
    timestamps()
    
}
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'stg', 'prod'],
            description: 'Choose Terraform environment'
        )
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Workspace') {
            steps {
                sh """
                    terraform workspace select ${params.ENVIRONMENT} || \
                    terraform workspace new ${params.ENVIRONMENT}
                """
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh """
                    terraform plan \
                    -var-file=${params.ENVIRONMENT}.tfvars \
                    -out=tfplan
                """
            }
        }

        stage('Manual Approval') {
            steps {
                input(
                    message: "Apply Terraform changes to ${params.ENVIRONMENT}?",
                    ok: 'Apply'
                )
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {

        success {
            echo "Terraform deployment to ${params.ENVIRONMENT} completed successfully."
        }

        failure {
            echo "Terraform deployment to ${params.ENVIRONMENT} failed."

            emailext(
                to: 'nadaahmedfouad123@gmail.com',
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Terraform pipeline failed.

Environment: ${params.ENVIRONMENT}
Job: ${env.JOB_NAME}
Build Number: ${env.BUILD_NUMBER}

Build URL:
${env.BUILD_URL}
                """,
                attachLog: true
            )
        }

        aborted {
            echo "Terraform deployment to ${params.ENVIRONMENT} was aborted."
        }
    }
}
