FROM reg.qiniu.com/pub/docker_base
MAINTAINER MaLu <malu@malu.me> 

WORKDIR /root

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common && \
    add-apt-repository ppa:ondrej/php -y && \
    apt install -y apache2 libapache2-mod-php7.2 && \
    apt install -y php7.2-common php7.2-mbstring php7.2-mysql php7.2-xml php7.2-gd php7.2-curl php7.2-json php7.2-fpm php7.2-zip php7.2-intl php7.2-dev && \
    # 用完包管理器后安排打扫卫生可以显著的减少镜像大小.
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    # */

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite && \
    a2enmod headers

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

VOLUME ["/app"]

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]

