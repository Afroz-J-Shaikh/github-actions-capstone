FROM node:20-alpine AS builder
WORKDIR /app

# 1. Standardize the build
COPY package.json package-lock.json ./
RUN npm install --omit=dev
COPY . .
RUN npm run build

# --- RUNNER STAGE ---
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# 2. Patch Alpine OS
RUN apk update && apk upgrade --no-cache

# 3. Copy ONLY what is needed for production
COPY --from=builder /app/build ./build
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/package*.json ./

# 4. Copy the node_modules directly from the builder
COPY --from=builder /app/node_modules ./node_modules

# 5. Clean up devDependencies if necessary (Optional but safer)
RUN npm prune --omit=dev

USER node
EXPOSE 3000
CMD ["node", "server.js"]