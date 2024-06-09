FROM golang:1.22-alpine AS build
RUN apk add --no-cache git 
WORKDIR /go/src/gocalc
COPY . .
RUN  go mod init gocalc \
    && go mod tidy \
    && go build . 

FROM alpine:3.20 AS runner
WORKDIR /app
COPY --from=build /go/src/gocalc/gocalc .
EXPOSE 7000
CMD ["./gocalc"]

#VOLUME /dkr-14-gocalc
