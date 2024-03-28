+++
title= "Julia"
date= Date(2024,03,27)
+++

I have some thoughts on the future of the Julia language, as prompted by [Mason Yahr](https://twitter.com/yahrMason/status/1772445238730084642) on X. As many of you all know I'm kind of a fanboy, but I too have noticed kind of a slowdown.

So, here's a few thoughts on the good + the bad.

## The good

**Julia is beautiful.** I started writing Julia in maybe 2015 or so. Not sure the version exactly but I think it was at or before 0.5, when the language was very new. I fell in love with the language for a pretty superficial reason to start: it is beautiful. I consider myself proficient in many languages, and few are as beautiful to my eye as Julia is.

**Julia is a good language.** Once I was hooked on the beauty, I started to appreciate how good a language it is, and how much my brain *loves it*. Julia can be a functional language if you want. It can be strongly typed, but you can also mostly ignore the types as you go and let the compiler handle it. It's flexible when you want it to be and structured when you need it. It's fast, if you write it correctly, and it's full of so many fun little bells and whistles that I am still constantly learning beautiful new things about the language. [Multiple dispatch](https://docs.julialang.org/en/v1/manual/methods/), dispatching to functions based on the type of the inputs, is a really incredible tool that's a blast to use. Multiple dispatch is also why the language is composable, meaning that you can pretty easily borrow and mix things together across packages.

**Julia is state-of-the-art for scientific computing.** Julia was, and still mostly is, a scientific computing language. I was one of the rarer Julia users who was not a refugee from scientific computing elsewhere. Most of the users of Julia at that time (from what I remember) were scientists -- people who hated matlab and wanted out. Think academics. People who do numerical computing at massive scale and really need the speed. There's lots of folks who do climate/ocean/physics/etc. in Julia because they can sketch out a model super quickly and get code that is reasonably performant in a fraction of the dev time it would take to write it in C++ or Fortran or whatever.

**The package management is world-class.** Julia's Pkg.jl is based on Rust's `cargo`, and it is incredible. I do not worry about reproducible environments, installing packages, etc. It just happens without me thinking about it. No stupid `pip` nightmares, no managing nightmarish virtual environments, etc. It's just good shit.

**The numerical computing ecosystem is amazing.** The language is still very much like this. Julia's massive heavy-hitter is [SciML](https://sciml.ai), which is just a monster ecosystem built for hyper-performant differential equations, nonlinear systems, physics-informed neural nets, whatever. It's a crazy cool world and it's not clear to me that there's anything quite like it elsewhere in other languages. There's other large packages, like [Turing.jl](https://turinglang.org/stable/) for probabilistic programming, which is how I got started in large-scale engineering and open source work. If you want scientific computing or dope-ass mathy stuff, I think Julia is still a world-class language with a ton to offer.

**The GPU stuff is crazy.** Oh -- also, it's insanely easy to work with GPUs. Seriously. Go try it out if you want to do GPU stuff. It's a breeze. Most of the stuff you might want to do can be done by just wrapping arrays in GPU types, and it'll mostly handle the operations for you without you changing anything. Writing kernels is a little harder, as it always is, but there's lots of cool tools like [KernelAbstractions.jl](https://github.com/JuliaGPU/KernelAbstractions.jl) for working across GPU architectures.

It also supports a lot of the functionality you'd need for data work. [DataFrames.jl](https://dataframes.juliadata.org/stable/) is really incredible, and we have a lot of very good stuff for working with data sources: csvs, JSON, HDF5, Arrow, Parquet, etc. All of this stuff works pretty well and I no longer notice that I don't have access to some core component of my typical data workflow.

I actually use a lot of Julia for the backend of [Comind](https://www.comind.me), my side project. It's my server side and general compute workhorse for all kinds of generative AI stuff. We have an excellent package called [PromptingTools.jl](https://github.com/svilupp/PromptingTools.jl) that handles an absurd amount of standard generative AI processes you might want to do, and I have heavily integrated it into the Comind tech stack. Really really wonderful to work with, and the package creator Jan is a delight to talk to.

Overall I would say it's still very much a growing language. There are lots of wonderful people working on it and making amazing things, and I don't really see myself leaving the language any time soon.

## The bad

Okay, so I said a lot of nice things, but I'll give the critiques I have noticed.

**Deep learning is a bit behind**. The deep learning stuff tooling is behind and will take a lot of effort to catch up to the state-of-the-art. Pytorch/Tensorflow have an __absurd__ amount of resources behind them that [Flux.jl](https://fluxml.ai), our deep learning toolkit, can't quite compete with. Admittedly it is _really good_ for how much resources it does have, which is kind of a big endorsement of the contributers of Flux.jl and of the language it is built on. I would actually really love to spend some dev hours on it but ultimately I am very time constrained and have a job.

A few of us are working on drumming up support for Julia-native language model inference. This sort of exists but is scattered across the ecosystem, and hasn't had a big focused effort to consolidate everything into one spot. It'll take a bit of work but it's doable. Some have pointed out that it's maybe not even worth doing because Python is just going to eat everyone's lunch forever, but I choose to live in a world where we can make cool shit in a language we love.

A brief aside on the deep learning in Julia problem. One of the massive advantages of Julia is that everything is composable. If you write a package with a few types and functions and then use that package elsewhere, it's actually pretty damn easy to just link all the functionality of the packages together. I can imagine a world where this composability is going to be very useful in generative AI workflows, where you have many models stacked together. You might want to optimize one or more objective functions, in which case it would be awesome to have gradients that can propogate all the way through the models. In Julia this is easier than in most other languages (but not perfect), because the autodiff systems are usually at the language level and not statically compiled graphs as in JAX/Tensorflow.

**Fringe packages tend to bitrot quicker.** Because a lot of Julia users are academics, they write packages for some very specific purpose and then don't really maintain it. They have jobs and lives and a lot of these packages just don't get used that often. There's not really a lot of financial resources for developers who work in Julia, so most people tend to use Julia because they are trying to achieve a task but are not building something for a money-making entity like a corporation. 

In a lot of ways this is fine -- most of these packages fall a bit off the map because they are hyper-specialized to some field that studies some arcane manifold-discrete optimization-graph theory concoction that five people on Earth understand. These are awesome and we want these, but there's kind of a graveyard of little packages all over the place. 

The core packages are fine, and tend to have enough support to either maintain the course or grow steadily. This varies from place to place, but the big folks in the ecosystem that are run by academic labs, SciML, JuliaHub, etc. seem to be well cared for.

**The community is fractured.** A _huge_ mistake for the language was starting a Slack for the language. A lot of people have great conversations there, and, because paying for a persistent Slack room for the public would cost a bajillion dollars, all of those conversations disappear. There is no persistence of knowledge.

We tried to move everyone to Zulip, but of course many stayed in Slack, and now there's hardos and nerds in the Zulip. You can always find cool people there. Still, most of the regular community members are in the Slack, where open-source knowledge goes to die. There's also a Discord channel. Which, I dunno. I don't use it much but it's another place for knowledge to be splintered. We also have a Discourse forum, which I prefer, but the types of conversations people are willing to have there are not the most interesting.

All of this is a massive problem, especially now that we have all these language models that rely on having a large corpus of available text to train on. A lot of our question-answer code is locked away in a Slack history we'll never see, and that's made it harder for language models to help us write good Julia code.

**People have decided that Python is fine, and it kind of is.** Look. I hate Python. If you're reading this blog or know of me, you may know this about me. It's a bad language that's had an endless amount of shit piled on top of it. I don't like a lot of the language decisions, the package management, etc. Lots of points for me to get irrationally angry about.

However.

Python is approachable. And it is such a terrible language by itself, but it is an **incredible** glue language. Most of what people use Python for these days has very little to do with Python. It's all just calling out to code written in C++ or whatever, and slapping this easy-to-read syntax on top of it. This works really well for python, because you can have hardo-numeric-engineer types go write big crazy stuff and then have users who just want to push a button and make a neural net go.

Ultimately, this is what you want a lot of computing to be -- easy. If you are a user you don't want to think about the bajillion person-hours that went into making Pytorch work, because it is a miracle of modern computing. You want buttons and magic and Python gives you that. We can all just settle for Python and be fine with it. Lots of people love Python, it works for them, and it gives you access to the largest ecosystem of high-quality code in the history of computing.

Julia _can_ give you this, but it is harder. There's just not been the resources to make this kind of thing available. Python has been pulling ahead of basically everything for as long as I can remember. More use, more funds, more use, more funds, the loop continues. Julia, even though it _can_ do all the things that Python + good languages can do, it would take a lot of work to get there. It is very hard to compete with Python.

In some sense this is also due in part because Julia is a great numerical computing language, which is what people also tend to use Python for. People in Python often want quick shit hacked out, as Julia people also often want. Other languages like Rust are so incredibly different from Python in that they provide something Python simply can't. In the case of rust, this is an inordiately powerful compiler that can give you a lot of guarantees about how your program will run even before you run it. It's a fantastic systems language. Python has been used for a lot of systems programming but this is honestly not something I think Python will ever be good at -- use Rust instead.

Julia is closer to Python than it is to Rust, and so it might ultimately end up never really getting anywhere near Python.

**And that's fine with me.** 

I love Julia, and I'm going to keep working in it, and I'm going to enjoy it. Because it is _beautiful_ and challening and interesting. Because the people are all really lovely. Because I want to see what it can do! And maybe if I keep talking about it and showing people, maybe they'll love it as much as I do. I just think that'd be a really lovely thing to share with you all.

Anyways, thanks for reading. Email me your favorite Julia shit at [cameron@pfiffer.org](mailto:cameron@pfiffer.org).

Cameron