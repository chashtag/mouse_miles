FROM registry1.dso.mil/ironbank/opensource/python:latest
USER 0
RUN dnf install -y nginx
RUN pip install flask
RUN mkdir -p /etc/ssl/private && openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=GA/L=FGGA/O=A/CN=localhost" -keyout  /etc/ssl/private/nginx-selfsigned.key  -out /etc/ssl/certs/nginx-selfsigned.crt
COPY all.pem /etc/pki/
COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /
COPY track.py /
COPY web.py /
COPY templates /
WORKDIR /
ENTRYPOINT [ "/entrypoint.sh" ]