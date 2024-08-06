# Stage 1: Build
FROM debian:12.6-slim AS builder

# Install necessary packages and tools for building
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    lsb-release \
    gnupg \
    ca-certificates \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz \
    && tar -zxvf openshift-client-linux.tar.gz

# Stage 2: Final image
FROM debian:12.6-slim

# Copy binaries from the builder stage
COPY --from=builder /usr/local/bin/az /usr/local/bin/az
COPY --from=builder oc /usr/local/bin/oc
COPY --from=builder kubectl /usr/local/bin/kubectl

# Set the default command to bash
CMD ["/bin/bash"]