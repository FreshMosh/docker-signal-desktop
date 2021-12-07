FROM ubuntu:latest

ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="Europe/Berlin"

# RUN apt-get update && apt-get install -y \
#         gpg \
#         wget \
#     && wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg \
#     && cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null \
#     && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
#         sudo tee -a /etc/apt/sources.list.d/signal-xenial.list \
#     && apt-get update && apt-get install signal-desktop

RUN apt-get update && apt-get install -y \
        gpg \
        wget 


RUN wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg 
RUN cat signal-desktop-keyring.gpg | tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null 
RUN echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | tee -a /etc/apt/sources.list.d/signal-xenial.list 
RUN apt-get update && apt-get install -y signal-desktop
RUN chmod 4755 /opt/Signal/chrome-sandbox

RUN adduser --disabled-password --gecos '' signal
RUN mkdir -p /home/signal/.config/Signal/ \
    && chown -R signal:signal /home/signal/.config

USER signal

ENTRYPOINT ["signal-desktop"]



