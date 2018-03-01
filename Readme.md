# Snorby Docker Image

Docker image with Snorby using Debian-8 Jessie and Ruby on Rails.

This Container only embedded the snorby web interface and connect to a database.
To deploy the container, you just need to specify the database information to connect to.
If your database is not already yet, the container can install/reset/delete it for you



# Environmental Variable
In this Image you can use environmental variables to connect into external MySQL/MariDB database. 
### Basic Usage if the database is already setup (see next section)

    docker run -d --name snorby -p 80:80 --env="MYSQL_HOST=database_ip" --env="MYSQL_USER=snorby" \
    --env="MYSQL_PASSWORD=snorby" troptop/docker-snorby
- `MYSQL_HOST` = Database hostname
- `MYSQL_DBNAME` = Database Name that you want to create
- `MYSQL_USER` = User name that will have access to the database
- `MYSQL_PASSWORD` = The password of the user that will have access to the database

### To install the snorby database schema 
You need to use the following Environmental Variable :

`ADD_DBUSER`= If different to "false" (minuscule) the container will create a user called `MYSQL_USER` 
with ALL privileges to the MYSQL_DBNAME database.
If the `ADD_DBUSER` is set the following ENV are required too :
- `MYSQL_ADMIM`= Admin user with the privileges to create the database
- `MYSQL_ADMINPASS` = Admin password to create the database
- `MYSQL_HOST` = Database hostname
- `MYSQL_DBNAME` = Database Name that you want to create
- `MYSQL_USER` = User name that will have access to the database
- `MYSQL_PASSWORD` = The password of the user that will have access to the database
- 
`DELETEDB`= If different to "false" (minuscule) the container will drop the database called `MYSQL_DBNAME`.
If the `DELETEDB` is set the following ENV are required too :
- `MYSQL_ADMIM`= Admin user with the privileges to create the database
- `MYSQL_ADMINPASS` = Admin password to create the database
- `MYSQL_HOST` = Database hostname
- `MYSQL_DBNAME` = Database Name that you want to create

`RESETDB`= If different to "false" (minuscule) the container will reset the database called `MYSQL_DBNAME`. it swipe all the data (metric/events/alert...) except user data (users table)
If the `RESETDB` is set the following ENV are required too :
- `MYSQL_HOST` = Database hostname
- `MYSQL_DBNAME` = Database Name that you want to create
- `MYSQL_USER` = User name that will have access to the database
- `MYSQL_PASSWORD` = The password of the user that will have access to the database

`INSTALLDB`= If different to "false" (minuscule) the container will create a database called `MYSQL_DBNAME`.
If the `INSTALLDB` is set the following ENV are required too :
- `MYSQL_HOST` = Database hostname
- `MYSQL_DBNAME` = Database Name that you want to create
- `MYSQL_USER` = User name that will have access to the database
- `MYSQL_PASSWORD` = The password of the user that will have access to the database

**Example :**
This example will create a container that :
    - firstly delete the database snorby (if exist)

    docker run -d --name snorby -p 80:80 --env="MYSQL_HOST=database_ip" --env="MYSQL_USER=snorby" \
    --env="MYSQL_PASSWORD=snorby" --env="MYSQL_DBNAME=snorby" --env="DELETEDB" --env="MYSQL_ADMIN=root" \
    --env="MYSQL_ADMINPASS=rootpassword" troptop/docker-snorby


    - secondly create a new database snorby
    - finally start the snorby web application
    

    docker run -d --name snorby -p 80:80 --env="MYSQL_HOST=database_ip" --env="MYSQL_USER=snorby" \
    --env="MYSQL_PASSWORD=snorby" --env="MYSQL_DBNAME=snorby" --env="INSTALLDB" --env="MYSQL_ADMIN=root" \
    --env="MYSQL_ADMINPASS=rootpassword" troptop/docker-snorby


### Access Snorby web interface
Visit your `snorby_ip:port` to access snorby interface and use default credentials:  
Username: **snorby@snorby.org**  
Password: **snorby**  
### Database deployment 
To be able to connect to database we would need one to be running first. Easiest way to do that is to use another docker image. 
Example:  

    docker run \
    -d \
    --name snorby-db \
    --env="MYSQL_USER=snorby" \
    --env="MYSQL_PASSWORD=snorby" \
    --env="MYSQL_DATABASE=snorby" \
    --env=" MYSQL_ROOT_PASSWORD=my_password" \
        mariadb
        
## Author
  
Author: [Cymatic](http://www.cymatic.eu) (<info@cymatic.eu>) - [www.cymatic.eu](http://www.cymatic.eu)

---
