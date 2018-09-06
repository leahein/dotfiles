pipeline {
  agent any
  environment {
  }
  stages {
    stage('build'){
      sh 'echo building....'

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
