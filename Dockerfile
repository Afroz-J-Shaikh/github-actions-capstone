FROM node:22-alpine AS builder

WORKDIR /app

RUN npm install -g npm@latest

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app ./

RUN rm -rf /usr/local/lib/node_modules/npm

USER node
EXPOSE 3000
CMD ["node", "server.js"]