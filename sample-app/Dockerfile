ARG ALPINE_VERSION=3.19⁠
FROM node:22-alpine3.19⁠ as builder

WORKDIR /build-stage
COPY package*.json ./

RUN npm install --production


FROM alpine:3.19⁠ as app
WORKDIR /usr/src/app
# Add required binaries
RUN apk add --no-cache libstdc++ dumb-init \
  && addgroup -g 1000 node && adduser -u 1000 -G node -s /bin/sh -D node \
  && chown node:node ./

COPY --from=builder /usr/local/bin/node /usr/local/bin/
COPY --from=builder /usr/local/bin/docker-entrypoint.sh /usr/local/bin/

USER node
COPY --from=builder /build-stage/node_modules ./node_modules
ADD server.js ./server.js

CMD ["dumb-init", "node", "server.js"]