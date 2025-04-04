+++
title = "Slurm Job Submit Plugin (in lua)"
date = 2024-12-22
+++

At lbnl we have several existing slurm plugins; a few written in rust with rustbindgen mostly for spank, and a few fairly old C plugins. As we finally upgraded recently to a newer version, we can now write slurm job submit plugins in lua.

First came installing lua, and lua-devel and then running `./configure` to hopefully compile slurm with lua. Others have apparently had issues with this before[^1] however everything went smoothly for me.

Now to write the plugin. An example can be found [here](https://github.com/SchedMD/slurm/blob/master/contribs/lua/job_submit.lua). But essentially it should be in the following format:

```lua
function slurm_job_submit(job_desc, part_list, submit_uid)
	-- main logic
end

function slurm_job_modify(job_desc, job_rec, part_list, modify_uid)
	-- main logic
end
```
The docs state we have the following:
>**Arguments**:\
`job_desc` (input/output) the job allocation request specifications.\
`part_list` (input) List of pointer to partitions which this user is authorized to use.\
`submit_uid` (input) user ID initiating the request.\

>**Returns**:\
`slurm.SUCCESS` — Job submission accepted by plugin.\
`slurm.FAILURE` — Job submission rejected due to error (Deprecated in 19.05).\
`slurm.ERROR` — Job submission rejected due to error.\
`slurm.ESLURM_*` — Job submission rejected due to error as defined by _slurm/slurm_errno.h_ and _src/common/slurm_errno.c_.\

For my plugin I'll use  a few of the errors codes in [src/common/slurm_errno.c](https://github.com/SchedMD/slurm/blob/master/src/common/slurm_errno.c)  like `slurm.ESLURM_INVALID_GRES`. Unfortunately the docs give no information on logging so now we have to dig around in the source.

From [src/lua/slurm_lua.c](https://github.com/SchedMD/slurm/blob/master/src/lua/slurm_lua.c) it looks like we can use the following for logging:
-   `slurm.log(level, msg)`
-   `slurm.error(msg)`
-   `slurm.time_str2mins(string)`
-   `slurm.get_qos_priority(qos_name)`
-   `slurm.log_error(...)`
-   `slurm.log_info(...)`
-   `slurm.log_verbose(...)`
-   `slurm.log_debug(...)`
-   `slurm.log_debug2(...)`
-   `slurm.log_debug3(...)`

Although im not sure what I can use to log something the user, an old example from a blog[^1] I found used `slurm.log_user()` but I have no clue. I also have no clue what the different `log_debug*` are.

###  Testing

For this plugin the goal is to essentially enforce a CPU/GPU ratio. This is to keep users from running CPU only tasks on our GPU partition, and for accounting reasons. Ideally if a job is running on a node with say 4 cores and 4 GPUs then a user should not be allowed to request 4 cores and 1 GPU on the node since it then restricts the other 3 GPUs from being used. For a larger scenario with say 64 cores and 8 GPUs a user should only be allowed 8 or less cores per each GPU they request. A fairly simple arrangement, and also helpful since accounting is done per cpu core, per slurm QOS/partition (it should be calculated based on with gpu type as well but thats not up to me).

Writing it was fairly simple since lua is somewhat easy to write. The full plugin can be found [here](https://github.com/xihn/lua-slurm-ratio/blob/main/job_submit.lua).

While I writing I had a few testcases I ran through by replacing slurm return codes with print statements and everything seemed to be working. But after this came the real struggle of testing it on a cluster but without access to any test clusters.

The obvious sort of choice would be a local cluster on some vm or somesort of containerized cluster[^2]. However then I would run into problems since I the nodes dont have any GPUs and I cant test for different cpu/gpu counts. If only there were someway to simulate nodes with gpus and give them fake `gres`.

I tried setting up a docker cluster with nodes that had in their respective `gres.conf` a fake GPU name and added them to `slurm.conf` however this didn't work since `slurmd` wanted to see something in `dev/dri/*` with that name.

I guess I could pay for some cloud with actual gpu's however that woud be a waste of time and money since AI and crypto have made cloud gpus insanely expensive. And not to mention thats a bit absurd just to test a slurm plugin.

---

[^1]: https://funinit.wordpress.com/2018/06/07/how-to-use-job_submit_lua-with-slurm/
[^2]: https://github.com/giovtorres/slurm-docker-cluster
