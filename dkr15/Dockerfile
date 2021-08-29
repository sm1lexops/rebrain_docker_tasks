FROM golang:1.13.5-alpine 
ARG TOP_SECRET
ENV TOP_SECRET=${TOP_SECRET:-"I SHELL NOT PASS mthrfckr"}
RUN apk add --no-cache git 
COPY . /go/src/
WORKDIR /go/src/gocalc/
RUN  go mod init gocalc \
     && go mod tidy \
     && go build . \ 
     && echo $TOP_SECRET > top_secret.txt 

FROM alpine:3.10.3 
COPY --from=0 /go/src/gocalc  /dkr-15-gocalc
VOLUME /dkr-15-gocalc

