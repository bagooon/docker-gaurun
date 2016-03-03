FROM alpine:3.3
MAINTAINER xcezx <main.xcezx@gmail.com>

ARG GAURUN_VERSION
ENV GAURUN_VERSION ${GAURUN_VERSION:-0.4.2}

RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*

ADD https://github.com/mercari/gaurun/releases/download/v${GAURUN_VERSION}/gaurun-linux-amd64-${GAURUN_VERSION}.tar.gz /opt/gaurun-${GAURUN_VERSION}.tar.gz
RUN tar vxzf /opt/gaurun-${GAURUN_VERSION}.tar.gz -C /opt && \
    install -m 755 /opt/gaurun-${GAURUN_VERSION}/gaurun /usr/local/bin/gaurun && \
    install -m 755 /opt/gaurun-${GAURUN_VERSION}/gaurun_recover /usr/local/bin/gaurun_recover

ONBUILD ADD gaurun.toml /etc/gaurun/gaurun.toml
ONBUILD ADD ssl /etc/gaurun/ssl

EXPOSE 1056

CMD ["gaurun", "-c", "/etc/gaurun/gaurun.toml"]