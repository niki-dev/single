FROM nginx:1.14.2 
RUN apt-get update && apt-get install openssl
RUN printf "admin:$(openssl passwd -apr1 admin)\n" >> /etc/nginx/htpasswd.users
