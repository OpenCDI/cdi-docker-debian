# For contributors

Thanks for your attention for the OpenCDI community. You are welcomed to add new changes to this repository. 


# Adding new dockerfile for a GUI application

1. check whether the GUI application has OSI-compliant Opensource license.

`cdi-docker-debian` is automated to submit built artifacts to DocerHub. You cannot include proprietery application via this repositry. Plan to build your own image.

You are also welcomed to build your own images on the top of coshapp image.

2. check whether the GUI application is included in Debian official apt repository.

If an application has prebuilt apt package in official channel, please install it via `apt-get` and don't try to build it with any build script or within a builder image. This is the common strategy to build coshapp images, at now.

3. FROM and ARG context

Any coshapp application images are based on `coshapp/core` image. For GTK+-based apps, please import `FROM coshapp/core` at first, and don't forget to add `ARG COSHAPP_BASE_VERSION` and `ARG REGISTRY_NAME` for the CI script.

For Qt-based apps, we are working for KDE based image. Join to our [discussion](https://github.com/OpenCDI/cdi-docker-debian/issues).

# CI

make PR, thanks.
