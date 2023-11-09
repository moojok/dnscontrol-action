FROM alpine:3.18.4@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978

LABEL repository="https://github.com/koenrh/dnscontrol-action"
LABEL maintainer="Koen Rouwhorst <info@koenrouwhorst.nl>"

LABEL "com.github.actions.name"="DNSControl"
LABEL "com.github.actions.description"="Deploy your DNS configuration to multiple providers."
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="yellow"

ENV DNSCONTROL_VERSION="3.31.4"
ENV DNSCONTROL_CHECKSUM="054d236531df2674c9286279596f88f02c1cf7b1448dc5f643f1a1dbe705fe8d"

RUN apk -U --no-cache upgrade && \
    apk add --no-cache bash ca-certificates curl libc6-compat

RUN curl -sL "https://github.com/StackExchange/dnscontrol/releases/download/v$DNSCONTROL_VERSION/dnscontrol-Linux" \
  -o dnscontrol && \
  echo "$DNSCONTROL_CHECKSUM  dnscontrol" | sha256sum -c - && \
  chmod +x dnscontrol && \
  mv dnscontrol /usr/local/bin/dnscontrol

RUN ["dnscontrol", "version"]

COPY README.md entrypoint.sh bin/filter-preview-output.sh /
ENTRYPOINT ["/entrypoint.sh"]
