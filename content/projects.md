+++
title = "Projects"
date = 2019-02-28
+++

In my lazy years I have worked on some random things mostly created out of fustration or to learn. Use anything here with extreme caution given its probably broken and shit. I cant say I am particularly proud of any of these but here they are:

#  *[HTML, CSS]* zizotto 🎨
A custom fork of a Hugo theme called [risotto](https://risotto.joeroe.io) by Joe Roe which I then adapted for use with [Zola](https://getzola.com) hence the name.
Very much still WIP but source is avaliable [here](https://github.com/xihn/zizotto)

# *[rust]* rblas 🔢
simple blas implementation for my own learning
https://github.com/flame/how-to-optimize-gemm/wiki#computing-four-elements-of-c-at-a-time
https://en.wikipedia.org/wiki/BLIS_(software)
https://en.wikipedia.org/wiki/Basic_Linear_Algebra_Subprograms

#  *[lua, C]* slurm-ratio 📊
Simple lua script for enforcing a slurm cpu/gpu ratio based on different gpus.
Has a C version that reads from a TOML file for use on our older clusters with older versions of slurm (17.11)

# *[rust]* rsched ⚖️
 A very experimental Rust based scheduler for use in HPC clusters

# *[docker]* slurm-testing-container 🐳
Simple slurm VM instance for testing plugins, slurm configurations and more.
Generated from an existing cluster's slurm.conf file to simluate nodes. Can simluate gres.

# *[markdown]* zero-to-hpc 📖
Documentation and guide based on my own experiences to help others understand, build, and use HPC.
Split into a user facing guide for people working with HPC and a more backend infrastructure guide for sysadmins.
https://theartofhpc.com/

# *[C++]* rvc 🔄
rhino 3dm version control loosely based on git.
Currently only has very basic functionality.

#  *[python]* git-osint 👁️

tracks git users and pulls their name and email from .patch data, estimates their geographic timezones by commit time. can be used to check a repository.
