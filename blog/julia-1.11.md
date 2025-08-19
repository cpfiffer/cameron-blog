+++
title= "Cool Julia 1.11 features"
date= "2024-03-25"
rss = "A look at exciting new features in Julia 1.11, including the Memory type for faster arrays, Lockable for thread-safe resources, and other performance improvements."
rss_pubdate = Date(2024,03,25)
toc= true
+++

There's some cool Julia features in the [NEWS files](https://github.com/JuliaLang/julia/blob/v1.11.0-alpha2/NEWS.md) I thought I'd highlight. Very brief stuff but good to note.

## The `Memory` type for arrays

You can read more about the design of this feature [here](https://hackmd.io/NnLXBeoyRymWgPtHYlW7-A?view#New-Builtin-functions). It's a really good design doc and I'd recommend taking a look. I've summarized it here, but please check it out for a much more thoughtful treatment. Thanks to [Oscar Smith](https://github.com/oscardssmith) for the work. 

Array types are powerful + general, but have a few shortcomings:

- They use a lot of C, which means the Julia/LLVM compiler can't work magic
- There's lots of overhead (also due to C calls)
- `push!` is slow
- No element-wise atomic operations

The `Memory` type is out, which is a low-level type that is intended to address some of this stuff. Some performance improvements:

- Array appends (`push!`) are about 2.2x faster
- Empty array gen is 3x faster (`Int[]`)
- 80% faster for empty `Memory` implementers `Dict{Int,Int}`

The system image is a little larger.


## `Lockable` for carrying locks with resources

A common pattern when working with multithreaded code is to use a lock to [protect a value](https://docs.julialang.org/en/v1/manual/multi-threading/#Data-race-freedom) from multiple threads accessing it at the same time. For example, you might do something like

```julia
x = [1,2,3]
lck = Threads.SpinLock()

Threads.@threads for i in 1:100
    position = i % 3 + 1
    lock(lck) do
        x[position] += 1
    end
end
```

The above code is safe because the `lock` function ensures that only one thread can access the `x` array at a time -- no data races.

`Lockable` is a super convenient feature where you can attach a lock to a resource, so you don't have to worry about managing the lock yourself. Here's an example:

```julia
z = Lockable([1,2,3], Threads.SpinLock())
Threads.@threads for i in 1:100
    position = i % 3 + 1
    lock(z) do x
        x[position] += 1
    end
end
```

Notice that now we're just using `lock` on the raw resource `z` and the lock is managed for us. This is a nice feature because it makes the code cleaner and easier to read.

## The `public` keyword

The `public` keyword is applied to symbols that are considered part of the public API of a module, but are not exported when you call `using`. This is part of the wider discussion in the Julia community that exporting everything is not always the best idea -- there's been a lot of clutter and such with people being trigger-happy about `export`s. Thanks to [Lilith Hafner](https://github.com/LilithHafner) for the work.

As an example, you might have a module like

```julia
module MyModule

export foo, bar

foo() = println("foo")
bar() = println("bar")
baz() = println("baz") # not exported, have to use MyModule.baz()

end # module
```

when you `using MyModule`, you get `foo` and `bar` directly accessible:

```julia
julia> using MyModule

julia> foo()
foo

julia> bar()
bar

julia> MyModule.baz()
```

Now, you'll be able to use public functions like `foo` and `bar` without having to `export` them. This is a nice feature because it allows you to keep your module clean and not export everything.

```julia
module MyModule

public foo
export bar

foo() = println("foo")
bar() = println("bar")
baz() = println("baz") # not exported, have to use MyModule.baz()

end # module
```

Now you'd have the following behavior:

```julia
julia> using MyModule

julia> MyModule.foo() # have to use MyModule.foo() because it's not exported
foo

julia> bar() # can use bar() directly, as it is exported
bar

julia> MyModule.baz() # no change
baz
```

I'm curious to see how the community will use this stuff. I'm not sure it's immediately obvious to me how I'll use it, but it seems like standard engineering practice.  

## The `:greedy` thread scheduler

You can now use a greedy thread scheduler, which greedily works on iterator elements as they are produced. Greedy threads simply take the next available task in an iterator without regard to how hard the task is, how many threads there are, etc. If you have a lot of tasks that are all about the same difficulty, greedy scheduling can be a good choice. 

```julia
Threads.@threads :greedy for i in 1:100
    println(i)
end
```

Julia has the other scheduling options `:dynamic` and `:static`, which are more sophisticated and can be more efficient in some cases. `:static` will partition the iterator into chunks and assign each chunk to a thread, while `:dynamic` will dynamically allocate small chunks to threads. `:dynamic` is the default scheduler, but I suspect `:greedy` will be useful in some repeated, small multithreading tasks.

The [PR](https://github.com/JuliaLang/julia/pull/52096) is here. Thanks to [Valentin Bogad/Sukera](https://seelengrab.github.io/about/).