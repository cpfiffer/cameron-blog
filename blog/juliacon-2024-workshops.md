+++
title="JuliaCon 2024 Workshops"
date=Date(2024,7,9)
+++

# JuliaCon 2024

It's workshop day!

## Parallel processing with Dagger.jl

[Dagger.jl](https://github.com/JuliaParallel/Dagger.jl) is an extremely cool tool. I used Dagger sometime in 2018 I think, but I didn't really have a good distributed computing problem to solve. 

Julian Samaroo and Przemysław Szufel presented the workshop. Here's the [workshop materials](https://github.com/jpsamaroo/DaggerWorkshop2024).

My takeaway was this: Dagger is _fucking crazy_. Essentially, it unifies a bunch of forms of parallel computation: multithread, multiprocess, and GPU. You provide Dagger a collection of resources (such as threads, worker processes, or GPUs) and it handles the scheduling of tasks on those resources. 

Dagger will pretty much auto-magically figure out things like memory movement between processes -- for cheap tasks, you want to keep data within-process to minimize memory movement, but in some cases a worker may be overloaded and it may be cheaper to move memory to a different worker.

The simple version of Dagger resembles Julia's [standard task workflow](https://docs.julialang.org/en/v1/base/parallel/):

```julia
t = Dagger.@spawn 1+2
@show t
fetch(t)
```

`t` here is a `DTask`, which represents a task that will execute on some parallel resource. `fetch(t)` will block and return the result of the task.

Dagger will also construct a DAG (hence the name DAGger) of your computation -- you can construct an arbitrary set of tasks, and each task will be handed off to another process upon completion. Take this for example:

```julia
# Multiple dependencies and parallelism
x = rand(5000)
a = Dagger.@spawn x .+ 1
b = Dagger.@spawn a .* 2
c = Dagger.@spawn a ./ 2 # b and c are independent and be run parallel
d = Dagger.@spawn b .- c
fetch(d)
```

Above, `b` and `c` are independent and can be run in parallel. `d` depends on both `b` and `c`, so it will block until both are complete.

GPU support is quite straightforward as well. Julia's GPU support is wonderful, and you can use any device type you need (CUDA, ROCm, Metal, oneAPI).

Here's how to set up a GPU in Dagger:

```julia
using DaggerGPU
using CUDA

# Annoying, but we need to restart the scheduler for the below changes to take effect...
# Will be fixed in future versions of Dagger!
Dagger.cancel!(;halt_sch=true)

# Make sure that we have at least one GPU
@assert length(CUDA.devices()) > 0 "You don't have any NVIDIA GPUs!"

# Pick the first available GPU
GPUArray = CuArray
scope = Dagger.scope(;cuda_gpu=1)
```

Once you have the `scope` that determines Dagger's available resources (in this case, a GPU), you can let Dagger handle whatever your operation is:

```julia
# Run our `sum` function on the GPU!
A = rand(Float32, 1024)
Dagger.with_options(;scope) do
    @show fetch(Dagger.@spawn sum(A))
end
```

This also handles multiple GPUs across processes. If the GPUs are full or computations are not appropriate for a GPU, they can also be dispatched to a multithreading paradigm.

There's lots of other cool stuff in the talk, including data dependencies to help the Dagger scheduler, distributed arrays, and a nifty implementation of convolutions + Conway's Game of Life.

Honestly I was just amazed at how far Dagger.jl has come. They have a ton of stuff on the roadmap as well, including 

- DaggerGraphs.jl for partitioned distributed graph processing
- Streaming data
- Auto-GPU processing
- Expanded data deps support
- Operator fusion
- Dagger + Enzyme autodiff
