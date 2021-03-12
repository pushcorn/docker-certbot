FROM pushcorn/ubuntu:latest

LABEL maintainer="joseph@pushcorn.com"

ARG CERTBOT_VERSION=*
ARG BUILD_ID=NA
ENV BUILD_ID=$BUILD_ID

RUN qd ubuntu:begin-apt-install \
    && qd ubuntu:add-ppa-repo --package certbot/certbot \
    && apt-get -y install \
        certbot=$CERTBOT_VERSION \
        python3-certbot-apache \
        python3-certbot-dns-cloudflare \
        python3-certbot-dns-digitalocean \
        python3-certbot-dns-dnsimple \
        python3-certbot-dns-google \
        python3-certbot-dns-rfc2136 \
        python3-certbot-dns-route53 \
        python3-certbot-nginx \
    && qd ubuntu:end-apt-install

COPY .qd /root/.qd

CMD [":run-task", "--task", "init,certbot:start"]
