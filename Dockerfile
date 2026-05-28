FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV VNC_RESOLUTION=1366x768
ENV VNC_COL_DEPTH=16
ENV LANG=en_US.UTF-8
ENV TZ=Asia/Singapore

RUN apt update && apt install -y \
    xfce4 xfce4-terminal xfce4-goodies \
    tigervnc-standalone-server \
    novnc websockify \
    firefox chromium-browser \
    pcmanfm \
    htop neofetch nano vim \
    git curl wget unzip \
    pulseaudio pavucontrol \
    dbus-x11 x11-xserver-utils \
    fonts-dejavu fonts-noto \
    && apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.vnc && \
    echo "railway" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

RUN echo '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec startxfce4 &' > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
