FROM tomcat:8.5.4-jre8

MAINTAINER Suparit Krityakien <suparit@wongnai.com>

##### The nginx setup is basically copied from https://hub.docker.com/_/nginx/ (alpine)
ENV NGINX_VERSION 1.10.1-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt \
						nginx-module-geoip \
						nginx-module-image-filter \
						nginx-module-perl \
						nginx-module-njs \
						gettext-base \
	&& rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
	 

COPY tomcat/ /usr/local/tomcat/

WORKDIR /usr/local/tomcat

RUN chmod +x /usr/local/tomcat/bin/docker-entrypoint.sh

EXPOSE 80 443 8080

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["with-nginx"]
