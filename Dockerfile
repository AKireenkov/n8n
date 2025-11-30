FROM node:18-bullseye-slim

# n8n version we bake into the image. Override at build time if needed:
#   docker build --build-arg N8N_VERSION=1.64.0 -t my-n8n .
ARG N8N_VERSION=1.64.0

ENV \
  NODE_ENV=production \
  N8N_PORT=5678 \
  N8N_BASIC_AUTH_ACTIVE=false \
  N8N_BASIC_AUTH_USER=admin \
  N8N_BASIC_AUTH_PASSWORD=changeme \
  N8N_HOST=0.0.0.0 \
  WEBHOOK_URL=http://localhost:5678 \
  GENERIC_TIMEZONE=Etc/UTC

# Install tini for proper signal handling and n8n CLI globally.
RUN apt-get update \
  && apt-get install -y --no-install-recommends tini \
  && npm install -g n8n@"${N8N_VERSION}" \
  && npm cache clean --force \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /home/node

# Persist user data (workflows, credentials, etc.)
VOLUME ["/home/node/.n8n"]

EXPOSE ${N8N_PORT}

USER node

ENTRYPOINT ["tini", "--"]
CMD ["n8n", "start"]

