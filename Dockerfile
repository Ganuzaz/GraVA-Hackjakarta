
FROM node:18-alpine as module-install-stage
RUN apk add --update python3 make g++\
   && rm -rf /var/cache/apk/*
WORKDIR /usr/app
COPY package.json .
RUN apk add yarn
RUN yarn install


FROM node:18-alpine as build-stage
COPY --from=module-install-stage /usr/app/node_modules /usr/app/node_modules
WORKDIR /usr/app
COPY . .
RUN yarn build


FROM node:18-alpine as final-stage
WORKDIR /usr/app
COPY package.json .
COPY --from=build-stage /usr/app/yarn.lock .
COPY --from=build-stage /usr/app/dist ./dist
COPY --from=build-stage /usr/app/node_modules ./node_modules


