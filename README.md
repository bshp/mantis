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
    
#### Ports
Expose whatever ports you need with docker run -p, default is no ports, below are postfix specific
````
25  - Plain-text
465 - SSL
587 - StartTLS
````
#### Direct:  
````
docker run --entrypoint /usr/local/bin/ociectl -d bshp/mantis:latest --run
````
#### Custom:  
Add at end of your entrypoint script either of:  
````
/usr/local/bin/ociectl --run;
````
````
/usr/sbin/postfix -c /etc/postfix start-fg;
````
    
#### Build:  
VERSION = Ubuntu version to build, e.g 22.04, 24.04
````
docker build . --pull --build-arg VERSION=22.04 --tag YOUR_TAG
````
