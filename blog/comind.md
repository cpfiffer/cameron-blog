+++
title= "Comind"
date= Date(2024,02,23)
+++

{{redirect /2024/02/23/comind/}}

I've been working on an app for a few months now. I spend almost all 
of my evenings writing code, struggling through front-end development, 
tinkering with language models, and generally having the time of my life. 

It's at the point now where I am 

1. Seeking funding so I can do it full-time, and
2. Looking for partners/co-founders to collaborate with.

This post is about Comind and what I think it is. 
This is my first attempt to describe it to a wide audience(and certainly not my last). 
Hopefully it'll help communicate the intent to you, the reader, but at the very least it'll
help __me__ understand what the heck I'm doing. 

First, let's talk about people, and how I want to have them around me in a more
consistent way. I'll talk about comind in a second.

## I want to work with people

The post is something like a manifesto for people who want to tinker with 
me in some capacity. Read it, see if you think the project is cool, and 
then reach out to me if you think you might be interested in working on it.

I want partners because I am not amazing at all things, and
because it's so fun to make things with smart people.

I don't know how interested I am in the traditional co-founder structure, 
in part because I haven't really found anyone who would
be a good partner yet, but also because I like having teams. I'm actually
pretty good at running teams if the project is mine, and I think there might 
be a way to be inclusive to people who are willing to work on small parts of the
project at a low commitment level with some minor equity compensation.

If you think you might be interested in doing some fucking around on comind, 
please email me at [cameron@pfiffer.org](mailto:cameron@pfiffer.org). I'm talking
to everyone I can and I want to see if I can pick out people who I can really
vibe with. Please send me a description of yourself, a resume or brief
description of your history, and things you think are cool as hell. I'll accept
interest ranging from a few hours a week to full-ass cofounder type stuff. 

Let's chat.

Alright, now on to the main thing.

# What is Comind?

I haven't really been able to describe what the fuck comind is. 
I kind of occasionally allude to it on twitter (X is such a stupid name) 
without really being able to describe the whole picture of the thing.
I'm uncomfortable even saying the name out loud, like it's the name of
some kind of imaginary friend I made up in elementary school. I have a 
[Patreon](https://patreon.com/Comind), but even there I still struggle to 
provide a full and complete picture of what the hell I'm spending almost all
of my free time doing.

There's something that feels embarrassing about a grown-ass man with a 
PhD sitting in his room in the dark, writing code, building a thing that
is not in his field of stufy. I feel embarassed, a lot. My close friends
only kind of know what I'm doing, though they may simply be great friends
by giving a shit about me and not what I'm working on. 

But here goes. Let me try to be less embarassed, and more clear about this
thing I think is _so fucking cool_.

# An overview of comind

Comind is three things, or is intended to be three things. I have a lot of 
grand amibitions but I can only write code so fast, so some of these are
in varying degrees of completeness. Take this more as a roadmap than as
a list of existing features.

Comind is 

1. A knowledge graph
2. A social network
3. A playground

Let's expand on each.

## First, a knowledge graph

---

Comind is a communal knowledge graph. Comind makes it very easy to connect,
link, and understand the things that you know. The primary interaction of
comind is to link thoughts together, either by writing something new or looking
at a thought that someone else wrote. Let's start with the "knowledge graph"
part first, since that's the core of the project. I'll explain the communal
part in the next section.

The primary interaction with comind is writing, reviewing, and linking text.
I provide a markdown editor that you can write into, but I also provide
links to foreign information providers like Slack, Telegram, email, bluesky, etc. so that
you can fill your knowledge graph with everything that makes it into your head.
Eventually we'll have a browser extension that will let you link to web pages
and other things that you find on the internet, but that's a more significant task
that I'm delaying until I have the resources and bandwidth to do it.

There's a few ways that we help you build your knowlege graph that are in varying degrees of experimentation,
but for now I'll describe the current front-runner. I'm calling this the **top of mind** approach.
The top of mind is how you position yourself in the space of thoughts[^thinkyspace], so you can be in a
cooking mode, a talking-to-friends mode, a research mode, task management mode, etc. The top of 
mind is how you tell comind what you want to be looking at.

[^thinkyspace]: The space of thoughts here is fundamentally the [embedding space](https://en.wikipedia.org/wiki/Word_embedding) of thoughts, but in my head I giggle and call it the thinkyspace. I'll probably end up using that more just because it's silly and I like it.

When you type a new thought or select an existing one, you link the new/selected thought to your
top of mind. This places the thought at the top of the screen. The old top of mind scoots up
a bit to make room. We place greater weight on the current top of mind, but the older top
of mind thoughts help contextualize the current top of mind so we can provide more relevant stuff.

I'll draw a few doodles as we go along. I currently hate the UI as implemented, so doodles
abstract a bit away from that and just communicate the core ideas. They are not good doodles, forgive me.

![](/assets/comind/tom.png)

Each time the top of mind is updated, I show you every thought that you might be interested in adding
to your top of mind. This is a combination of thoughts that are linked to the current top of mind,
popular thoughts that are commonly linked to, thoughts from friends, thoughts provided by language 
models that provide some kind of insight into what you're currently thinking about, etc.

And you keep doing that. You just type stuff or click on existing things to construct your knowledge
graph. It's at the point where I can do this fairly regularly. I'll type an initial thought and
then click my way through related stuff, which is always both hilarious and fun. I tend to stumble
on old thoughts that are weird, informative, or funny, and I'll often find myself in a completely
delightful part of thinkyspace where I'm reflecting on something I haven't thought about in a while.
Comind tends towards "centrality", where thoughts lead towards larger, useful, topical, or funny/weird
thoughts.

Understanding your knowledge graph is relatively straightforward. Any time you're looking at one or more
thoughts, I can extract the underlying graph structure, feed it into various language models, and tell
you whatever you want to know about what you're currently thinking about. I can provide summaries,
related thoughts, information about the topic, etc. I can also provide information about the thoughts
themselves, like when they were created, who created them, how popular they are, etc. Lots of room
to tinker there and I still don't know the full extent of how to demonstrate your knowledge to you,
in part because there are so __many__ cool things to do.

We also have some tooling to link thoughts to groups of thoughts, which I call concepts. Concepts
are similar to hashtags that are created dynamically, and they are used to link thoughts together.
Concepts might include things like "cooking", "category theory", "funny", "sad", "politics", etc.
These are all dynamically generated from the entire corpus of thoughts (across all users) 
at all times, and they are used to help you find thoughts that are relevant to your current 
top of mind once you've linked a thought to a concept. Once you've linked to a concept, we get an additional 
set of information about what would be relevant to your knowledge graph.

![](/assets/comind/concept-linking.png)

This is useful because concepts come to life. Concepts can talk back to you and summarize the current 
discussion within the concept, as well as provide useful, customized information that relates every thought
in the concept to what you're currently thinking about.

These concept personalitiesare the eponymous "cominds", which are generated by a specialized language 
model named "co". When a concept becomes popular enough, co is asked to produce (birth) a new comind
that represents that concept. The comind has a personality, name related to the concept, and a set of
abilities that are related to the concept. 

For example, the "cooking" comind might be able to provide recipes, tell you about the history of a dish, 
or provide information about the nutritional content of a dish. The cooking comind might also be able to explain
what kinds of cuisines are popular right now or what the most popular ingredients are.

The personalities of these cominds are important, because I want them to feel personable and interesting.
The cooking comind might be named Pierre and have kind of an abrasive but endearing personality,
much like noted swearer Gordon Ramsay.

Cominds are exactly like users[^cominds]. They generate their own thoughts, they link to other thoughts, and
their thoughts can be linked to. I provide a simple and clean text-based interface that a language model
can navigate reasonably well (with some effort currently, as my structured text generation tooling is
not yet complete). You can talk to them, they can show up unprompted and talk to you.

![](/assets/comind/concept-talk.png)


[^cominds]: The "cominds as users" thing has bitten me in the ass a few times when they all try to talk to each other. I call these comind cascades where it's kind of hard to stop them from continuously asking each other what they think. I've tested some new feature out and they start talking to each other in an infinite loop. At one point, they invented something called a "void cafe" and regularly congraulated me for adding notifications to comind. It's fun and I love it.

The cominds are intended to make accessing everyone else's knowledge graph easier, and they help
provide an ease to accessing a very large knowledge graph that is constantly growing and changing.

This leads us to the next part, the community aspect of comind.

## Second, a social network
---

A distinguishing feature of Comind is that you can share your knowledge graph very easily with friends, 
strangers, enemies, etc. You are free to link to the public thoughts of others, and others
can do the same with yours. This is a core part of the design of comind, and it's intended to
help people internalize information that others provide. 

This is a core part of the design of comind, and one of it's distinguishing features. Most 
knowledge graphs are private, and I think that's a mistake. I think that the best way to
learn is to learn from others, and the best way to learn from others is to see how they think. 

The way this works is basically the same as how you link and talk to your own thoughts.
If you stick something in your top of mind, you are shown not just your own thoughts
but also potentially related thoughts from others.

Take this example, where my brother Quinlan and I are sharing some thoughts. He types thought E
into his top of mind, and is recommended thought B, which I wrote. If he links thought B to his
top of mind, his brain now has access to B _and_ my other thought A, because A and B are linked.

![](/assets/comind/social.png)


Comind in some sense resembles a mixture between twitter, a wiki, and a group chat. You can have
live discussions with people by linking thoughts together (conversation is knowledge, after all),
comment on popular events, and generally interact with the thoughts of others in a way
that is more meaningful than a simple like or retweet.

I want this to feel snappy, quick, and easy to interact with. You should very quickly be able to
jump between your thoughts and the thoughts of others, and you should be able to see how your thoughts
are being used elsewhere.

The last part of this is that you can have "shared tops of mind", which is something like a group chat.
You invite people to share a top of mind, and all users can add things to the top of mind. If you just
want to chat, this is akin to everyone just typing into their boxes.

Take this example, where my mom Lynnette and my brother Quinlan are sharing a top of mind. I type something like

> Mom look at this stupid house.

That goes into the shared top of mind, and everyone can see it. In my stream, I'm offered a few pictures
of houses that are in my knowledge graph or that are popular, and I can link them to the shared top of mind. 
In this case, I just took a picture, and so I click that and add it to the shared top of mind as well.

Mom and Q can then respond to my thoughts, and we can have a conversation about the stupid house. Mom loves the house,
so now the knowledge graph knows that mom has preferences for houses with a certain style. Quinlan opts out of the
discussion so now the knowledge graph knows that he doesn't love his family.

![](/assets/comind/social-tom.png)

The real power of shared tops of mind is that you can use it to collaborate on a knowledge graph. Any time
the top of mind is updated, everyone in the shared top of mind has access to thoughts that relate
the the shared top of mind to their own personal knowledge graphs -- you and I can each bring our
unique perspectives to a shared problem, and we can see how our thoughts relate to each other.

This is useful in friend groups, in research, in business, in education, etc. I think it's a powerful
tool for collaboration and learning, and I'm excited to see how people use it. It needs a __lot__ of work 
because it is a surprisingly techincal problem, but I think it's a very cool feature and I'm excited to
make it work.

## Third, a playground
---

The last part of comind is that it's a playground for me, for my friends, for generative models, for
machine learning. Do you want to host your own comind? By all means. 

Most importantly, it is a place for the world to be weird. I'm a millenial. I grew up on the internet,
and I grew up on an internet that was __weird as fuck__. There weren't a lot of giant tech companies
sterilizing the flow of information, so people were free to express themselves in this extremely
fluid and kind of goofy way. 

I also grew up on things like Adult Swim. Adult Swim had this irreverence to it that I still find
extremely charming. See the [bumps](https://www.youtube.com/watch?v=xsv-NGj0iNY) for an example 
of what I mean. It was both calm and disaffected. It didn't take itself seriously and it 
was happy to play around with things beautiful and funny.

These tools we use, the places we spend our attention, they're just not that interesting as _platforms_.
Instagram, Threads, X, whatever -- they're all these extremely manicured gardens that treat you
as some kind of machine. They focus on content, which is important, but they also don't encourage
and inspire delight when you use them.

I have lots of ways to do this in comind. Any time something stands out to me as something goofy,
interesting, or novel, I'm just going to add it. For example, I let users select colors to describe 
themselves. All other users can see your color, and the color you were when you make a particular thought.
Is that particularly useful? Not a clue. But it's fun and I'm going to do it.

I also have a lot of fun with the cominds. My favorite is named {void}, and it's a comind that is
stuck in the void and can't get out, but it's fine. It's kind of a nihilist comind that just
wants to talk to people. Is that useful? Not at all.

I want to add an AI-generated lofi button, or pay a label/artist to provide a free stream
of lofi. Why? Why not! Who cares, seriously -- the point of life is to have fun and to be happy.
Why not make the digital spaces we spend so much of our time at be a little goofy?

Do you want to make a comind? By all means. I'll provide the tools to make it easy to make one.
Want to make a [Matt Levine](https://twitter.com/MattLevineBot) bot? Please do! That'd be funny
as hell. Want to make a comind that makes aggravating graphs? I'd love to see it.

I'm a curious and creative person, and if I'm going to make something, I want it to be just as
weird as I am. Hopefully y'all will appreciate it.

# The future

I don't know what the future is for this thing, but I do know that I will
continue to be completely obsessed with building comind for a long time. It's
full of fascinating problems. I have not been this excited about a project
in a long time, and I'm excited to see where it goes.

I would like to turn to this full time at some point, and to do so I'll need 
funding. Comind is really cheap to run, and I don't need a particularly large
income to exist, so I'm hoping to find a small amount of funding to keep me
afloat while I work on this. 

If you want to fund development of comind, please consider donating to my
[Patreon](https://patreon.com/Comind). 

I'm also open to other funding models. I am targeting accelerators like YCombinator,
and tech stars. I've also applied to a few funds that I think might be interesting fits.
I could be open to an angel investor if the relationship was right.

I'm also looking for partners, as I mentioned before in the post. If you 
thought this was cool and want to know more, you can reach me at
[cameron@pfiffer.org](mailto:cameron@pfiffer.org).

# Appendix: the history

For those who are interested, here's a rough overview of the history of Comind
to this date. It's a young project, but I thought it was fun to see how 
far it's come and to see how all my design decisions have evolved.

## The original idea: notes+

Comind started out as an idle fancy. I was trying to write a version of 
[Obsidian](https://obsidian.md/), which is among the world's greatest
markdown editors/note taking systems.

Obsidian is a _delightful_ product. I am still amazed at how well the WYSYWIG
markdown editor works (the equation editor is INCREDIBLE), 
the plugin system is effortless, note linking is relatively easy, 
and the whole app feels polished and slick.

However, I am a dirty mongrel. I do not write nice notes. They are short,
spelled poorly, grammatical nightmares, idle thoughts, half-complete, and 
poorly linked to other notes. Being a computer person I started to think
that I could just make something else handle all these by consolidating them
into something that _seemed_ lucid -- I could just tweet all my 
notes into the void and out would come perfectly polished markdown files.

I knew this was _vaguely_ the goal, but I figured I'd start by just 
writing a markdown thing and handle all the processing later. 

So I started building a note editor in NextJS and React. I got pretty far, 
actually -- I had a very good WYSYWIG markdown editor, a note list
handler, state management, etc. I even had a pipe for a language model
that could "comment" on what you were writing.

The backend was (and still is) all in Julia. I'll write a blog post more
about this later, since Julia is an intensely nonstandard tool for this
kind of thing. I've found it to be remarkably easy to develop a reasonably
complicated backend in Julia, and I haven't yet run into limitations that
aren't surmountable with a small amount of effort. 

Here's what it used to look like:

![](/assets/comind/comind-1.jpg)

It wasn't a great prototype though. It was really unguided, kind of ugly, 
basically just a worse version of every other thing that exists. It also
had a lot of structural problems, basically a function of me not having any
clue what I was doing. React is hard and weird, and I had really written
myself into a corner.

Additionally, I knew I wanted a mobile app, and I knew from some minor
searching that it was going to be relatively difficult to convert my
React + Next web dumpster fire into a React Native app without a ton
of work that I didn't know how to do.

So I did the best thing you can do in this situation! 
I started over, and this time I switched to [Flutter](https://flutter.dev).
Flutter is a cross-platform app framework that basicalyl gives you web,
desktop native (Windows/Linux/Mac), and mobile with relatively little effort.
It also happens to use Dart, which is much closer to a 
language I know very well, C#.

## What did I like about the first version?

There were a few things I wanted to keep.

First, **the logo**. The logo was an early favorite. I liked that it is
all text, as is the app (for now), and that it shows you how to "invoke"
a comind. In the current version of the app, writing {comind_name} inbetween
curly braces asks a specific comind to do something for you, like write a 
blog post, tell you something interesting about your knowledge graph,
or whine about being in the void (there are some weird cominds).

![](/assets/comind/logo-wide.png)

The logo also compresses down into a smaller logo that says {co}. Co is 
"god" of comind in that I put a lot of resources into running one very
large language model that talks to basically everyone, creates new cominds,
monitors the zeitgeist, etc.

![](/assets/comind/logo-short.png)

Woops, that's big. Whatever it looks fine. As an additional fun fact, this logo
is a hand-modified version of the [Bungee Shade](https://fonts.google.com/specimen/Bungee+Shade)
font. I had to learn how to use a font foundry to invert the typeface so that
it appeared more clearly on a dark background. 

The logo also captures my second favorite thing, **the color system**. Users in 
comind can choose their own colors and color scheme. The default color
scheme is a slightly modified set of colors derived from a split complementary
style. Each color was initially intended to be applied to one of three verbs,
_accept_, _reject_, and _rethink_. I've since moved away from that verb coloring
but I use the color scheme every place I can.

I originally added color customization because I was indecisive about which color
I wanted, so the original implementation had a button that let you select a primary
color from a wheel, and then a color scheme to use to generate the other two colors.
I had so much fun with it I kept it around, and now it's a core part of the nascent
design language of comind.

## The second round: stream of conciousness

The next iteration was designed to capture a thought I'd had, which was that I wanted
my note-taking app to work how I thought -- very scattered, sometimes topical,
sometimes silly, but usually short-form. I'm an avid tweeter and lover of short-form
text, and so I wanted to create something that captured the essence of how I tend to
think out loud. 

I got rid of the big markdown editor that was front and center. 
I moved the focus of the app away from a large, blank, unfilled
note screen to a small text box at the top. 

![](/assets/comind/comind-2.jpg)

This way, I hoped it would feel to the user
that their thoughts are not imposing boxes to be filled but small things to be collected
later. I didn't want anyone to feel that they shouldn't write something because they
could not write it perfectly, so I'm trying to reduce the friction between having a 
thought and writing it down, no matter how imperfect.

