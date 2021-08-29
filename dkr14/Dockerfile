FROM golang:1.13.5-alpine AS build
RUN apk add --no-cache git 
COPY . /go/src/
WORKDIR /go/src/
RUN  go mod init gocalc \
     && go mod tidy \
     && go build . 

FROM alpine:3.10.3 AS runner
COPY --from=build /go/src/gocalc /dkr-14-gocalc
#VOLUME /dkr-14-gocalc
