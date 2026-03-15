FROM node:20-slim AS builder

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends libc6 libc-bin && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

RUN ls -la /app

FROM node:20-slim AS runner

WORKDIR /app

ENV NODE_ENV=production

RUN apt-get update && \
    apt-get upgrade -y libc6 libc-bin && \
    rm -rf /var/lib/apt/lists/*
    
# Copy built assets and server file
COPY --from=builder /app/build ./build
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/package*.json ./

# Install only production dependencies (express)
RUN npm install --omit=dev

EXPOSE 3000

CMD ["node", "server.js"]
