#### Mantis    
Postfix as an internal mail-relay to an internet mail server, e.g Microsoft 365, Google Workspace, etc.
    
This image is NOT meant to be used as an open, insecure relay host and is NOT configured for that purpose.    
Use case, haproxy ssl termination and acls to control access to the frontend using port 465, this container exposes port 25 on the container host, firewalld to only allow haproxy hosts access.    
This route was chosen as it minimizes the amount of postfix configuration needed and we needed to be able to utilize postfix's header_checks to modify outgoing headers instead of just using haporxy to connect to the internet mail server.
    
#### Base OS:  
Ubuntu Server LTS
    
#### Packages:  
Updated weekly from the official upstream Ubuntu LTS image
````
ca-certificates 
curl 
gnupg 
jq 
openssl 
mailutils 
postfix 
postfix-pcre 
procmail 
tzdata 
unzip 
wget
````
#### Environment :  
see [Ocie](https://github.com/bshp/ocie) for more info
````
HOSTNAME - sets [ mydestination, myhostname ] and for header_checks
INTERNAL_DOMAIN - sets header_checks to remove internal/private domain/hostnames in header to the HOSTNAME
MY_NETWORKS - sets the IP/Networks that are allowed to connect
RELAY_HOST - set the relay destination, e.g smtp.gmail.com:465
````
    
#### Ports
````
25  - Plain-text
````
#### Direct:  
````
docker run --entrypoint /usr/sbin/ociectl -d bshp/mantis:latest --run
````
#### Custom:  
Add at end of your entrypoint script either of:  
````
/usr/sbin/ociectl --run;
````
````
/usr/sbin/postfix -c /etc/postfix start-fg;
````
    
#### Build:  
VERSION = Ubuntu version to build, e.g 22.04, 24.04
````
docker build . --pull --build-arg VERSION=22.04 --tag YOUR_TAG
````
