# Build stage
FROM oven/bun:1 AS builder

WORKDIR /app

# Copy package files
COPY package.json bun.lock bunfig.toml ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy source code
COPY . .

# Runtime stage
FROM oven/bun:1-slim

WORKDIR /app

# Copy dependencies and source
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
COPY --from=builder /app/app ./app
COPY --from=builder /app/index.ts ./index.ts
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/tsconfig.json ./tsconfig.json
COPY --from=builder /app/.agents ./.agents
COPY --from=builder /app/.mcp.json ./.mcp.json

RUN chown -R bun:bun /app
USER bun

CMD ["bun", "run", "index.ts"]
