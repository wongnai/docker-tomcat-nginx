# Tomcat with Nginx
This docker image uses official tomcat (https://hub.docker.com/_/tomcat/) as base image and add the nginx (https://hub.docker.com/_/nginx/) for :-
1. serving static files 
2. do basic http headers eg. cache / expires
3. redirecting 
4. proxy to tomcat

The JRE8 is replaced with JDK so debugging tomcat is available. 

## Starting a container with nignx (default)
To start a container with nginx (daemon), just simply run the container without any argument.
	
	sudo docker run -d wongnai/tomcat-nginx:8.5.20-jdk
	
After starting the container, you should be able to make a request to both nginx (port 80) and tomcat (port 8080).

## Starting a container without nginx
	
### Without Nginx
To disable nginx, just set environment variable START_NGINX to 0. 

	sudo docker run -d -e START_NGINX=0 wongnai/tomcat-nginx:8.5.20-jdk

## Docker entrypoint
The docker-entrypoint.sh directly passes command line arguments to catalina.sh.
For example, to run catalina in "jdpa start" mode, just run docker container using the following command:-

	sudo docker run -d wongnai/tomcat-nginx:8.5.20-jdk jdpa start

## Warm up script
You can put warm up script at path `/usr/local/tomcat/bin/warmup.sh`, 
So it will run after start tomcat server. After warm up script finished, it will start nginx then.

To disable the warmup process, try setting environment varaible WARMUP to 0:-

	sudo docker run -d -e WARMUP=0 wongnai/tomcat-nginx:8.5.20-jdk 


## Extending the image
Basically this image should be used as base image. 

### Conf Directory
The tomcat and nginx configuration directories respectively are at :-
* /usr/local/tomcat/
* /etc/nginx

### Entrypoint
The entry point of the image should look like this:-

	ENTRYPOINT ["docker-entrypoint.sh"]
	CMD ["start"]