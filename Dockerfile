# FROM golang:1.9

# RUN mkdir /echo

# COPY main.go /echo

# CMD [ "go", "run", "/echo/main.go" ]

# ==================================================
# Build Layer
FROM golang:1.12-alpine as build

WORKDIR /go/app

COPY . .

RUN apk add --no-cache git && \
    go build -o app

#==================================================
# Run Layer
FROM alpine

WORKDIR /app

COPY --from=build /go/app/app .

RUN addgroup go && \
    adduser -D -G go go && \
    chown -R go:go /app/app

CMD ["./app"]