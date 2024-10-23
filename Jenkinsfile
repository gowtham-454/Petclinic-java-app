pipeline {
    agent { label 'builder3' } // Specify the node with label 'builder3'
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

	     stage('Upload to S3') {
            steps {
                script {
                    def warFile = 'target/petclinic.war'
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
                        sh "ls "
			sh "rm -rf workspace"
                    }
                }
            }
        }
    }
}
