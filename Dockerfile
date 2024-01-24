FROM stackexchange/dnscontrol:4.8.2@sha256:428ceefd47cd95e79fd92ac71e11917d180a94f10880c8dc5f405ac60078c845

LABEL repository="https://github.com/moojok/dnscontrol-action"
LABEL maintainer="Little Human <hey@moojok.online>"

LABEL "com.github.actions.name"="DNSControl"
LABEL "com.github.actions.description"="Deploy your DNS configuration to multiple providers."
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="yellow"

RUN apk -U --no-cache upgrade && \
    apk add --no-cache --upgrade bash ca-certificates curl grep libc6-compat && \
    update-ca-certificates

RUN ["dnscontrol", "version"]

COPY README.md entrypoint.sh bin/filter-preview-output.sh /
ENTRYPOINT ["/entrypoint.sh"]
