FROM debian:11

RUN apt-get update && \
    apt-get install -y mosquitto-clients jq ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY dockerscripts/ /
COPY dockerbinary/ /
RUN chmod +x /entrypoint.sh && chmod +x /cmd.sh && chmod +x /bodycomposition

ENTRYPOINT ["/entrypoint.sh"]
