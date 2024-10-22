pipeline {
  agent {
    docker {
      image 'abhishekf5/maven-abhishek-docker-agent:v1'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock' // mount Docker socket to access the host's Docker daemon
    }
  }
  stages {
    stage('Checkout') {
      steps {
        sh 'echo passed'
        //git branch: 'main', url: 'https://github.com/gowtham-454/Petclinic-java-app.git'
      }
    }
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
    
    
  }
}