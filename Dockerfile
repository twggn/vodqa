FROM tomcat:8.0
ADD target/*.war /usr/local/tomcat/webapps/
 
RUN apt-get update && apt-get install -y vim
RUN apt-get update && apt-get install -y python3
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN useradd -ms /bin/bash jenkins
RUN echo 'jenkins:jenkins' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
 
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir ~/.ssh

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
 
EXPOSE 8080
EXPOSE 22
 
CMD /usr/local/tomcat/bin/startup.sh && service ssh restart && /bin/bash
