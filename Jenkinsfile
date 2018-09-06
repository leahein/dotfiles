pipeline {
  agent any
  environment {
    sh 'set +x'
    BUILD_NUMBER = sh(returnStdout: true, script: "echo ${env.BUILD_NUMBER}").trim()
    sh 'set -x'
  }
  stages {
    stage('clone') {
      when {
        expression {
          return !fileExists('hi')
        }
      }
      steps {
        sh 'echo it work'
      }
    }
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
