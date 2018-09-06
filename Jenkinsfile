pipeline {
  agent any
  stages {
    stage('build'){
      steps {
        sh 'echo building....'
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
