## docker build --build-arg CONTROLLER_URL=https://controller.lab.local:8443/1.4 --build-arg API_KEY='289c48cbc811635e38b08da4ce9d5e1d' --add-host=controller.lab.local:10.1.20.11 --no-cache -t nginx-plus:34rc3 .

FROM debian:stretch-slim

LABEL maintainer="NGINX Controller Engineering"

ARG cert=nginx-repo.crt
ARG key=nginx-repo.key

# e.g '1234567890'
ARG API_KEY
ENV ENV_API_KEY=$API_KEY

# e.g https://<fqdn>:8443/1.4
ARG CONTROLLER_URL
ENV ENV_CONTROLLER_URL=$CONTROLLER_URL

# used to fix a bug with UUID persistancy
#ARG HOSTNAME
#ENV CONTROLLER_HOSTNAME=$HOSTNAME

# Download certificate and key from the customer portal (https://cs.nginx.com)
# and copy to the build context
RUN mkdir -p /etc/nginx/sites-enabled/
COPY $cert /etc/ssl/nginx/
COPY $key /etc/ssl/nginx/
COPY stub_status.conf /etc/nginx/sites-enabled/
COPY nginx-plus-api.conf /etc/nginx/conf.d/
COPY ./entrypoint.sh /