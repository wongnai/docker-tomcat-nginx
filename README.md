# Tomcat with Nginx
This docker image uses official tomcat (https://hub.docker.com/_/tomcat/) as base image and add the nginx (https://hub.docker.com/_/nginx/) for :-
1. serving static files 
2. do basic http headers eg. cache / expires
3. redirecting 
4. proxy to tomcat
 

## Starting a container with nignx (default)
To start a container with nginx (daemon), just simply run the container without any argument.
	
	sudo docker run -d wongnai/tomcat-nginx:8.5.5-jre8
	
After starting the container, you should be able to make a request to both nginx (port 80) and tomcat (port 8080).

## Starting a container without nginx
	
### Without Nginx
Just pass any argument when running a new container so that the container is not start nginx daemon.

	sudo docker run -d wongnai/tomcat-nginx:8.5.5-jre8 no-nginx


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

