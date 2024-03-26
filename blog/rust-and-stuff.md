+++
title= "Rust & More"
date= Date(2018,06,03)
+++

For the past two or so weeks I've been spending a lot of time writing [Rust](https://www.rust-lang.org/). Rust is a really spectacularly designed language with perhaps the greatest package manager.It's called [Cargo](https://crates.io/). I've been continuously blown away by how lovely it is to write stuff in!

Rust is fascinating to me because it's one of my first true compiled languages. In contrast to the other languages I'm somewhat good at:

* R (mostly interpereted)
* Python (interpereted)
* C# (JIT compiled)
* Julia (JIT compiled)

I am only passingly familiar with C and have mostly repressed C++, so Rust was both new and refreshing to me. The workflows are strikingly different -- with Julia or R or what have you, I go through a very rapid iterative process. Write something, run it, see what worked, fix it, move on to the next issue. It's very slapdash.

With Rust (and, I presume other compiled languages), I have to stop and _think_ a lot more about what I'm doing and how I'm doing it. This is a bit more important in Rust because of the concept of __ownership__, an entirely bizarre concept of who owns what thing in any given program.

My (admittedly frail) understanding of ownership is that everything that exists in a program is owned by a varible. Once that variable goes out of scope, the memory allocated goes with it. It's how Rust manages memory safety. It has a pretty steep learning curve initially, but once you've learned it it's almost effortless to use. 

All in all, it's a spectacular language. Fast, too. And ultra strongly typed with none of the rigid puritanical stuff that comes with Haskell.