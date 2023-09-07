FROM python:3.11

RUN apt-get update && apt-get install -y nginx
RUN pip install flask
RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=GA/L=FGGA/O=A/CN=localhost" -keyout  /etc/ssl/private/nginx-selfsigned.key  -out /etc/ssl/certs/nginx-selfsigned.crt
COPY all.pem /etc/pki/
COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /
COPY track.py /
COPY web.py /
ENTRYPOINT [ "/entrypoint.sh" ]