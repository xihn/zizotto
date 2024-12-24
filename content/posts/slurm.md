+++
title = "Slurm"
date = 2024-12-18
+++

## Testing Slurm Plugins


From my understanding there are sjob submit, job completion and whatever is inbetween as slurm plugins. We have several plugins on our cluster. l.. 

- compiled as .so when slurm itself is compiled.
- slurm compilation happens with ./compile
	- ./compile then runs make on a fat makefile, links together some other random shit

This sucks since recompiling slurm every time we want to modify plugins is a pain in the ass. for .. reasons list. Then asdf asdf asdf

There are several existing solutions. I found a python script taht has 
