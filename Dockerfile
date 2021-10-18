FROM node:14-alpine as builder
ARG miniPaintVersion="v4.9.1"

RUN apk add git
WORKDIR /usr/src/app
RUN git clone https://github.com/viliusle/miniPaint.git \
    && cd miniPaint \
    && git checkout $miniPaintVersion \
    && npm install \
    && npm run build

FROM caddy:2-alpine
COPY --from=builder /usr/src/app/miniPaint/index.html /usr/share/caddy/index.html
COPY --from=builder /usr/src/app/miniPaint/dist/ /usr/share/caddy/dist/
COPY --from=builder /usr/src/app/miniPaint/images/ /usr/share/caddy/images/
