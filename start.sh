#!/bin/bash

# Kill old VNC if exists
vncserver -kill :1 >/dev/null 2>&1 || true

# Start audio
pulseaudio --start || true

# Start VNC
vncserver :1 \
  -geometry ${VNC_RESOLUTION} \
  -depth ${VNC_COL_DEPTH}

# Start noVNC
websockify \
  --web=/usr/share/novnc/ \
  --heartbeat=30 \
  8080 localhost:5901
