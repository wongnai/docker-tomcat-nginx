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
Just pass any argument when running a new container so that the container is not start nginx daemon.

	sudo docker run -d wongnai/tomcat-nginx:8.5.20-jdk no-nginx


## Extending the image
Basically this image should be used as base image. 

### Conf Directory
The tomcat and nginx configuration directories respectively are at :-
* /usr/local/tomcat/
* /etc/nginx

### Entrypoint
The entry point of the image should look like this:-

	ENTRYPOINT ["docker-entrypoint.sh"]
	CMD ["with-nginx"]


## Docker entrypoint
The docker-entrypoint.sh can parse multiple arguments. The following list are all command arguments:-

* with-nginx - start nginx
* nowarmup - disable warmup process

For example, to run the container with nginx but without warmup, just run the following command:-

	sudo docker run -d wongnai/tomcat-nginx:8.5.20-jdk with-nginx nowarmup


### Catalina command
You are able to pass command to the catalina.sh using environment variable "CATALINA_COMMAND" (default to start).
For example, to run catalina in debug mode, just start docker container using the following command:-

	sudo docker run -d \
		-e CATALINA_COMMAND=debug
		wongnai/tomcat-nginx:8.5.20-jdk no-nginx

### Warm up script
You can put warm up script at path `/usr/local/tomcat/bin/warmup.sh`, 
So it will run after start tomcat server. After warm up script finished, it will start nginx then.
