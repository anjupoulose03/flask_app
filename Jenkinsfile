pipeline {
    agent any

    environment {
        // AWS and SonarQube environment variables
        AWS_REGION = 'us-east-1'
        S3_BUCKET = 'your-s3-bucket-name'
        APP_NAME = 'FlaskApp'
        SONARQUBE_SERVER = 'SonarQube'
        SONARQUBE_TOKEN = credentials('sonar-token') // store in Jenkins credentials
        GITHUB_REPO = 'https://github.com/your-username/flask-ci-cd-app.git'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GITHUB_REPO}"
            }
        }

        stage('SonarQube Scan') {
            steps {
                script {
                    // assuming you have SonarQube plugin installed in Jenkins
                    withSonarQubeEnv("${SONARQUBE_SERVER}") {
                        sh "sonar-scanner -Dsonar.projectKey=${APP_NAME} -Dsonar.sources=."
                    }
                }
            }
        }

        stage('Package Application') {
            steps {
                sh '''
                    zip -r ${APP_NAME}.zip app.py requirements.txt
                '''
            }
        }

        stage('Upload to S3') {
            steps {
                sh '''
                    aws s3 cp ${APP_NAME}.zip s3://${S3_BUCKET}/${APP_NAME}.zip --region ${AWS_REGION}
                '''
            }
        }

        stage('Deploy via CodeDeploy') {
            steps {
                sh '''
                    aws deploy create-deployment \
                        --application-name ${APP_NAME} \
                        --deployment-group-name ${APP_NAME}-DG \
                        --s3-location bucket=${S3_BUCKET},key=${APP_NAME}.zip,bundleType=zip \
                        --region ${AWS_REGION}
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment Successful!"
        }
        failure {
            echo "Pipeline Failed!"
        }
    }
}

