# Build stage
# Force linux/amd64: @anush008/tokenizers has no linux-arm64-gnu binary published
FROM --platform=linux/amd64 oven/bun:1 AS builder

WORKDIR /app

# Copy package files
COPY package.json bun.lock bunfig.toml ./

# Install dependencies
RUN bun install

# Copy all source code
COPY . .

# Runtime stage
FROM --platform=linux/amd64 oven/bun:1-slim

WORKDIR /app

# Install gog CLI for Google Workspace integration
ARG GOG_VERSION=0.9.0
RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates && \
    wget -O /tmp/gog.tar.gz \
      "https://github.com/steipete/gogcli/releases/download/v${GOG_VERSION}/gogcli_${GOG_VERSION}_linux_amd64.tar.gz" && \
    tar -xzf /tmp/gog.tar.gz -C /usr/local/bin gog && \
    chmod +x /usr/local/bin/gog && \
    rm /tmp/gog.tar.gz && \
    apt-get purge -y wget && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Copy everything from builder
COPY --from=builder /app ./

RUN chown -R bun:bun /app
USER bun

CMD ["bun", "run", "index.ts"]
