pipeline {
  agent any
  environment {
    BUILD_NUMBER = sh(returnStdout: true, script: "echo \"${env.BUILD_NUMBER}\"").trim()
  }
  stages {
    stage('build'){
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
