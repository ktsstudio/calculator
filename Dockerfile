FROM node:10.16.0-alpine as frontend_builder

WORKDIR /code

COPY yarn.lock .
COPY package.json .
RUN yarn install

COPY . .
RUN yarn build

FROM nginx:alpine

COPY --from=frontend_builder /code/build/ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080
