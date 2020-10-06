FROM golang:1.14.4-stretch

ENV GO111MODULE=on

WORKDIR $GOPATH/src/github.com/carrotsong/ion

COPY go.mod go.sum ./
RUN cd $GOPATH/src/github.com/carrotsong/ion && go mod download

COPY pkg/ $GOPATH/src/github.com/carrotsong/ion/pkg
COPY cmd/ $GOPATH/src/github.com/carrotsong/ion/cmd

WORKDIR $GOPATH/src/github.com/carrotsong/ion/cmd/islb
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /islb .

FROM alpine:3.12.0
RUN apk --no-cache add ca-certificates
COPY --from=0 /islb /usr/local/bin/islb

COPY configs/docker/islb.toml /configs/islb.toml

ENTRYPOINT ["/usr/local/bin/islb"]
CMD ["-c", "/configs/islb.toml"]
