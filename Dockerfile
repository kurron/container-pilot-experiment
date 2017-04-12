FROM azul/zulu-openjdk:8u121

MAINTAINER Ron Kurr "kurr@jvmguy.com"

# Copy Container Pilot life-cycle scripts
COPY pilot-scripts /usr/local/bin

# Copy Container Pilot configuration
COPY containerpilot.json /etc/containerpilot.json

# Container Pilot needs to know where the configuration file lives
ENV CONTAINERPILOT=file:///etc/containerpilot.json

# Install Tools
RUN apt-get --quiet update && \
    apt-get --quiet --yes install curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get ContainerPilot release
ENV CONTAINERPILOT_VERSION 2.7.2
RUN export CP_SHA1=e886899467ced6d7c76027d58c7f7554c2fb2bcc \
    && curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
    && rm /tmp/containerpilot.tar.gz

# Install application
EXPOSE 8080
ENTRYPOINT ["/bin/containerpilot", \
            "java", \
            "-XX:MaxRAM=128m", \
            "-XX:+UseSerialGC", \
            "-XX:MinHeapFreeRatio=20", \
            "-XX:MaxHeapFreeRatio=40", \
            "-XX:GCTimeRatio=4", \
            "-XX:AdaptiveSizePolicyWeight=90", \
            "-jar", \
            "/opt/echo.jar"]
COPY build/libs/echo-0.0.0.RELEASE.jar /opt/echo.jar
