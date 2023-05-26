# https://www.jenkins.io/doc/book/installing/docker/#on-windows
FROM jenkins/jenkins:2.332.1-jdk11

# ENV https_proxy=
# ENV http_proxy=
# ENV ftp_proxy=
# ENV no_proxy=
# ENV JAVA_TOOL_OPTIONS=
# ENV JAVA_OPTIONS=
# ENV TRUST_HOST=
# ENV PROXY=

USER root
RUN apt-get update && apt-get install -y  lsb-release apt-transport-https && update-ca-certificates \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN apt-get update && apt-get install -y make gcc

RUN chown -R 1000 /var/jenkins_home
RUN chmod 755 /var/jenkins_home
COPY ./init_jenkinsdata.sh /var/jenkins_home/
COPY ./install_cert.sh /repo/
WORKDIR /var/jenkins_home/
RUN chmod +x /var/jenkins_home/init_jenkinsdata.sh
RUN /var/jenkins_home/init_jenkinsdata.sh

COPY  ./Dockerfile.build_env /repo/
RUN chmod +x /repo/Dockerfile.build_env
COPY ./run_build_env.sh /repo/
RUN chmod +x /repo/run_build_env.sh

# USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.8 docker-workflow:521.v1a_a_dd2073b_2e"
RUN jenkins-plugin-cli --plugins \
    "powershell parameterized-trigger nodelabelparameter ws-cleanup timestamper configuration-as-code pipeline-utility-steps jdk-tool command-launcher"
