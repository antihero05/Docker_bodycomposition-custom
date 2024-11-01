FROM python:3.10-slim

WORKDIR /opt/bodycomposition
COPY src /opt/bodycomposition

RUN mkdir -p /opt/bodycomposition/tokens
ENV GARMINTOKENS /opt/bodycomposition/tokens

RUN apt-get update && \
    apt-get install -y mosquitto-clients jq ca-certificates python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade garminconnect

COPY dockerscripts/ /
RUN chmod +x /entrypoint.sh && chmod +x /cmd.sh

ENTRYPOINT ["/entrypoint.sh"]