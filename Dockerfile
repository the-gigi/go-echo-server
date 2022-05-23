FROM golang:1.18 AS builder

WORKDIR /build

ADD ./go.mod  go.mod
ADD ./echo_server.go echo_server.go

# Update
RUN apt-get --allow-releaseinfo-change update && apt upgrade -y

# Fetch dependencies
RUN go mod download all

# Build image as a truly static Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -o /echo_server -a -tags netgo -ldflags '-s -w' .

FROM scratch
MAINTAINER Gigi Sayfan <the.gigi@gmail.com>
COPY --from=builder /echo_server /echo_server
EXPOSE 7070
ENTRYPOINT ["/echo_server", "7070"]