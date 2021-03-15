FROM pushcorn/ubuntu:latest

LABEL maintainer="joseph@pushcorn.com"

RUN qd ubuntu:begin-apt-install \
    && apt-get -y install \
        python3-pip \
        cron \
    && pip3 install certbot certbot-dns-cloudflare \
    && apt-get -y remove python3-pip \
    && apt-get -y install python3 python3-pkg-resources python3-setuptools \
    && qd ubuntu:end-apt-install \
    && mkdir -p /etc/letsencrypt \
    && touch /etc/letsencrypt/.first-time

COPY .qd /root/.qd

CMD [":run-task", "--task", "init,certbot:start"]
