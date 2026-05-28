#!/bin/bash

vncserver -kill :1 >/dev/null 2>&1 || true

pulseaudio --start || true

vncserver :1 \
  -geometry ${VNC_RESOLUTION} \
  -depth ${VNC_COL_DEPTH}

websockify \
  --web=/usr/share/novnc/ \
  --heartbeat=30 \
  8080 localhost:5901
