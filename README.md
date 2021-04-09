# ABOUT

Containerized Desktop Infrastructure (CDI) is an extremly light-weight desktop virtualization mechanisms. 
Make your VDI more fast, compact and suitable to more smaller systems and smaller teams.

You can also make containerized desktop environment, which is more tolerant to security violation than original Linux desktop.

# Build details

| Application name | Travis status | DockerHub |
| --- | --- | --- |
| Admin | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=admin-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Chromium | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=chromium-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Core | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=core-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Eclipse | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=eclipse-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Filezilla | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=filezilla-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Firefox | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=firefox-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Flatpak | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=flatpak-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Gimp | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=gimp-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Gitg | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=gitg-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Glade | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=glade-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Glusterfs-Server | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=glusterfs-server-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Gnome-builder | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=gnome-builder-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Gnote | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=gnote-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| GvncViewer | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=gvncviewer-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Inkscape | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=inkscape-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Libreoffice | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=libreoffice-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Openvswitch | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=openvswitch-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Paint | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=paint-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Qemu | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=qemu-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Sylpheed | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=sylpheed-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Thunderbird | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=thunderbird-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Tightvnc-Server | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=tightvnc-server-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| TrafficProxy | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=trafficproxy-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| TrafficWatcher | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=trafficwatcher-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Wayland | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=wayland-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Wireshark | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=wireshark-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 
| Xserver | [![Build Status](https://travis-ci.com/OpenCDI/cdi-docker-debian.svg?branch=xserver-dev)](https://travis-ci.com/OpenCDI/cdi-docker-debian) | - | 

# Dockerfiles

This is the [OpenCDI](https://github.com/opencdi/opencdi-scripts) application layers repository.
All application is simply fetched with apt, and present software assets on debian community can be seamlessly integrated to CDI with few modifications.
OpenCDI and its application layer Dockerfiles are fully opensource (MIT) and you are welcome to modify or fork them.

To get docker images, pull them from our [repository on DockerHub](https://hub.docker.com/u/coshapp).

```
docker pull coshapp/core:debian-10.9
```

