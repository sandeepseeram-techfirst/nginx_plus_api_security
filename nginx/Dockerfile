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

# Install NGINX Plus
# Install NGINX Plus
RUN set -ex \
  && apt-get update && apt-get upgrade -y \
  && apt-get install --no-install-recommends --no-install-suggests -y curl sudo vim procps  apt-utils apt-transport-https ca-certificates gnupg1 dh-python distro-info-data libmpdec2 libpython-stdlib libpython3-stdlib \
  libpython3.5-minimal libpython3.5-stdlib lsb-release python python-minimal \
  python3 python3-minimal python3.5 python3.5-minimal binutils net-tools \
  && \
  NGINX_GPGKEY=573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62; \
  found=''; \
  for server in \
    ha.pool.sks-keyservers.net \
    hkp://keyserver.ubuntu.com:80 \
    hkp://p80.pool.sks-keyservers.net:80 \
    pgp.mit.edu \
  ; do \
    echo "Fetching GPG key $NGINX_GPGKEY from $server"; \
    apt-key adv --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$NGINX_GPGKEY" && found=yes && break; \
  done; \
  test -z "$found" && echo >&2 "error: failed to fetch GPG key $NGINX_GPGKEY" && exit 1; \
  echo "Acquire::https::plus-pkgs.nginx.com::Verify-Peer \"true\";" >> /etc/apt/apt.conf.d/90nginx \
  && echo "Acquire::https::plus-pkgs.nginx.com::Verify-Host \"true\";" >> /etc/apt/apt.conf.d/90nginx \
  && echo "Acquire::https::plus-pkgs.nginx.com::SslCert     \"/etc/ssl/nginx/nginx-repo.crt\";" >> /etc/apt/apt.conf.d/90nginx \
  && echo "Acquire::https::plus-pkgs.nginx.com::SslKey      \"/etc/ssl/nginx/nginx-repo.key\";" >> /etc/apt/apt.conf.d/90nginx \
  && printf "deb https://plus-pkgs.nginx.com/debian stretch nginx-plus\n" > /etc/apt/sources.list.d/nginx-plus.list \
  && apt-get update && apt-get install -y nginx-plus  \
  && rm -rf /var/lib/apt/lists/* \
  # Install Controller Agent
  && curl -k -sS -L ${CONTROLLER_URL}/install/controller/ > install.sh \
  && sed -i 's/^assume_yes=""/assume_yes="-y"/' install.sh \
  && sh ./install.sh -y \
  && sed -i "s|store_uuid = False|store_uuid = True|g" /etc/controller-agent/agent.conf


# Forward request logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx-controller/agent.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log



EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

ENTRYPOINT ["sh", "/entrypoint.sh"]
