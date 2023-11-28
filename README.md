# Inception
DevOps project on setting up a simple Wordpress website with Nginx and Mariadb database via docker-compose.  
It will be initialized with two users with admin and basic permissions as per the .env file. The site can be accessed with HTTPS protocol and it has self signed certificate.  

## Usage  
Run in the terminal:
```
git clone https://github.com/bklvsky/Inception.git
cd Inception
make
```
This will set up infrastrcuture and configure a local Wordpress site on the address from WP_URL in srcs/.env file.  
As per the .env from the repository you can access the site with https://dselmy.42.fr
To change the site address, edit the srcs/.env file and the ADRESS variable in Makefile.  
To stop and flush website's containers run `Makefile clean`. If you also want to flush all data, including database, run `Makefile fclean`. 

## Dependencies  
You will need docker-compose utility installed on your machine. For Ubuntu you can run the start.sh script and check the installation with `docker-compose --version` command.  
To run the script run:  
```
cd Inception
./start.sh
```
