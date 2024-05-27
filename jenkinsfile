pipeline {
  agent any

  environment {
    RECIPIENTS = 'israel7payment@gmail.com'
  }

  stages {
    stage('Clone Repository') {
      steps {
        echo 'Starting Clone Repository stage'
        git url: 'git@github.com:IzoManuel/portfolio-site.git'
        echo 'Finished Clone Repository stage'
      }
      post {
        success {
          echo 'Repository cloned successfully.'
        }
        failure {
          echo 'Failed to clone repository.'
          mail to: "${RECIPIENTS}",
               subject: "Jenkins Pipeline Failed: Clone Repository",
               body: "The Clone Repository stage failed. Please check the Jenkins logs for more details."
        }
      }
    }

    stage('Echo Stage') {
      steps {
        echo 'Starting Echo Stage'
        echo 'Building the portfolio site...'
        echo 'Finished Echo Stage'
      }
      post {
        success {
          echo 'Echo stage completed successfully.'
        }
        failure {
          echo 'Failed during echo stage.'
          mail to: "${RECIPIENTS}",
               subject: "Jenkins Pipeline Failed: Echo Stage",
               body: "The Echo Stage failed. Please check the Jenkins logs for more details."
        }
      }
    }

    stage('Deploy') {
      steps {
        echo 'Starting Deploy Stage'
        sshagent(['deploy-ssh-key']) {
          sh """
            ssh -o StrictHostKeyChecking=no ubuntu@13.235.51.44 'sudo chown -R ubuntu:ubuntu /var/www/html'
            ssh -o StrictHostKeyChecking=no ubuntu@13.235.51.44 'mkdir -p /var/www/html/portfolio-site'
            scp -o StrictHostKeyChecking=no -r ./* ubuntu@13.235.51.44:/var/www/html/portfolio-site
            ssh -o StrictHostKeyChecking=no ubuntu@13.235.51.44 'bash /var/www/html/portfolio-site/deploy.sh'
          """
        }
        echo 'Finished Deploy Stage'
      }
      post {
        success {
          echo 'Deploy stage completed successfully.'
        }
        failure {
          echo 'Failed during deploy stage.'
          mail to: "${RECIPIENTS}",
               subject: "Jenkins Pipeline Failed: Deploy Stage",
               body: "The Deploy Stage failed. Please check the Jenkins logs for more details."
        }
      }
    }
  }

  post {
    always {
      echo 'Pipeline finished.'
    }
    success {
      echo 'Pipeline completed successfully.'
      mail to: "${RECIPIENTS}",
           subject: "Jenkins Pipeline Succeeded",
           body: "The Jenkins pipeline completed successfully."
    }
    failure {
      echo 'Pipeline failed.'
      mail to: "${RECIPIENTS}",
           subject: "Jenkins Pipeline Failed",
           body: "The Jenkins pipeline failed. Please check the Jenkins logs for more details."
    }
  }
}
