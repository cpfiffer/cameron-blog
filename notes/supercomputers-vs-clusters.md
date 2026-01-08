No, clusters _can_ work together but they typically are not tightly optimized for it. This is slowly changing but we are not there yet.

Large model training is probably closer to supercomputing than it is to GPU datacenters, likely because of gradient sync (if I had to guess). Inference is a "who gives a fuck" setup where you can send requests to one or a handful of racks.

So, depends on your use case. The OP talking about building giant computers is wise to use a smarter marketing plan by calling training systems supercomputers.

More on the distinction:

Supercomputers are typically distinguished by inter-node bandwidth and comms latency. Interconnects are what take supercomputers from a bunch of big nodes of the kind you might have in a datacenter to a monolithic computing system.

Supercomputers are designed for massive-scale inter-node compute workloads like simulations, where lots of compute/results have to be communicated across nodes. These workflows are usually synchronous.

Clusters/datacenters are embarassingly parallel most of the time, you don't really need them to talk to each other than much. You have many jobs that are largely homogeneous and can be done on either a single rack or a small handful of nodes.

Supercomputers are also often homogeneous -- their hardware is the same across nodes. This allows you to do an insane amount of optimization. Datacenters are plug and play, you buy whatever the fuck and plug it in.

[source](https://x.com/cameron_pfiffer/status/1978151837611253900)
