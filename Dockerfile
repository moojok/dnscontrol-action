FROM stackexchange/dnscontrol:4.7.2@sha256:29c770a0cc54bd19f66ce773c9d3324d686aded6ab91faaee6cb894cdc0d74c2

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
