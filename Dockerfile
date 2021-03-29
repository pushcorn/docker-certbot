FROM pushcorn/ubuntu:20.04

LABEL maintainer="joseph@pushcorn.com"

RUN qd ubuntu:begin-apt-install \
    && apt-get -y install \
        python3-pip \
    && pip3 install \
        "certbot==1.13.0" \
        "certbot-dns-cloudflare==1.13.0" \
    && apt-get -y remove python3-pip \
    && apt-get -y install \
        python3 \
        python3-pkg-resources \
        python3-setuptools \
    && qd ubuntu:end-apt-install \
    && mkdir -p /etc/letsencrypt \
    && qd :install --command openssl:view-cert

CMD [":run-task", "--task", "start,certbot:start"]
