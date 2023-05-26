# Requirements
## Docker and Docker Compose
```
docker --version
Docker version 20.10.23, build 7155243

docker-compose --version
docker-compose version 1.25.0, build unknown
```

## Open JRE
```
java --version
openjdk 11.0.17 2022-10-18
OpenJDK Runtime Environment (build 11.0.17+8-post-Ubuntu-1ubuntu220.04)
OpenJDK 64-Bit Server VM (build 11.0.17+8-post-Ubuntu-1ubuntu220.04, mixed mode, sharing)
```


# Usage
## Clone Repository
```bash
git clone https://github.com/kz-rv04/jenkins-dind.git
```

## Change the permissions of install_cert.sh and init_jenkinsdata.sh

```bash
sudo chmod 777 install_cert.sh
sudo chmod 777 init_jenkinsdata.sh
```

## Build and Up Containers

```bash
docker-compose up -d --build
Building jenkins-blueocean
Step 1/36 : FROM jenkins/jenkins:2.332.1-jdk11
---> bcfec577b543
...
Successfully built f67db4ecf807
Successfully tagged jenkinscicd_jenkins-blueocean:latest
jenkinscicd_docker_1 is up-to-date
jenkinscicd_jenkins-blueocean_1 is up-to-date
```

## Show initialAdminPassword
Access to Jenkins on browser and make initial settings
```bash
docker exec -it jenkinscicd_jenkins-blueocean_1 cat /var/jenkins_home/secrets/initialAdminPassword

hostname -I
172.23.73.100
# goto https://172.23.73.100:8080/
```