pipeline {
  agent any
  stages {
    stage('Checkout code') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh 'mvn -B jacoco:report checkstyle:checkstyle install'
        archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
      }
    }
    stage('Publish Test Coverage Report and Code Analysis') {
      steps {
        jacoco()
        recordIssues(tools: [checkStyle(), junitParser(), mavenConsole()])
      }
    }
  }
}
