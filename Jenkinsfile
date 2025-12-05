pipeline {
    agent any

    environment {
        APP_NAME = "smart-camp"
        IMAGE_NAME = "static-site:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                // Jenkins will override this when using "Pipeline script from SCM",
                // but it's okay to leave here.
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Stop Old Container') {
            steps {
                sh """
                  if [ \$(docker ps -q -f name=${APP_NAME}) ]; then
                    docker stop ${APP_NAME}
                    docker rm ${APP_NAME}
                  fi
                """
            }
        }

        stage('Run New Container') {
            steps {
                sh """
                  docker run -d --name ${APP_NAME} \
                    -p 80:80 \
                    ${IMAGE_NAME}
                """
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
}
