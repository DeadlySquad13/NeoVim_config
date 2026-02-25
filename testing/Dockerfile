ARG DOCKERHUB_NEXUS_PROXY
ARG TARGET_NODE_VERSION
FROM $DOCKERHUB_NEXUS_PROXY/node:${TARGET_NODE_VERSION}-alpine AS base

ARG CI_COMMIT_TAG

# Установка зависимостей.
FROM base AS deps
WORKDIR /app

COPY ./package*.json ./
COPY ./packages/video/package.json ./packages/video/package.json

# Стадия сборки внутренних пакетов.
FROM base AS local-deps-builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules

# # common
WORKDIR /app/packages/common

# - Для обнаружения пакета.
COPY ./packages/common/package.json ./

COPY ./packages/common/tsconfig.rollup.json ./
COPY ./packages/common/tsconfig.json ./
COPY ./packages/common/rollup.config.ts ./
COPY ./packages/common/src ./src


# Стадия сборки.
FROM base AS builder

# # Внутренние пакеты
# ## constants
WORKDIR /app/packages/constants

# - Для обнаружения пакета.
COPY ./packages/constants/package.json ./

COPY ./packages/constants/tsconfig.json ./
COPY ./packages/constants/src ./src

# ## common, plutos
WORKDIR /app/packages

COPY --from=local-deps-builder /app/packages/common ./common
COPY --from=local-deps-builder /app/packages/plutos ./plutos

# # Root пакет.
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules

COPY tsconfig.json ./
COPY .browserslistrc ./

# - Для запуска скриптов.
COPY ./package.json ./

ARG PORT=8200

EXPOSE ${PORT}

ENV NGINX_PORT=${PORT}

ENTRYPOINT ["test"]
RUN ["test"]
