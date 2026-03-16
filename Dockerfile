FROM node:20-alpine AS builder
WORKDIR /app

# 1. Use ONLY the lockfiles first to leverage Docker cache
COPY package.json package-lock.json ./

# 2. Force a clean install that matches your patched lockfile EXACTLY
# This is the most important change for passing the security scan.
RUN npm ci 

COPY . .
RUN npm run build

# --- RUNNER STAGE ---
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# 3. Patch Alpine OS
RUN apk update && apk upgrade --no-cache

# 4. Copy ONLY production assets
COPY --from=builder /app/build ./build
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/package.json /app/package-lock.json ./

# 5. Copy the node_modules and then prune
COPY --from=builder /app/node_modules ./node_modules

# This removes the dev-tools (like Vite/Vitest) that contained the 
# vulnerable 'minimatch' version 9, leaving only your safe 10.2.3 version.
RUN npm prune --omit=dev

USER node
EXPOSE 3000
CMD ["node", "server.js"]