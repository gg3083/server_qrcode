FROM golang:1.16 as build-stage
WORKDIR /app
COPY . .
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
ENV GOARM=6
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go mod download && go mod verify && go build -ldflags="-s -w" -o main

FROM alpine:3.11
WORKDIR /app
COPY --from=build-stage /app/main .
RUN echo 'http://mirrors.ustc.edu.cn/alpine/v3.5/main' > /etc/apk/repositories \
    && echo 'http://mirrors.ustc.edu.cn/alpine/v3.5/community' >>/etc/apk/repositories \
    && apk update \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
ENV run_prot = ${port}
EXPOSE ${port}
CMD "./main" ${port}