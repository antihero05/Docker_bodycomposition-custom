FROM python:3.10-slim

WORKDIR /opt/bodycomposition
COPY src /opt/bodycomposition

RUN mkdir -p /opt/bodycomposition/tokens
ENV GARMINTOKENSTORE /opt/bodycomposition/tokens

RUN apt-get update && \
    apt-get install -y mosquitto-clients jq ca-certificates python3-pip libxml2-dev libxslt-dev rustc cargo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --upgrade garminconnect

COPY dockerscripts/ /
RUN chmod +x /entrypoint.sh && chmod +x /cmd.sh

ENTRYPOINT ["/entrypoint.sh"]
