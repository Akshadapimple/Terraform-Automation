pipeline {
agent any

parameters {
    choice(
        name: 'ACTION',
        choices: "plan\napply",
        description: 'Select the action to perform'
    )
}

stages {

    stage('Clean') {
        steps {
            cleanWs()
        }
    }

    stage('Checkout') {
        steps {
            checkout scmGit(
                branches: [[name: '*/main']],
                extensions: [],
                userRemoteConfigs: [[url: 'https://github.com/Akshadapimple/Terraform-Automation.git']]
            )
        }
    }

    stage('Terraform Init') {
        steps {
            sh '''
            rm -rf .terraform
            rm -f terraform.tfstate
            rm -f terraform.tfstate.backup

            export AWS_DEFAULT_REGION=us-east-1

            terraform init -reconfigure -migrate-state
            '''
        }
    }

    stage('Action') {
        steps {
            script {

                switch (params.ACTION) {

                    case 'plan':
                        sh 'terraform plan'
                        break

                    case 'apply':
                        sh 'terraform apply -auto-approve'
                        break

                    default:
                        error 'Unknown action'
                }

            }
        }
    }

}
