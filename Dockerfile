# FROM nginx
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# COPY ./dist /usr/share/nginx/html


FROM node:alpine as builder

WORKDIR 'app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
