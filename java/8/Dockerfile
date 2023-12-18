FROM --platform=$TARGETOS/$TARGETARCH eclipse-temurin:8u312-b07-jdk-focal

RUN apt-get update -y \
    && apt-get install -y file unzip lsof curl ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
    && useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
