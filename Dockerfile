FROM alpine:3.18

RUN apk add --no-cache \
    bash \
    curl \
    tar \
    ca-certificates \
    openssl \
    libc6-compat \
    jq

RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev openssl-dev && \
    curl -L https://github.com/Azure/azure-cli/releases/download/azure-cli-2.49.0/azure-cli_2.49.0-1_all.apk -o azure-cli.apk && \
    apk add --no-cache azure-cli.apk && \
    rm -f azure-cli.apk && \
    apk del .build-deps

RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz && \
    tar -zxvf openshift-client-linux.tar.gz && \
    mv oc kubectl /usr/local/bin/ && \
    rm -f openshift-client-linux.tar.gz

CMD ["/bin/bash"]