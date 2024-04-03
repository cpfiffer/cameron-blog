+++
title= "Nothingness in Julia"
date= Date(2024,04,03)
+++

If you ever work in Julia, something you'll notice is that lots of people and the language server will recommend that you use `isnothing(x)` or `x === nothing` instead of the value comparison `x == nothing`. This is also true of the `ismissing` functionality for missing values.

Good discussion [here](https://discourse.julialang.org/t/x-nothing-vs-x-isa-nothing/64546/13), and a great Stack Overflow answer [here](https://stackoverflow.com/a/38638838/6149469).

How meaningful is this, though? I decided to do some benchmarking to see how much of a difference this makes.

The TLDR is that `x == nothing` isn't specialized to checking `nothing`, whereas `isnothing` and `x === nothing` are. `x === nothing` is a core language feature (I believe) and `isnothing` is compile time dispatched and is thus relatively quick. `x == nothing` is a value comparison and I think requires some extra stuff to happen on top.

There's a speed component to this too -- `isnothing` is the fastest on my machine, `x === nothing` is the second fastest, and `x == nothing` is the slowest.

`isnothing`:
```julia
julia> @benchmark isnothing(x)
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  1.539 ns … 24.880 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.579 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.589 ns ±  0.269 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

   ▁▃▁          ██
  ▃███▄▃▂▂▂▂▂▂▂███▇▆▃▂▂▂▂▁▁▂▃▅▅▃▃▂▂▂▂▂▁▁▁▂▂▂▂▂▂▂▂▁▁▁▁▁▂▂▂▂▂▂ ▃
  1.54 ns        Histogram: frequency by time         1.7 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```

`x === nothing`:

```julia
julia> @benchmark x === nothing
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  1.755 ns … 5.381 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.772 ns             ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.791 ns ± 0.102 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

             █▃▄▃▁
  ▂▂▂▂▂▂▃▃▄▆▇██████▆▅▄▃▂▂▁▂▂▂▂▂▂▂▁▁▁▁▁▁▂▂▂▂▂▂▃▃▇▅▆▇▇▇▆▆▄▄▃▃ ▃
  1.76 ns        Histogram: frequency by time       1.82 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```

The bad one, `x == nothing`:

```julia
julia> @benchmark x == nothing
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  2.419 ns … 10.722 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     2.681 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   2.693 ns ±  0.235 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

    █       ▂          ▁▁      ▅▄    ▁
  ▂▄█▂▁▅▄▃▁▆██▂▁▅▇▅▁▂▄▅██▂▅▆▂▁▅██▂▁▂██▃▂▂▂▂▂▂▂▂▁▁▂▄▃▁▁▁▂▃▂▁▁ ▃
  2.42 ns        Histogram: frequency by time        3.11 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```

This is usually why the language server will recommend that you use `isnothing` or `x === nothing` instead.

## Missing values

The same is generally true of missing values. Missing values [differ from `nothing`](https://docs.julialang.org/en/v1/manual/faq/#faq-nothing) in that they are used to represent missing data -- `nothing` is returned by default when a return value is not otherwise specified. `missing` is more for
cases where you don't know a value, e.g. if you don't have data for an observation in a statistical model.

Interestingly, on Julia 1.10.2, the fastest is not one of the strict comparisons `x === missing` or `ismissing(x)`, but a raw comparison using `==`. Not really sure what's up with that, but whatever.

```julia
julia> @benchmark x == missing
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  0.883 ns … 7.668 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     0.890 ns             ┊ GC (median):    0.00%
 Time  (mean ± σ):   0.896 ns ± 0.107 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

         ▁ ▇ ██ ▅ ▂
  ▂▂▁▄▁▆▁█▁█▁██▁█▁█▁▇▁▆▁▅▄▁▄▁▃▁▃▁▃▁▃▃▁▃▁▃▁▂▁▂▁▂▂▁▂▁▂▁▂▁▂▁▂▂ ▃
  0.883 ns       Histogram: frequency by time      0.914 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```

```julia
julia> @benchmark ismissing(x)
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  1.757 ns … 5.822 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.776 ns             ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.783 ns ± 0.088 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

           ▁▁▂█    ▂█▁▁▁▁
  ▂▂▂▂▂▃▆▆▇████▇▆▅███████▅▂▂▂▂▂▂▂▂▂▂▁▂▂▂▂▂▂▂▂▃▃▃▃▃▃▂▃▃▃▃▃▃▃ ▃
  1.76 ns        Histogram: frequency by time       1.82 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```

```julia
julia> @benchmark x === missing
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  1.540 ns … 4.822 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.554 ns             ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.561 ns ± 0.081 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

           ▂▃▄▅▇▇█▇▅▄ ▃
  ▂▂▂▃▄▅▅▇███████████▁█▇▅▃▃▂▂▂▂▂▁▁▁▁▁▁▁▁▁▂▂▂▂▂▃▂▃▃▃▃▃▃▃▃▃▃▃ ▄
  1.54 ns        Histogram: frequency by time       1.59 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```

