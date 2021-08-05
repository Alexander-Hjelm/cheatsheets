# Jenkins
<!--ts-->
<!--te-->

## Install with docker
```bash
docker pull jenkins/jenkins
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home 1282bc63ab17
```

## Password recovery

The initial admin password can be found in: `/var/jenkins_home/secrets/initialAdminPassword`


