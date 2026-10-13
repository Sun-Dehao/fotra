# ————————————————————————————————————————————————
# FOTRA — self-host image (persistent Node host, NOT serverless)
# SQLite + minute-long agent runs + the git memory vault
# all demand a real process. Vercel et al will not work.
# ————————————————————————————————————————————————

FROM node:22-slim AS base
WORKDIR /app

FROM base AS deps
COPY package.json package-lock.json* ./
COPY prisma ./prisma
RUN npm install --no-audit --no-fund && npx prisma generate

FROM base AS build
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npx prisma generate && npm run build

FROM base AS run
ENV NODE_ENV=production
ENV HOSTNAME=0.0.0.0
ENV PORT=3000
# where the harness keeps its state — mount these
ENV DATABASE_URL=file:/data/fotra.db
ENV FOTRA_HOME=/fotra-home

RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static
COPY --from=build /app/public ./public
COPY --from=build /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=build /app/prisma ./prisma
COPY providers.json ./providers.json

# unprivileged runtime user; state dirs are writable
RUN mkdir -p /data /fotra-home && chown -R node:node /data /fotra-home /app
USER node

EXPOSE 3000
CMD ["node", "server.js"]
