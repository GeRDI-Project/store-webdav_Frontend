FROM nginx:1.15.5-alpine
WORKDIR /home/app
COPY . /home/app
RUN mkdir /usr/share/nginx/html/store
RUN mkdir /usr/share/nginx/html/store/static
RUN apk add nodejs npm git
RUN npm install
RUN npm run build
RUN cp build/docker/default.conf /etc/nginx/conf.d/default.conf
RUN cp dist/index.html /usr/share/nginx/html/store/index.html
RUN cp -r dist/store/static/* /usr/share/nginx/html/store/static
CMD nginx -g "daemon off;"
