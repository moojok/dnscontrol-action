FROM alpine:3.17.0@sha256:8914eb54f968791faf6a8638949e480fef81e697984fba772b3976835194c6d4

LABEL repository="https://github.com/moojok/dnscontrol-action"
LABEL maintainer="Little Human <hey@moojok.xyz>"

LABEL "com.github.actions.name"="DNSControl"
LABEL "com.github.actions.description"="Deploy your DNS configuration to multiple providers."
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="yellow"

ENV DNSCONTROL_VERSION="3.22.1"
ENV DNSCONTROL_CHECKSUM="2c327772618ce51dd04136c0d421b661f05783f651f6940bd93daa772dcb99a4"

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
