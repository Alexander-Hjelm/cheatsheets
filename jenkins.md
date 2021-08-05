# Jenkins
<!--ts-->
* [Jenkins](jenkins.md#jenkins)
   * [Install with docker](jenkins.md#install-with-docker)
   * [Password recovery](jenkins.md#password-recovery)
   * [Change jenkins home directory](jenkins.md#change-jenkins-home-directory)
   * [CLI](jenkins.md#cli)
      * [Download cli](jenkins.md#download-cli)
      * [Help](jenkins.md#help)
      * [Build a job](jenkins.md#build-a-job)
   * [Jenkins pipeline](jenkins.md#jenkins-pipeline)
      * [Quickstart examples](jenkins.md#quickstart-examples)
         * [Hello World](jenkins.md#hello-world)
         * [Python](jenkins.md#python)
         * [NodeJS](jenkins.md#nodejs)

<!-- Added by: runner, at: Thu Aug  5 09:56:56 UTC 2021 -->

<!--te-->

## Install with docker
```bash
docker pull jenkins/jenkins
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home 1282bc63ab17
```

## Password recovery

The initial admin password can be found in: `/var/jenkins_home/secrets/initialAdminPassword`

## Change jenkins home directory
On the host machine, add the following line to the bash profile.
```bash
export JENKINS_HOME=/var/jenkins_home
```
Restart Jenkins

## CLI

### Download cli

Go to `http://localhost:8080/cli/`
Run the CLi with `java jar jenkins-cli.jar -s http://localhost:8080 <Command to run> -username <userName> -password <password>

### Help
```bash
help
```

### Build a job
```bash
build <job name>
```

## Jenkins pipeline

### Quickstart examples

#### Hello World
```jenkinsfile
pipeline {
    agent any
    stages {
        stage('hello') {
            steps {
                echo "Hello World!"
            }
        }
    }
}
```

#### Python
```jenkinsfile
pipeline {
    agent { docker { image 'python:3.5.1' } }
    stages {
        stage('build') {
            steps {
                sh 'python --version'
            }
        }
    }
}
```

#### NodeJS
```jenkinsfile
pipeline {
    agent { docker { image 'node:14-alpine' } }
    stages {
        stage('build') {
            steps {
                sh 'npm --version'
            }
        }
    }
}
```
