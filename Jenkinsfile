pipeline {
  agent any
  environment {
    BUILD_NUMBER = sh(returnStdout: true, script: "echo \"${env.BUILD_NUMBER}\"").trim()
  }
  stages {
    stage('build'){
      parameters {
        def kepler_terraform = fileExists 'kepler-terraform'
        booleanParam(name: 'KEPLER_TERRAFORM', defaultValue: kepler_terraform)
      }
      when {
        not {
          params.KEPLER_TERRAFORM {
            sh 'echo hiiiiiiiii'
          }
        }
      }
      steps {
        sh 'echo building....'
        sh "echo ${env}"
      }
    }
  }
  post {
    success {

      sh 'echo Success!'
    }
    failure {
      sh 'echo Failure!'
    }
  }
}
