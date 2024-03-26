+++
title= "JuliaCon 2023"
date= Date(2023,08,03)
+++

This past week, I had the privilege of visiting MIT for [JuliaCon](https://juliacon.org/2023/). JuliaCon is the annual convention for [Julia users and developers](https://julialang.org). It was one of the better weeks in recent memory. I feel energized! I want to build things! I want to keep talking with all the cool Julia people who I knew before I arrived, and keep in touch with all the cool _new_ Julia people I met this week.

The reason I thought I should write it up is that I want to explore precisely why I am so pro-Julia, and why I think the community is truly something incredible. I didn't anticipate becoming a "Julia evangelist" but I ended up as one. Most people who know me from Twitter (I refuse to say X for the moment) are aware of my zealous Julia tweets or perhaps my disdain of Python. In person, lots of people say stuff like "I used R today, I'm sorry about that -- I bet you wished I used Julia!"

To some extent this is true. I really, genuinely believe that Julia is an exceptional tool. However, I also believe that people should use the tools they are good at! Lots of people are truly incredible engineers with Python or R or C++ or Rust. All of these people should continue using the tools that they love or are good at, because life is simply too short to waste doing shit you don't give a fuck about.

That said, I do want to point to a few things that I think are truly superpowers of the language. Feel free to take them with a grain of salt. I am not interested in engaging in the "programming languages flame war" that everyone seems to want to devolve into all the time. Languages are tools. use the ones you want to build your thing and get on with your day. But be aware that different tools are good in different ways!

I have a few beliefs about Julia that I want to expand on:

- I wish that we as a culture spent more time working on developing Julia the language, and developing Julia packages, tutorials, blogs, etc.
- Companies should be experimenting with Julia somewhere in their processes.
- People learning to code should consider learning with Julia.

The content of this post addresses each in turn. I don't want to slander other languages because they are all incredible in their own ways, so please go elsewhere if that's what you're looking for here. I note however that I do make comparisons between languages below, but my comparisons may be subjective. Take them as you will.

Let's dig in!

## We should build more stuff in Julia

Something that has always impressed me about the Julia ecosystem is how incredibly easy it is to write a new package that is of a pretty high quality. In R or Python or whatever, I feel like it takes me an extremely long time to write code that is something I would consider submitting.

Admittedly, this is because I am better at Julia than I am with other languages, but I have become conversant in a lot of languages and pretty good at a handful. Just take that into consideration, I suppose.

I see a lot of great packages just kind of pop up. And they're really good! The people writing them are usually not professional engineers, either, and may not even have learned to write software in classes or in a workplace. Usually, you'd expect these packages to be total ass -- but they aren't. Julia makes it easy to just jump right in and become a meaningful contributor, right off the bat, even if you're not an engineer.

There have been times in the past where I had to run some nightmare package some PhD student wrote in R or Python. This is often the worst day of my week. Things are broken, unclear, use bizarre unidiomatic code, or hacked together and inflexible. It's not fun. Not to say that PhD students necessarily write terrible code, but more that the tools they tend to use do not guide them gently towards success.

Julia packages, especially ones made recently, are incredibly high quality. Even though a bunch of overworked PhD students write packages, they tend to work well and they integrate with other packages in the ecosystem, sometimes flawlessly, Sometimes packages just work together with one another almost [by accident](https://docs.sciml.ai/SciMLTutorialsOutput/html/type_handling/02-uncertainties.html) (see [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) and the star of the Julia world [DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl)).

If your company does any kind of computational science (ML, statistics, physical sciences, engineering, etc.) you should consider looking for people who have spent time in the Julia world. They are more likely than not a good hire and a great fit for your company. And if you have the resources, it might be worth applying a little bit of the company's energy towards the Julia ecosystem. You'll get a lot of good faith from people who can help you succeed.
## Companies should experiment with Julia

There's a certain time of person who gravitates to different languages. I have kind of a vague and possibly offensive belief that you learn an awful lot about a person by the tool they choose to interact with a computer.

This is much more evident for the more niche languages. If you're an R or Python person, chances are good that you're using the language because it's part of your job, or the first language you learned, etc. The pool of people who use the language is too big for generalities because the pool is representative of, you know, people.

I don't feel like I know the other languages well enough to characterize them. Perhaps it would be insulting to try. You may have your own mental image of the Haskellian, the OCamellian, the Ruby folks, or the Rust compiler engineer. I'm sure you could come up with a few yourself, perhaps you can leave the stereotype you think people might have for your most favored language.

I can however characterize the Julia users. They're _brilliant_ people, and I mean truly exceptional. They're not the best engineers, certainly. But they are often experts in their fields, and someone who _loves_ to work on the computational aspects of their chosen field.

Julians (the demonym of the nerds who use Julia) are often not primarily computer scientists or engineers. They are often academics in varied fields: economists, geologists, statisticians, etc. The thing that tends to pull these folks together is that they have a draw towards the computational aspects of their field. They use Julia because they love it, not because they have to or because it is often necessarily the greatest tool for the job.

I think companies that recruit scientists should really think about the tools they make available to their employees. The language that is widely available within a firm influences who is more willing to work for you. Lots of very, very smart people who are good at not only their field of study but also in the tools and methods to apply that field computationally use Julia. If you make that tool available to them, they might be more willing to work for you.

Providing a "niche" language to your employees can also build a certain level of cache that makes you much more attractive to a certain type of person. Take a look at [Jane Street](https://www.janestreet.com). Jane Street is a pretty standard trading firm, with the exception of it's unique culture. Jane Street is _renowned_ for its use of OCaml, which I think many would agree is a relatively obscure language -- Jane Street, however, use OCaml almost exclusively. Jane Street's culture is one of exploration, technical skill, and functional programming -- all of which are highly attractive to a particular breed of engineer.  

Companies should start doing this too! They could become known as "Julia shops", and pull in people who are _already experts_ in their field and in engineering! To be honest, I am a little confused as to why firms haven't picked up on this already. If I were running a company that used data/models/math/statistics/etc. (i.e. all companies) I would heavily target Julia users by telling them they could use the tool that they love, and by supporting the ecosystem by contributing developer hours or other resources.

Seriously. It's good quality talent and you should start taking advantage of it. Speaking for myself, I expect to command pretty high market rates -- I have a lot of useful skills that firms pay a lot of money for. I would take a _huge_ pay cut to be able to work exclusively in Julia. Think about it.
## Learning to program can be easy with Julia

I started writing Julia many years ago (must have been 2016 or 2017, I think) in large part because it was _pretty_. I found the syntax to be approachable and the concepts to be easily digested. At this point, I had written Java, C++, Python, Haskell, and R. I didn't actually _like_ any of these languages. they were tools to do coursework or explore some kind of problem, but the use of any of my pre-Julia programming languages was always a massive slog.

When I got into Julia in full, I jumped pretty hard into the deep end. [Hong Ge](https://mlg.eng.cam.ac.uk/hong/) at Cambridge asked me to work on [Turing.jl](https://turinglang.org/stable/) during the first year of my PhD. I didn't know much about probabilistic programming at the time, but I knew some Julia and I was rapidly becoming a pretty good statistician as my PhD coursework progressed.

The thing that stands out to me about my high-activity period with Turing.jl was how amazingly easy it was to write acceptable or even good code for a popular software package. I did several major re-writes of various elements of the Turing ecosystem, in many cases without understanding terribly well how the internals worked or how to write performant, production-quality Julia software.

Amazingly, I managed to get by! If you've not worked with Julia, I think I can tell you how much of a delight it is to someone who is used to working with other languages. Things that are hard in many languages are often quite easy in Julia -- I might argue that this is partly because the way many people's brains think is reasonably well aligned with the semantics of Julia code.

I've heard this from lots of other folks too. A common experience (but not universal) is that people feel _happy_ to write code again. I'm not sure if you've had this experience, but learning to program for the first time can feel kind of incredible. Seeing stuff print out to the terminal, proudly running some dumpster fire of a calculator that took you four days with no errors, or maybe just pushing through some obnoxious bug for hours on end only to face the euphoria of fixing it.

I felt this when I learned Julia, after I'd become a little jaded by working on other languages. And I often still feel it when I'm working in the language. It's just a stream of constant delights when I get the opportunity to use it.

There's a world where we teach people how to write code, and where their first language is Julia. Python I think is hard to beat on this front, in large part because of how many established tools there are for learning (Stack Overflow, forums, books, etc.)

I think it's worth thinking about though. Python, which is many people's first language nowadays, has this unfortunate problem that a lot of folks like to call the "two language" problem. Rather than rehash that as many Julia people do, I want to point out exactly what you lost when you teach people a language that has an "interface" at the top level that people learn (Python) and a massive archive of high-performance code written in some "other" language (C++, Fortran, etc.).

What happens is that all of that distant, high-performance code that **someone else** writes feels impossible to grasp, especially if you're learning to program for the first time. I don't know about you, but when I started to learn programming I did not feel like I would ever be able to write anything that was "best practices" or fast or whatever. I'd behappy with printing hello world or remembering the syntax for if/else blocks.

To highlight this distinction, I like to think of the two parts of programming languages that we tend to inhabit. The **front** of the programming language is the part where you enter when you first learn it. Syntax, basic control flow, how to call functions, etc. This is essentially the userspace of a language. The next part, the **back**, is where you start rooting in the internals. Writing packages/modules/libraries. This is where you start really engineering and modifying things.

The advantage of Julia is that you can start in this really basic space that Python inhabits. The **front** of Python and Julia are very similar. You can write your really simple programs, use it as a calculator, whatever. It's a safe, comfortable place to learn the basics of computing without too much stress -- Julia is often quite forgiving, as is Python. Being a Julia _user_ is a delight, and can often feel effortless and fluid when you sink into it.

The **back** of Julia is where it really starts to shine, especially when you compare it to Python. I would argue that Python has about half the back of Julia, in large part because all of the cool numeric stuff in Python is hidden elsewhere, developed by someone else, lost to an early developer's limited grasp on multiple programming languages. You can go pretty far. You can write webservers, static site builders, or even write massive libraries to fit neural networks.

But if you are a person who has lots of skills in a particular area that is NOT programming in one of the high-back languages like Fortran, it may feel impossible to build a system that has your needs in mind.

In Julia, the back is flexible, and as deep as you can possible get. You can dive into the compiler of the language, or how things are being allocated, types, etc. You can build enormous, relatively high performance tools with no switching costs between languages.

As an example, I wrote a packages with David Widmann and a few others called [AbstractMCMC.jl](https://github.com/TuringLang/AbstractMCMC.jl). This package essentially provides and interface to common MCMC tasks, and it guides the framework for lots of the way that the code works in Turing.jl and it's various packages. It was pretty straightforward, even if it was more of an engineering task than a scientific one. But being able to build it made the scientific part of the work easier to do. There wasn't a point in the development of AbstactMCMC.jl where I thought "I can't do this" because I was having trouble getting my linker to find some weirdo library or whatever. It just worked because Julia is a great tool for getting thoughts out of your head into the computer.

I think we should give this opportunity to more people if we can. When you learn how to write Julia, you're learning how to understand the depths of a beautiful language just as well as you understand the easy, accessible, userspace of the language. I personally would like to see less programmers be dissuaded by trying to learn C++ (as I nearly was) and more programmers given the joy of building something incredible just because they had an interesting idea.

If you're interested in learning Julia, I can highly recommend it as an experience. Here's a list of a few resources to get you started:

- [JuliaAcademy ](https://juliaacademy.com) for videos and tutorials
- Going to the [Julia Discourse](https://discourse.julialang.org) for help
- The [Julia manual](https://docs.julialang.org/en/v1/)
- The [Julia in 100 Seconds](https://www.youtube.com/watch?v=JYs_94znYy0) video
- The wonderful [doggo dot jl](https://www.youtube.com/@doggodotjl) channel on YouTube
- My video series [Julia for Economists](https://youtube.com/playlist?list=PLbuwVVKCI3sRW0Y5ehBFwdFVuyuy87ram)
## Conclusion

I'll wrap up here for now. I _love_ working in Julia to this day and I wanted to share a bit about why I think that in here.

To summarize,

- I wish that we as a culture spent more time working on developing Julia the language, and developing Julia packages, tutorials, blogs, etc.
- Companies should be experimenting with Julia somewhere in their processes.
- People learning to code should consider learning with Julia.

I hope to see you at the next JuliaCon! I'll definitely be there.
