FROM nginx:1.13.0
COPY build/docker/default.conf /etc/nginx/conf.d/default.conf
COPY dist/index.html /usr/share/nginx/html/index.html
ADD dist/store/static /usr/share/nginx/html/store/static
