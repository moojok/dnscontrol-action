FROM stackexchange/dnscontrol:4.9.0@sha256:9999a62045c30de6d6e58ed8f6a4a4180c6026f9fbd625fefaa50cff1a2b9559

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
