# FROM nginx
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# COPY ./dist /usr/share/nginx/html

# stage-1

FROM node:alpine as vue_built

WORKDIR "app"

COPY package.json .

RUN yarn install

COPY . .

RUN yarn run build

# stage -2
FROM nginx:alpine
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=vue_built /app/dist /usr/share/nginx/html
