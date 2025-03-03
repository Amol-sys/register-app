pipeline {
  agent { label 'Jenkins-Agent' }

  tools {
    jdk 'Java17'
    maven 'Maven3'
  }

  environment {
    SONAR_HOST_URL = 'http://your-sonarqube-server'  // Ensure this is correctly set in Jenkins global settings
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
          withSonarQubeEnv('jenkins-sonarqube-token') { 
            sh "mvn sonar:sonar -Dsonar.host.url=${SONAR_HOST_URL}"
          }
        }
      }
    }

    stage("Quality Gate") {
      steps {
        script {
          def qg = waitForQualityGate abortPipeline: true, credentialsId: 'jenkins-sonarqube-token'
          if (qg.status != 'OK') {
            error "Quality Gate failed: ${qg.status}"
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
