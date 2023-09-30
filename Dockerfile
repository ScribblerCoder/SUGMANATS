FROM golang:1.20-alpine as builder

RUN apk add --no-cache --update gcc g++
WORKDIR /app

COPY src/ /app
RUN go mod download
RUN CGO_ENABLED=1 GOOS=linux go build -o /app/SUGMANATS

FROM alpine:3.17

WORKDIR /app
COPY --from=builder /app /app

EXPOSE 80
ENTRYPOINT ["/app/SUGMANATS"]
