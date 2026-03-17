FROM node:22-alpine AS builder

WORKDIR /app

RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache zlib=1.3.2-r0

RUN npm install -g npm@latest

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


FROM node:22-alpine

WORKDIR /app

RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache zlib=1.3.2-r0

COPY --from=builder /app ./

RUN rm -rf /usr/local/lib/node_modules/npm

USER node
EXPOSE 3000
CMD ["node", "server.js"]