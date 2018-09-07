pipeline {
  agent any
  environment {
    GITBRANCH = sh(
      returnStdout: true,
      script: "echo ${env.GIT_BRANCH.minus('origin/')}"
    ).trim()
  }
  stages {
    stage('build'){
      steps {

        /* get github key */
        sh '''
          set -x
          set +x
        '''
        sh "echo ${env.GITBRANCH}"

        /* build */
        sh "TAG=${env.BUILD_NUMBER}"
      }

    }
    stage('clone-terramform') {
      when {
        expression {
          return !fileExists('kepler-terramform')
        }
      }
      steps {
        sh 'echo terraform'
      }
    }
    stage('terraform') {
      steps {

        /* get vault credentials */

        sh '''
          set +x
          export AWS_ACCESS_KEY_ID=$(echo hi)
          set -x
        '''

      /* Get latest terraform configs and push the new */
      /*Task Definition and Cloudwatch triggers */

      sh """
        set +e
        VERSION=${env.BUILD_NUMBER}
        echo ${env.BUILD_NUMBER}
      """

      }
    }
  }
  post {
    success {
     sh "echo success"

    }
    failure {
      sh "echo failure"
    }
  }
}
