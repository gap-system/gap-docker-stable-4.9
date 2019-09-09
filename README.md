# Docker container for GAP development version (stable-4.9 branch)

DockerHub entry: https://registry.hub.docker.com/u/gapsystem/gap-docker-stable-4.9/

This container provides the core GAP system build from the stable-4.9 branch
of the [GAP repository](https://github.com/gap-system) and GAP packages
prepared for the next release of GAP made from that branch.

If you have installed [Docker](https://www.docker.com/), to use this
container first you need to download it using

    docker pull gapsystem/gap-docker-stable-4.9

(the same command is needed if you need to update the GAP container to get a
new GAP release). After that, you can start it as follows:

    docker run --rm -i -t gapsystem/gap-docker-stable-4.9

Note that you may have to run `docker` with `sudo`, particularly if you are
on Ubuntu.

The location of GAP in the container is `/home/gap/inst/gap-stable-4.9`.

For more details (e.g. on how to access GAP running in this Docker container from a
Jupyter notebook in your browser) see the readme of https://github.com/gap-system/gap-docker
and simply replace `gap-docker` by `gap-docker-stable-4.9`.
