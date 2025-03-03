pipeline {
  agent { label 'Jenkins-Agent' }

  tools {
    jdk 'Java17'
    maven 'Maven3'
  }

  environment {
    SONAR_HOST_URL = 'http://your-sonarqube-server'  // Set the correct SonarQube URL
  }

  stages {
    stage("Cleanup Workspace") {
      steps {
        cleanWs()
      }
    }

    stage("Checkout from SCM") {
      steps {
        git branch: 'main', credentialsId: 'github', url: 'https://github.com/Amol-sys/register-app.git'
      }
    }

    stage("Build Application") {
      steps {
        sh "mvn clean package"
      }
    }

    stage("Test Application") {
      steps {
        sh "mvn test"
      }
    }

    stage("SonarQube Analysis") {
      steps {
        script {
          withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') { 
            sh "mvn sonar:sonar"
          }
        }
      }
    }
  }


  
  post {
    always {
      echo "Pipeline execution completed."
    }
    failure {
      echo "Build failed! Check logs for errors."
    }
    success {
      echo "Build and tests completed successfully!"
    }
  }
}
