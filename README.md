# LRSIM Docker build

This repository contains a Docker build of LRSIM:

> LRSIM
>
> https://github.com/aquaskyline/LRSIM
>
> Luo et al. LRSim: A Linked-Reads Simulator Generating Insights for Better Genome Partitioning. https://doi.org/10.1016/j.csbj.2017.10.002

`Dockerfile` builds an Ubuntu 16.04 image that compiles the LRSIM 1.0 release source code, available here:

> LRSIM 1.0
>
> https://github.com/aquaskyline/LRSIM/releases/tag/1.0

The compiled LRSIM directory is compressed and copied out of the container. `Dockerfile-precompiled` builds an Ubuntu 18.04 image and uses the compiled LRSIM, and runs the LRSIM test script.

To use this LRSIM build, either pull one of the Docker images and run LRSIM in a container:

```
docker pull olavurmortensen/lrsim:make  # Ubuntu 16.04 that compiles LRSIM.
OR
docker pull olavurmortensen/lrsim:precomp  # Ubuntu 18.04 with LRSIM compiled in lrsim:make.
```

Or download and decompress the compiled version:
```
git clone https://github.com/olavurmortensen/lrsim-docker.git
cd lrsim-docker
tar zxfv LRSIM-1.0-compiled.tar.gz
# Test that it works.
cd LRSIM/test
sh test.sh
```
