pipeline {
    agent any

    environment {
        // AWS and SonarQube environment variables
        AWS_REGION = 'us-east-2'
        S3_BUCKET = 'pythonflaskappproject'
        APP_NAME = 'FlaskApp'
        SONARQUBE_SERVER = 'SonarQube'
        SONARQUBE_TOKEN = credentials('sonar-token') // store in Jenkins credentials
        GITHUB_REPO = 'https://github.com/anjupoulose03/flask_app.git'
        GITHUB_TOKEN = credentials('github-token')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "https://${GITHUB_TOKEN}@github.com/anjupoulose03/flask_app.git"
            }
        }
        /*
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
        */
        
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
                        --application-name ${FlaskApp} \
                        --deployment-group-name ${FlaskApp}-DG \
                        --s3-location bucket=${pythonflaskappproject},key=${APP_NAME}.zip,bundleType=zip \
                        --region ${us-east-2}
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

