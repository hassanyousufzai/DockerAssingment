

FROM        node:alpine

LABEL       author="Dan Wahlin"

ARG         PACKAGES=nano

ENV         TERM xterm
RUN         apk update && apk add $PACKAGES

WORKDIR     /var/www
COPY        package*.json ./
RUN         npm install

COPY        . ./
EXPOSE      3000

ENTRYPOINT  ["npm", "start"]
