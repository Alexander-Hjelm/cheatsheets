# Jenkins
<!--ts-->
* [Jenkins](jenkins.md#jenkins)
   * [Install with docker](jenkins.md#install-with-docker)
   * [Password recovery](jenkins.md#password-recovery)

<!-- Added by: runner, at: Thu Aug  5 08:19:45 UTC 2021 -->

<!--te-->

## Install with docker
```bash
docker pull jenkins/jenkins
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home 1282bc63ab17
```

## Password recovery

The initial admin password can be found in: `/var/jenkins_home/secrets/initialAdminPassword`


