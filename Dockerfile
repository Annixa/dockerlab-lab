# For more information, see:    
# For this project's repo, see: https://github.com/Annixa/dockerlab-lab


FROM docker:1.9-dind
MAINTAINER Cristoffer Fairweather <cfairweather@annixa.com>

#Install lab deps
RUN apk add --update openssh supervisor


#DOCK-5 Docker Lab: setup SSH
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa




#Configure supervisord
ADD conf/supervisord.conf /etc/supervisor/conf.d/

VOLUME ["/opt/dockerlab/saved"]
CMD ["/usr/bin/supervisord","-c", "/etc/supervisor/conf.d/supervisord.conf"]