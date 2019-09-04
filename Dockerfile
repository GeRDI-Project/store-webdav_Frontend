FROM nginx:1.15.5-alpine
WORKDIR /home/app
RUN apk add nodejs npm git
COPY build/docker/default.conf /etc/nginx/conf.d/default.conf
COPY . /home/app
RUN npm install
RUN npm run build
RUN mkdir /usr/share/nginx/html/store
RUN mkdir /usr/share/nginx/html/store/webdav-store
RUN mkdir /usr/share/nginx/html/store/webdav-store/static
RUN cp dist/index.html /usr/share/nginx/html/store/webdav-store/index.html
RUN cp -r dist/store/webdav-store/static/* /usr/share/nginx/html/store/webdav-store/static
CMD nginx -g "daemon off;"
