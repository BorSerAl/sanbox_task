###	1.	Install docker. (Hint: please use VMs or Clouds  for this.)
###     	 	EXTRA 1.1. Write bash script for installing Docker.
####	  Docker without sudo
    sudo usermod -aG docker ${USER}
    su - ${USER}

###    script
    apt-get update
    apt-get -y install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
     apt-get -y update
     apt-get -y install docker-ce docker-ce-cli containerd.io


###	2.   Find, download and run any docker container "hello world". (Learn commands and parameters to create/run docker containers.
    docker pull hello world
###	2.1  EXTRA Use image with html page, edit html page and paste text: Username 2022

    docker search apache2
    docker run -P -d ubuntu/apache2
	  docker ps -a
	  docker exec -it CONTAINER ID /bin/bash
	  echo SerBor 2022 > var/www/html/index.html
	  exit
    curl http://localhost:port
    SerBor 2022

###	3.1. Create your Dockerfile for building a docker image. Your docker image should run any web application (nginx, apache, httpd). Web application should be located inside the docker image.

      FROM httpd:2.4
      COPY ./index.html /usr/local/apache2/htdocs/
  docker build -t t3httpd .
  docker run -dit --name my-running-app -p 8080:80 apache2
  curl http://localhost:8080

###	EXTRA 3.1.1. For creating docker image use clear basic images (ubuntu, centos, alpine, etc.)
###	3.2. Add an environment variable "DEVOPS=<username> to your docker image
###	EXTRA 3.2.1. Print environment variable with the value on a web page (if environment variable changed after container restart - the web page must be updated with a new value)

      FROM ubuntu:latest
      ENV TZ=Asia/Krasnoyarsk
      RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
      RUN apt-get -y update
      RUN apt-get -y install apache2
      ENV DEVOPS=SerBor
      RUN echo "env DEVOPS = $DEVOPS" > /var/www/html/index.html
      CMD ["/bin/sh","-c","echo ${DEVOPS}>> /var/www/html/index.html; /usr/sbin/apache2ctl -DFOREGROUND"]
      EXPOSE 80
	
  	docker build -t serbor/task:latest .
  	docker run -dit --name my-running-app -p 8080:80 apache2
  	curl http://localhost:8080

###	4. Push your docker image to docker hub (https://hub.docker.com/). Create any description for your Docker image.
###	   EXTRA 4.1. Integrate your docker image and your github repository. Create an automatic deployment for each push. (The Deployment can be in the “Pending” status for 10-20 minutes. This is normal).

  	docker login
  	docker push serbor/task:latest
  	latest: digest: sha256:

###	Actions
	
	name: Docker Image CI

	on:	
  	  push:
            branches: [ main ]
  	  pull_request:
            branches: [ main ]
  	jobs:
  	  build:
  	     	runs-on: ubuntu-latest
  	     	steps:
  	     -
   		name: Checkout
   		uses: actions/checkout@v2
  	     -
    		name: Login to Docker Hub
    		uses: docker/login-action@v1
    		with:
      		  username: ${{ secrets.DOCKER_LOGIN }}
      		  password: ${{ secrets.DOCKER_PASSWORD}}
  	      -
    		name: Build and Push
    		uses: docker/build-push-action@v2
    		with:
      		  file: Dockerfile
      		  push: true
		  tags: serbor/task:latest

###	5.  Create docker-compose file. Deploy a few docker containers via one docker-compose file.
###   	first image - your docker image from the previous step. 5 nodes of the first image should be run;
###  	second image - any java application;
###  	last image - any database image (mysql, postgresql, mongo or etc.).
###   	Second container should be run right after a successful run of a database container.
### 	EXTRA 5.1. Use env files to configure each service

		version: '3'

		services:
		  task3_image:
		    image: ${TASK3_IMAGE}
		    deploy:
		      replicas: 5
		    ports:
		      - ${TASK3_IMAGE_PORTS}
		    restart: always
	
		  java_app:
		    image: ${JAVA_APP}
		    ports:
		        - "8888:8080"
		    depends_on:
		      - db

		  db:
		     image: ${DB_IMAGE}
		     environment:
		      - POSTGRES_DB=${pg_DB}
		      - POSTGRES_USER=${PG_USER}
		      - POSTGRES_PASSWORD=${PG_PASS}

#	.env
	TASK3_IMAGE=524e4e6fc5e9
	TASK3_IMAGE_PORTS=8050-8054:80
	JAVA_APP=2f765403878f
	DB_IMAGE=postgres
	pg_DB=MYDB
	PG_USER=user
	PG_PASS=POSTGRES_PASSWORD
