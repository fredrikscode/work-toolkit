FROM alpine:3.18

RUN apk add --no-cache \
    bash \
    curl \
    gnupg \
    tar \
    ca-certificates \
    libc6-compat \
    openssl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz && \
    tar -zxvf openshift-client-linux.tar.gz && \
    mv oc kubectl /usr/local/bin/ && \
    rm -f openshift-client-linux.tar.gz

CMD ["/bin/bash"]