FROM debian:12.6-slim AS builder

RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    lsb-release \
    gnupg \
    ca-certificates \
    libssl3

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz && \
    tar -zxvf openshift-client-linux.tar.gz && \
    mv oc kubectl /usr/local/bin/ && \
    rm -f openshift-client-linux.tar.gz

FROM debian:12.6-slim

RUN apt-get update && apt-get install -y \
    libssl3

COPY --from=builder /usr/bin/az /usr/bin/az
COPY --from=builder /usr/local/bin/oc /usr/local/bin/oc
COPY --from=builder /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=builder /opt/az /opt/az

COPY motd /etc/motd
RUN echo "cat /etc/motd" >> /etc/bash.bashrc

CMD ["/bin/bash"]
