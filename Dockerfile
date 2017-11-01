FROM nginx:1.10.3

ADD config /usr/share/nginx/html/config
ADD version.txt /usr/share/nginx/html/version.txt

CMD ["nginx", "-g", "daemon off;"]
