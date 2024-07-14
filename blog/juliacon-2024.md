+++
title="JuliaCon 2024 Retrospective"
date=Date(2024,7,14)
+++

# JuliaCon 2024

I spent the past week in Eindhoven, Netherlands for the annual Julia convention, JuliaCon. I wanted to write a retrospective of the conference (as I usually do) to share my perspectives on what's happening in the Julia world.

For those who do not know, Julia is a programming language used heavily in numerical and scientific computing, though I'll discuss a little later why I think Julia is broadening it's scope to truly general purpose & systems programming. 

Many of the users of Julia are highly educated, typically academic graduate students or professors. They typically use Julia as part of their research. People use Julia because it is the best way to perform cutting edge research in climate modeling, physical systems, differential equations, optimization, structural economics, and rapidly-prototyped ML. It is the home to world class software that makes it very easy to work on difficult computational problems that cannot easily be performed in other languages.

JuliaCon hosts talks, workshops, social events, and a hackathon each year in a different city. Developers who primarily interact with each other on our Discourse forum, Slack, or GitHub issues can finally meet and work through various technical issues quickly.

This one was my favorite. It's my third -- I've previously been to the one in Baltimore, MIT, and now Eindhoven. The atmosphere was warm, social, and positive. Everyone was absolutely lovely. I got to hang out with people I've communicated with for nearly six years but haven't really chatted with. We had drinks, karaoke, and worked together. Really a fantastic time.

More generally, the amazing thing about Julia is not technical (described below). It's not the autodiff, the speed, the JIT, the multiple dispatch, the quick development time, etc.

Julia's superpower is its community. 

I have been in many programming communities. Most are either loosely assembled like Python. Python is so large that having a cohesive community identity is impossible. R can be extraordinarily toxic but has delightful pockets, though typically these are only found in special interest groups like R Ladies or various academic fields like biostats. Rust has a relatively good community as well, and they spend a lot of time on it. I'm not as familiar with it. Perhaps [Miguel](https://miguelraz.github.io/) could comment more on this.

Julia has special interest groups, but the general language users themselves are quite tight-knit. There is a cohesive identity. Everyone works in different fields, but we're all delighted about everyone else's work because Julians typically love to learn. Many are academics or researchers, and the joy of learning is what typically draws people into these positions.

People will ask you about your field, what you work on, and often will quickly get into the weeds with you. Everyone's smart, curious, and thoughtful. Everyone's kind and usually quite social.

The community is also make serious moves towards diversity, equity, and inclusiveness (DEI). I had the opportunity to help out with the DEI dinner on Thursday night, where we hosted a panel discussion and break out groups on how to support mentorship and making Julia a safe and welcoming place to come and be yourself. We want to see everyone's beautiful brains glowing so we can learn about ice flows and metal grains and genetics and data formats.

Big thanks to Skylar, Kim, Xuan, Valentin, and the DEI folks for their hard work on running the DEI committee!

My overall sense of the conference was how amazing everyone is, and how much cool stuff is going on in the community. That was my big takeway from the past week -- the community is beautiful, and I think we can all make it a home for some of the brightest people on the planet.

We'll be rolling out a mentorship program and various other inclusiveness initiatives to help new folks get integrated in our (delightful) community, so stay tuned on that.

Special thanks to Airbnb roommates Julian Samaroo, Annika (last name unknown), and Jacob Zelko. Additional thanks to the DEI time for including me in the dinner, Guillame for hanging out and showing me Shrodinger's chess, Patrick Altmayer for continuing to be dope, Amanda Nicotina for being delightful to talk to, fellow Oregonian Lauren for lovely discussions about power systems, Frames White for some fantastic storytelling, Lilith Hafner for the sickeningly hilarious Python.jl, Chris Rackauckas for being the greatest karaoke hype man of all time, and everyone else I got to hang out/chat with/drink with. 

I've also been energized and want to try a few things:

- Intro-level educational videos about basic Julia and best practices. These would be on YouTube and resemble 30-60 minute lectures on different topics. I like doing education and I think it'd be fun to put them together when I have time.
- Videos where I sit down with Julia devs and have them walk me through their package or field of study. Kind of an armchair expert interview thing with a practical application.
- Starting a Julia Bay group meetup, probably monthly, with a possible goal of hosting a local JuliaCon or possibly JuliaCon Global in the Bay Area. Partly because they need organizers, and partly because I am lazy and don't like flying.

Anyway, here's some technical stuff that's cool too.

## Julia overview

Julia started as an MIT project (it is still housed there) and has since become quite an amazing tool. The tooling has broadened out away from the kind of stuff you might do in Matlab, Mathematica, or pure numpy. It's great at standard data science sutff, web services (Genie is an incredible service), easy and performant distributed compute (Dagger.jl), probabilistic programming, database interop, generative AI, etc. 

I have a reasonably functional backend for my pet social network/second brain/AI-powered knowledge graph [comind](https://blog.comind.me), It's written entirely in Julia and has been simple and quick to develop in. My sense thusfar is that the language and its ecosystem is pretty robust, and I rarely run into situations where the language is incapable of accomplishing some task. 

There are of course rough edges, as there are in any tool. One of the talks this year was about the lack of symmetric and asymmetric cryptography in Julia. There can be intermittent bugs. It doesn't support every external tool you might want -- for example, the neo4j drivers haven't been maintained in years. Anything that requires a company to support a language-specific API typically doesn't exist, so the community has to contribute it themselves.

That said, it still works, and it works well. And it works for a very specific type of system that I think most people do not fully appreciate. Julia's superpower is composability, which essentially means that a program can borrow from other packages either for free or with a small amount of elbow grease. Check out the talk "The unreasonable effectiveness of multiple dispatch" for an example.

What this means is that you can write programs that borrow from Julia's ecosystem without having to write terrible glue code, like you might in Python, R, or almost any other language. A PhD student's implementation of an obscure statistical method can be (usually) quickly applied by another programmer.

An even bigger application is that you can write entire programs rapidly that can be differentiated through using one of Julia's amazing automatic differentiation packages with some work -- doing this in any other language is a collosal task, whereas in Julia it can be on the order of a few minutes to a few days, depending on the size of your program.

I watched a lot of talks when I had the opportunity, but unfortunately wasn't able to take too much time off from my day job. The research has to be done, so I was intermittently in and out of talks.

### Dagger.jl and distributed computing

The stand out for me this year was from the distributed processing framework [Dagger.jl](https://github.com/JuliaParallel/Dagger.jl). Dagger is an amazing tool that handles constructing computational DAGs of an arbitrary program and will dispatch tasks to available resources, whether that be threads, processes, different machines, or GPUs. 

I watched the workshop hosted by Julian Samaroo and Przemysław Szufel, and my sense was that it has come leaps and bounds since I last used the project a few years ago. It's ergonomically very simple, and not dissimilar from the existing tasks framework that Julians may be familiar with.

Dagger's ergonomic interface is striking. If you have not used Julia before, you should know that parallelism is among the easiest in Julia among the many languages I have worked with. In some cases it is sufficient to use `Threads.@threads` in front of a for loop, and in others you may only need a lock and some minor adjustments for threads safety. Distributed processing across Julia processes is also quite easy. GPUs are easy to work with as well, and kernels can be written for arbitrary backends using KernelAbstractions.jl.

Dagger's scheduler is really interesting. If you've ever worked in multiprocess parallelism, you know that this means that memory is not shared across the processes in the same way that multithreading is. Moving memory across processes is costly, so it's advantageous to not do so unless you have to.

Dagger has an interesting feature where it is aware of memory transfer costs and will intelligently move data between processes only when it is efficient to do so. I was pretty blown away by how easy it is to work with this stuff.

Arrays can be easily sharded across resources for distributed compute. Imagine working with massive tables across many machines, each of which is responsible for a sub-block of the matrix. It was easy to work with these.

There's also lots of work going into reducing scheduling overhead, performance, and an extremely cool functionality that resembles a much more ergonomic version of MPI that can help Dagger understand which resources are read-only and which are write-only. You can wait on syncronization points. The feature is still in development but I'm interested in following along.

Overall, I think it's a magnificent project. Julia and the Dagger team are really incredible engineers. They are looking for contributors for a lot of the features that need to be implemented, so please reach out to me (cameron@pfiffer.org) if you would like me to point you to a point of contact. You can also reach out on the Julia Slack.

### AI

Julia's AI tooling is coming along pretty well, primarily driven by [Jan Siml](https://siml.earth/). He is inhumanly productive. The main package is [PromptingTools.jl](https://github.com/svilupp/PromptingTools.jl), which supports calling arbitrary LLM services like Groq, Anthropic, Ollama, and many others. It also supports reranking, monte carlo tree search over conversational paths, and RAG.

Julia's trustworthy AI stuff is coming along quite well, thanks to [Patrick Altmayer's](https://www.patalt.org/) work in the Taija.jl ecosystem. Patrick presented several talks, including on intent classification, countefactuals, and conformal prediction.

The Dagger.jl team also built a distributed processing framework to handle distributed training of a Llama 2 model that uses a single-program multiple data framework to ingest partial gradients across machines. The cool part of this is that you can add an arbitrary number of machines and Dagger will partition tasks across compute nodes. Gradients from each machine are then pulled back at each step to update the weights.

The performance of the training was relatively weak, partly because Julia is lacking a good implementation of GPU-accelerate transformer models. Most language model people work in pytorch, so development on the Julia side is relatively slow. 

If you would like to build language models in Julia, come hang out! We'll teach you how to write code, and we'd all be very grateful to have performant implementations of LLMs to showcase Julia's strength in distributed processesing, easy development times, and simplicity. I would also love to have Mamba/S4 implementations for the interested.

Overall I'm really pleased with how far the gen AI stack has come. I use it exclusively in comind and I haven't really had any issues. It's super easy to use.

### Static compilation

Since Julia's time-to-first-plot problem has been reduced substantially (well done to the core devs), people have turned to the next feature that is relatively complicated to implement: static compilation.

Julia is a dynamic language, which means that the code is only compiled when needed. If you pass an integer to a function, that function is compiled to use integers. If you pass a string to that same function, it compiles for strings. 

This is great because you can basically do whatever you want with any type, but it has consequences when you want to construct Julia binaries that do not require the runtime. Static compilation requires that you know all possible types that could be applied, which is an extremely hard problem.

The interest in static compilation is rising because people want to be able to quickly develop in Julia and execute ahead of time compiled instructions on embedded software, deployed systems (like in ASML's photolithography machines), or even just to avoid recompilation of static methods.

The juliac compiler is coming along, and I think the general sense is that a limited version of Julia that restricts to certain types can be implemented. Hello world for example is compilable, and I think there are some more nontrivial test cases that I don't follow too closely.

Lots of people are interested in static binaries, like Boeing and ASML. I don't care as much. I personally don't mind if code is in a binary or Julia's runtime -- it's all the same to me, and Julia is easy to deploy on any machine. However, it is a thing that many have asked for, so it's worth noting that there is significant development in static compilation of binaries.

### Stats

Go look at [Kezdi.jl](https://github.com/codedthinking/Kezdi.jl) if you are in the unfortunate position of using Stata. It's good.

### Web stuff

A few of the good talks I saw were about web topics, such as running production systems, building data-forward websites with Genie, or enhancing Julia's web performance.

The one that stood out to me was how to improve Julia's primary server package HTTP.jl. HTTP.jl has struggled in the past few years with performance, and it's caused my personal project comind some issues for my websocket servers.

The talk essentially highlighted that you can make it much more performance by turning off SSL and using nginx as your reverse proxy, which is standard practice in the web world. Huge speedups there, which I appreciate.

They also highlighted a primary issue with HTTP.jl, which is that it does a C foreign call every time it does I/O. This is a problem because Julia essentially shuts down the thread scheduler (and other things) while waiting on the C call to return. The speaker said the words "this is a disaster" several times.

I'm not sure what the fix is here, though. There are a few workarounds to increase performance, but I'd be super interested in seeing what the "greenfield" version of an HTTP interface looks like in Julia.

[Genie](https://genieframework.com/) was a sponsor as well, and it's worth taking a look if you have not. Genie is a sponsor of Julia and provides an entire web stack including databse interconnects, a Vue-based front end, and a drag-and-drop website builder for serving your website using standard Julia code. It's cool. Go look.

### Math

Julia's general computational math work has also been cool. 

Guillame's work in [DifferentiationInterfaces.jl](https://github.com/gdalle/DifferentiationInterface.jl) has been great. AD in Julia is kind of a super power, but it's been struggling to have a common, simple inteface for getting gradients. I haven't played with it too much, but Guillame has successfully (and kindly) berated me into switching to it.

Julia's [GraphBLAS.jl](https://github.com/JuliaSparse/SuiteSparseGraphBLAS.jl) package has been coming along nicely as well. It's an implementation of high-performance algorithms for working with sparse matrices. I still need to tinker with it but it is actively developed.

### Misc

There were a lot of talks I couldn't get to, but I'm aware of active development in 

- Bundling packages into apps
- AD improvements
- Various modeling in specific technical fields, like ice flows
- Compiler plugins where you can mess with the emitted LLVM
- Cursed-ass Python.jl. Julia is a Python superset now, so you have no excuse.
Conclusion

I'll leave it there for now with some closing comments. I came away from JuliaCon with some warm fuzzies. The people are stellar, the code is good, and the future is bright.

We'll be rolling out a mentorship program soon so keep an eye out. Come on down, the water's warm.
