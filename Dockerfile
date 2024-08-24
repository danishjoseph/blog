FROM klakegg/hugo:ext-alpine as builder

WORKDIR /app

ENV HUGO_ENV=production

COPY . /app

RUN hugo --minify

FROM caddy:alpine

COPY --from=builder /app/public /srv

EXPOSE 80

CMD ["caddy", "file-server", "--root", "/srv"]