pipeline {
  agent any

  environment {
    DEPLOY_IP = '3.108.227.83'
  }

  stages {
    stage('Clone Repository') {
      steps {
        git url: 'https://github.com/IzoManuel/portfolio-site.git', branch: 'main'
      }
    }

    stage('Echo Stage') {
      steps {
        echo 'Building the portfolio site...'
      }
    }

    stage('Deploy') {
      steps {
        sshagent(['deploy-ssh-key']) {
          sh """
            # Install Nginx if not installed
            ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_IP} 'sudo apt-get update && sudo apt-get install -y nginx'

            # Change ownership of the html directory
            ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_IP} 'sudo chown -R ubuntu:ubuntu /var/www/html'

            # Create the portfolio-site directory if it doesn't exist
            ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_IP} 'mkdir -p /var/www/html/portfolio-site'

            # Copy files to the remote server
            scp -o StrictHostKeyChecking=no -r * ubuntu@${DEPLOY_IP}:/var/www/html/portfolio-site

            # Reload Nginx to apply changes
            ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_IP} 'sudo systemctl restart nginx'
          """
        }
      }
    }
  }
}
