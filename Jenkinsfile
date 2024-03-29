// for dynamic retrieval
library identifier: 'jenkins-devops-libs@master', retriever: modernSCM(
  [$class: 'GitSCMSource',
   remote: 'https://github.com/cloudsheger/jenkins-devops-libs.git'])
// if added in Jenkins global config shared libraries
//@Library('jenkins-devops-libs')_
// if added in Jenkins global config shared libraries and the github api plugin is bugging out and slamming github with requests
//library('jenkins-devops-libs')_

pipeline {
  agent {
    dockerfile {
        filename 'Dockerfile'
        dir '.'
        args '--entrypoint=\'\' -v /var/run/docker.sock:/var/run/docker.sock'
    }
}

  stages {
    stage('Init') {
      steps {
        sh 'curl -L https://raw.githubusercontent.com/cloudsheger/ansible-terraform-packer/main/scripts/cloudsheger.pkr.json -o cloudsheger.pkr.json'
        script {
          packer.init(dir: '.')
        }
      }
    }

    stage('Plugins') {
      steps {
        script {
          packer.plugins(command: 'installed')
          packer.plugins(
            command: 'required',
            dir: '.'
          )
        }
      }
    }

    stage('Validate') {
      steps {
        script {
          packer.validate(template: 'cloudsheger.pkr.json')
        }
      }
    }

    stage('Format') {
      steps {
        script {
          packer.fmt(
            check: true,
            diff: true,
            template: '.'
          )
        }
      }
    }

    stage('Inspect') {
      steps {
        script {
          packer.inspect('cloudshege.pkr.json')
        }
      }
    }

    stage('Build') {
      steps {
        script {
          packer.build(template: 'cloudsheger.pkr.json')
        }
      }
    }
  }
}
