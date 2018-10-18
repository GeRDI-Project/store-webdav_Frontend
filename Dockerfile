FROM nginx:1.15.5-alpine
RUN apk add nodejs npm git
WORKDIR /home/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN cp build/docker/default.conf /etc/nginx/conf.d/default.conf
CMD nginx -g "daemon off;"
