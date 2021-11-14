# ABOUT

Open Containerized Desktop Infrastructure (OpenCDI) is a light-weight desktop sandboxing mechanism for Linux.
[OpenCDI](https://github.com/opencdi/opencdi-scripts) and [cosh](https://gist.github.com/46f9ec7807ccc56f80105eaec7965ac8) are controller implementations for OpenCDI and you can use them to launch CDI containers on Linux servers or Linux laptop machines.

# Supported platform (or requirement)

* Linux Kernel >= 4.17
* CGroups v2 (cgroups with unified hierarchy)
* podman or docker with fairly recent version of them.

# Dockerfiles

This is the [OpenCDI](https://github.com/opencdi/opencdi-scripts) application layers repository.
All application is simply fetched with apt, and present software assets on debian community can be seamlessly integrated to CDI with few modifications.

To get docker images, pull them from our [repository on DockerHub](https://hub.docker.com/u/coshapp).

```
docker pull coshapp/core:debian-11.1
```

Or you are using podman, add prepend hostname for the request: 

```
podman pull docker.io/coshapp/core:debian-11.1
```

# Build

`ci_functions.sh` can be used to build your own images. First, you must build core image and you can choose images you want to build (or build all).

```
. ci_functions.sh
build_core
build_image Debian-Base/Firefox_bullseye*
#or build_all to build all images in the repository
```

If you would like to use podman for the build, specify environmental variable `DOCKERIAN=podman` before a build.

# Private container registries

`ci_functions.sh` can be used to make images for private registries. 
You can build images for private registries to specify REGISTRY_NAME environmental variable before you run `build_image` or `build_all`.
You also can set it for `make`.

At now, private registry support is only tested on [Docker registry](https://docs.docker.com/registry/). 

## Private registry tutorial

To build temporary registry, run following commands on docker host (here we assumes it has 192.168.0.12/24 as its IP):

```
docker run -dt --name registry-test-1 -p 192.168.0.12:5000:5000
```

This registry serves any requests over **unencrypted connection**. In general, TLS configuration is recommended but this temporary evaluation does not need additional registry configuration. On the other hand, you must reconfigure your dockerd which pushes or pulls in new images (here we call it `edge dockerd`).

An edge dockerd cannot pushes or pull images over unencrypted connection by default.
So you must pass dockerd `insecure-registries` option. Add /etc/docker/daemon.json by following description:

```
{
  "insecure-registries": ["192.168.0.12:5000"]
}
```

Now you can restart dockerd (systemctl resetart docker), and you can push or pull docker images for the registry:

```
docker push 192.168.0.12:5000/example-image
```

podman also works well as a client for docker registry. 

**Attention**: This registry has no authorization mechanisms. Never use it in production environment.

# Contributing

See [this](CONTRIBUTING.md).
