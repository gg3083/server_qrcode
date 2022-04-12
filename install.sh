docker build -t qrcode:v1 .


docker run -d -p 8093:8093 --name qrcode_1 qrcode:v1

docker run -d -p 8084:8084 -e port="8084" --name qrcode_1 qrcode:v1


docker logs -f qrcode_1

docker rm -f qrcode_1

docker rmi qrcode:v1