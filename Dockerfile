# ==================================================
# Build Layer
FROM golang:1.9-alpine as build

WORKDIR /echo

COPY main.go .

#==================================================
# Run Layer
FROM golang:1.9

WORKDIR /app

COPY --from=build /echo .

CMD [ "go", "run", "/app/main.go" ]