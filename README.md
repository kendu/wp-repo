#Wordpress project
This repository is intended for wordpress development.
The wp directory is mounted into the docker container running apache as
wp-content

## Requirements
Docker and docker-composed are required to run this project locally.
These tools run native on linux, but can be run via boot2docker on windows/mac.

### docker
For installation details consult the installation guide on:
`https://docs.docker.com/installation/ubuntulinux/`

### docker-compose
The easiest way to install docker-compose is using pip.
```
pip install -U docker-compose
```
For more details consult the installation guide:
`https://docs.docker.com/compose/install/`

## Getting started

### Preparations

#### Preparing files

##### docker-compose.yml

Basically, the repo is ready to go. Still you should change the following
lines in the docker-compose.yml, for both security and logical purpose:
```
VIRTUAL_HOST
WORDPRESS_DB_USER
WORDPRESS_DB_PASSWORD
WORDPRESS_DB_NAME
MYSQL_USER
MYSQL_PASSWORD
MYSQL_DATABASE
MYSQL_ROOT_PASSWORD
hostname
```
You must care that the following variables must match:
```
WORDPRESS_DB_USER       =   MYSQL_USER
WORDPRESS_DB_PASSWORD   =   MYSQL_PASSWORD
WORDPRESS_DB_NAME       =   MYSQL_DATABASE
```
###### `/etc/hosts`

The hosts file must include the address of your wordpress container
 so you can reach it via the doamin name rather than using the IP address.
the line should look like:
```
127.0.0.1   wp-repo.local
```
Where wp-repo.local should be replaced with the value of the `VIRTUAL_HOST`
variable. This is also the address you will use to reach your site.
#### First run

```
./provision/setup.sh
```
This will also run the proxy container, which is necessary to forward the trafic
from your wordpress container to your host.
>This will fail if your local port 80
is already in use.
This can occur if You are already running a container on port 80,
or other services such as apache or nginx.

This will also raise the docker containers and run any provisioning specified
in the preBuild config file.

#### Further runs.

Any further run can be done with the run.sh script:
```
./run.sh
```
The script starts the containers if they are not running yet, and sets file
permissions so that both you and the apache serving the files can access them.

### Provisioning your installation.

To use any tools such as: composer, npm, bower, grunt, gulp... There is a
builder container that go created when the docker-compose was run.
If you want to run things manually, just run it via this container like this:
```
docker-compose run builder <command to run>
```
I personally prefer to just start a bash session and run things from there:
```
docker-compose run builder bash
```

But of course you won't be running things manually, now will you?
To make things tidier, add all commands needed to run to the provisionDeploy
script. This commands will be run when the setup script is run.

### Gitignore flie

By default the gitignore file contains the the wp directory. So if you're working on a theme or something, you should add an exception to the `wp/themes/.gitignore` file like this:
```
!/<name_of_theme_you_are_working_on>
```
# Known issues

* Sometimes there is permission error, because wordpres chowns all its files
to www-data user. running the `run.sh` script fixes this problem.
