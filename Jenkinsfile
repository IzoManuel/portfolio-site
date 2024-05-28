pipeline {
  agent any

  stages {
    stage('Clone Repository') {
      steps {
        git url: 'https://github.com/IzoManuel/portfolio-site.git',  branch: 'main'
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
            ssh -o StrictHostKeyChecking=no ubuntu@13.235.51.44 'sudo chown -R ubuntu:ubuntu /var/www/html'
            ssh -o StrictHostKeyChecking=no ubuntu@13.235.51.44 'mkdir -p /var/www/html/portfolio-site'
            scp -o StrictHostKeyChecking=no -r * ubuntu@13.235.51.44:/var/www/html/portfolio-site
            ssh -o StrictHostKeyChecking=no ubuntu@13.235.51.44 'bash /var/www/html/portfolio-site/deploy.sh'
          """
        }
      }
    }
  }
}
