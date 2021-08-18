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
      * [Snippet generator](jenkins.md#snippet-generator)
      * [Environment variables](jenkins.md#environment-variables)
         * [Provided environvment variables](jenkins.md#provided-environvment-variables)
         * [Custome environment variables](jenkins.md#custome-environment-variables)
         * [Carry variables over between stages](jenkins.md#carry-variables-over-between-stages)
      * [External groovy scripts](jenkins.md#external-groovy-scripts)
      * [Quickstart examples](jenkins.md#quickstart-examples)
         * [Hello World](jenkins.md#hello-world)
         * [Python](jenkins.md#python)
         * [NodeJS](jenkins.md#nodejs)
      * [Pull a second git repo](jenkins.md#pull-a-second-git-repo)
      * [post, run commands after execution](jenkins.md#post-run-commands-after-execution)
      * [when coditions (if, else, conditionals)](jenkins.md#when-coditions-if-else-conditionals)

<!-- Added by: runner, at: Wed Aug 18 08:20:37 UTC 2021 -->

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

### Snippet generator

Check the "Pipeline Syntax" link in the pipeline creator.

### Environment variables

#### Provided environvment variables
- **env.BRANCH_NAME** (string)

Full list: Go to `http://localhost:8080/env-vars.html`

#### Custome environment variables
```groovy
pipeline {
    agent any
    environment {
      NEW_VERSION = "1.3.0"
    }
    stages {
          stage('hello') {
              steps {
                  echo "building version $(NEW_VERSION)!"
              }
          }
    }
}
```

#### Carry variables over between stages
```groovy
def exampleVar

pipeline {
    agent any
    stages {
        stage('test') {
            steps {
                exampleVar = "Hello"
            }
        }
        stage('build') {
            steps {
                echo "$(exampleVar)"
            }
        }
    }
}
```

### External groovy scripts
```groovy
stages {
    stage('hello') {
        steps {
            script {
                gv = load "script.groovy"
                gv.sampleFunction()
            }
        }
    }
}
```

### Quickstart examples

#### Hello World
```groovy
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
```groovy
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
```groovy
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

### Pull a second git repo
```groovy
steps {
  git branch: 'master', credentials: '98j9efr4-3245-4734-2345-j9fe8pjh90843', url: 'https://github.com/Alexander-Hjelm/cheatsheets'
}
```

### post, run commands after execution
```groovy
stages {
  // Stages logic
}
post {
  always {
    // Do stuff
  }
  success {
    // Do stuff
  }
  failure {
    // Do stuff
  }
}
```

### when coditions (if, else, conditionals)
```groovy
stage("test") {
  when {
    expression {
      env.BRANCH_NAME == "dev" || env.BRANCH_NAME == "master"
    }
  }
  steps {
    echo "Hello from dev or master branch!"
  }
}
```
