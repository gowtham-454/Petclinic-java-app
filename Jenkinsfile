pipeline {
    agent {
        docker {
            image 'abhishekf5/maven-abhishek-docker-agent:v1'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock' // mount Docker socket to access the host's Docker daemon
        }
    }
    stages {
        stage('Code-Compile') {
            steps {
                sh "mvn clean compile"
            }
        }
        stage('Code-Build') {
            steps {
                sh "mvn clean install"
            }
        }
        stage('Update war file') {
            environment {
                GIT_REPO_NAME = "Petclinic-java-app"
                GIT_USER_NAME = "gowtham-454"
            }
            steps {
                withCredentials([string(credentialsId: 'Github', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                    git config user.email "gowthamhacker454@gmil.com"
                    git config user.name "gowtham-454"
                    BUILD_NUMBER=${BUILD_NUMBER}
		    pwd
		    cp target/petclinic.war war_file/
                    git add target/petclinic.war
                    git commit -m "Update war file ${BUILD_NUMBER}"
		    echo "its working"
                    git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                '''
                }
            }
        }
        // New Upload to S3 Stage
        stage('Upload to S3') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
            }
            steps {
                script {
                    // Configure AWS CLI
                    sh """
                        aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
                        aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
                        aws configure set default.region us-east-1  // Set your desired region
                        aws configure set default.output json  // Set default output format to JSON
                    """
                    // Upload the WAR file to S3
                    def warFile = 'target/petclinic.war' // Path to your WAR file
                    def bucketName = 'petshop454'
                    sh "aws s3 cp ${warFile} s3://${bucketName}/"
                }
            }
        }
        stage("clean workspace") {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                        sh "ls -ltr"
                        sh "pwd"
                        cleanWs()
                        sh "ls -ltr"
                    }
                }
            }
        }
    }
}
