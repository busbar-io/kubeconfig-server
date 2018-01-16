FROM nginx:1.10.3

# Kubernetes Config file
ADD config /usr/share/nginx/html/
ADD version.txt /usr/share/nginx/html/version.txt

# Additional config files
ADD *.config /usr/share/nginx/html/

CMD ["nginx", "-g", "daemon off;"]
