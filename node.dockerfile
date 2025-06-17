FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .


FROM node:18-slim


ARG PACKAGES="curl nano"

RUN apt-get update && apt-get install -y $PACKAGES && mkdir -p /app && apt-get clean


WORKDIR /app

COPY --from=builder /app .

ENV NODE_ENV=production \
    TERM=xterm \
    APP_VERSION=1.0

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s \
  CMD curl --fail http://localhost:3000 || exit 1

CMD ["npm", "start"]

#Re-Written by Syed Hassan Rizwan 

#OLD DOCKERFILE: 

# FROM        node:alpine

# LABEL       author="Dan Wahlin"

# ARG         PACKAGES=nano

# ENV         TERM xterm
# RUN         apk update && apk add $PACKAGES

# WORKDIR     /var/www
# COPY        package*.json ./
# RUN         npm install

# COPY        . ./
# EXPOSE      3000

# ENTRYPOINT  ["npm", "start"]