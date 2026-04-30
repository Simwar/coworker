# Build stage
FROM oven/bun:1 AS builder

WORKDIR /app

# Copy package files
COPY package.json bun.lock bunfig.toml ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy all source code
COPY . .

# Runtime stage
FROM oven/bun:1-slim

WORKDIR /app

# Copy everything from builder
COPY --from=builder /app ./

RUN chown -R bun:bun /app
USER bun

CMD ["bun", "run", "index.ts"]
