pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply'],
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
                    userRemoteConfigs: [[url: 'https://github.com/ygminds73/Terraform-Automation.git']]
                )
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'rm -rf .terraform'
                sh 'terraform init -reconfigure'
            }
        }

        stage('Action') {
            steps {
                script {
                    switch (params.ACTION) {

                        case 'plan':
                            echo 'Executing Plan...'
                            sh 'terraform plan'
                            break

                        case 'apply':
                            echo 'Executing Apply...'
                            sh 'terraform apply --auto-approve'
                            break

                        default:
                            error 'Unknown action'
                    }
                }
            }
        }

    }
}
