# ABOUT

Open Containerized Desktop Infrastructure (OpenCDI) is a light-weight desktop sandboxing mechanism for linux.
[OpenCDI](https://github.com/opencdi/opencdi-scripts) and [cosh](https://gist.github.com/46f9ec7807ccc56f80105eaec7965ac8) are controller implementations for OpenCDI and you can use them to launch CDI containers on linux servers or linux laptop machines.

# Supported platform (or requirement)

* Linux Kernel >= 4.17
* CGroups v2 (cgroups with unified hierarchy)
* podman or docker installation

# Dockerfiles

This is the [OpenCDI](https://github.com/opencdi/opencdi-scripts) application layers repository.
All application is simply fetched with apt, and present software assets on debian community can be seamlessly integrated to CDI with few modifications.

To get docker images, pull them from our [repository on DockerHub](https://hub.docker.com/u/coshapp).

```
docker pull coshapp/core:debian-11.0
```

Or you are using podman, add prepend hostname for the request: 

```
podman pull docker.io/coshapp/core:debian-11.0
```
