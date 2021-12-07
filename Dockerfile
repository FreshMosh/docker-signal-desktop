FROM ubuntu:latest

ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ="Europe/Berlin"

RUN apt-get update && apt-get install -y --no-install-recommends \
        gpg \
        wget \
    && wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg \
    && cat signal-desktop-keyring.gpg | tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null \
    && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | tee -a /etc/apt/sources.list.d/signal-xenial.list \
    && apt-get update && apt-get install -y --no-install-recommends \
        signal-desktop \
    && chmod 4755 /opt/Signal/chrome-sandbox \
    && adduser --disabled-password --gecos '' signal \
    && mkdir -p /home/signal/.config/Signal/ \ 
    && chown -R signal:signal /home/signal/.config \
    && rm -rf /var/lib/apt/lists/*

USER signal

ENTRYPOINT ["signal-desktop"]



