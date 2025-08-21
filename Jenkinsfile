pipeline {
    agent any

    environment {
        APP_NAME    = "FlaskApp"                // CodeDeploy application name
        DEPLOY_GRP  = "FlaskApp-DG"             // CodeDeploy deployment group name
        S3_BUCKET   = "pythonflaskappproject"   // Your S3 bucket name
        AWS_REGION  = "us-east-2"               // AWS region
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/anjupoulose03/flask_app.git'
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
                        --deployment-group-name ${DEPLOY_GRP} \
                        --s3-location bucket=${S3_BUCKET},key=${APP_NAME}.zip,bundleType=zip \
                        --region ${AWS_REGION}
                '''
            }
        }
    }

    post {
        failure {
            echo "Pipeline Failed!"
        }
        success {
            echo "Pipeline Succeeded! 🚀"
        }
    }
}
