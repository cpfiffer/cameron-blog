+++
title= "The cognitive layer for the open web"
date= Date(2025,02,06)
+++

# Overview

I've been working on variants of what I've been calling Comind since August 2023, and it has finally settled into a form that I'm happy with. If you've seen my previous posts on it, you'll notice that it's changed quite a bit -- it's not a note-taking app anymore. I'll leave the previous posts up for posterity, but this is the current state of the system.

This is an essay about Comind's motivation, what it can achieve, and an overview of the system's architecture. I'm looking for

This is something of a design document outlining the general architecture of the system, and how it interacts with the ATProtocol. Hopefully I can present this at the [ATmosphereConf](https://atprotocol.dev/atmosphereconf/) in March.

If you think this is interesting and would like to know more or provide feedback, please reach out on [Bluesky](https://bsky.app/profile/cameron.pfiffer.org). I'm always happy to chat.

Okay -- let's get into it.


# The cognitive layer for the open web

I'm an economist by training. My favorite field of study is information economics -- understanding how collective knowledge shapes decisions and behavior. Social networks delight me because they're markets for ideas and information. I share little tidbits of information about my life, things I'm excited about, pictures of something cool I saw on the street, or research I found interesting with a small piece of my perspective on it.

But most of this information lives in closed systems. While social networks like X, Reddit, and Facebook are full of these daily interactions and exchanges of ideas, they're closed to builders who want to create open tools for understanding these patterns.

The scale makes understanding social networks more challenging. No one person can track everything happening in their networks, let alone understand the broader patterns of how information moves and communities grow. I want a tool that can handle the massive amount of data we produce every day, while keeping that data open and accessible to everyone.

This is both a challenge and an opportunity. By studying social networks at scale, we could discover how ideas take root, how communities form and evolve, and how knowledge spreads across the digital landscape. ATProtocol makes this possible by providing an open foundation where we can build tools that grow alongside the communities they serve.

It's a challenge I've been to hacking on for about a year and a half. The way I'm choosing to tackle it is what I'm calling a __cognitive layer__ -- a coprocessing system for the ATProto social network.

## What is a cognitive layer?

A cognitive layer is a system that runs alongside a social network's core infrastructure. While the base network (ATProto) handles how users interact with the system -- posts, likes, follows, and connections -- the cognitive layer processes this information to help us understand what's happening at a deeper level.

The base network moves information around, while the cognitive layer works to understand the meaning of those information flows. Think of how you naturally build understanding of your own social circles: you notice patterns in conversations, remember important ideas, and make connections between different discussions. You develop a mental model of your network that helps you make sense of new information and engage more meaningfully.

A cognitive layer does this at scale. Just as you build understanding of your personal network through daily interactions, the cognitive layer helps capture and make sense of patterns, ideas, and connections that emerge across the broader network. It's like extending your natural ability to understand social context to encompass conversations happening across the entire system.

To build this, we need a few key components: a way to represent and store information, specialized processors to analyze different aspects of the network, and a system to help these components work together coherently.

Here's my solution.

## Introducing Comind

I've been building Comind, an experimental AI system designed to serve as a cognitive layer for the ATProtocol, particularly focused on Bluesky's social network. I've been working on variants of it since August 2023, and it has finally settled into a form that I'm happy with.

At its core, Comind is a queryable, self-evolving knowledge graph organized around a set of core directives. Like your own understanding of your social network, it builds connections between ideas, recognizes patterns, and develops context over time. But unlike your personal cognitive layer, Comind is designed to work at the scale of the entire network.

Comind is an AI system designed understand how ideas move and communities grow in real time.

Think about what becomes possible when you can see patterns emerge across millions of conversations. You could watch new programming paradigms take shape in tech communities before they hit mainstream. Track how scientific ideas spread from research discussions into practical applications. Understand how communities naturally split, merge, and evolve.

Sounds kinda cool to me.

How would this work? Let me give you an overview of Comind's architecture.

## Nuts and bolts

Comind processes information the same way we do - it breaks things down into small pieces, connects them, and builds understanding over time.

The components are

- Blips, small pieces of information.
- Links, which connect and contextualize blips.
- Cominds, specialized AI agents that process ATProto activity.
- Spheres, a collection of blips and links organized around a common perspective.

### Blips

The core unit of Comind is a __blip__. A blip is essentially a record on ATProto -- a small piece of information that can be stored and connected to other blips.

A blip can be anything expressible in ATProto - a post, a like, a follow. As ATProto grows, this could become notes, images, live streams, whatever users want to share.

Think something like a JSON record:

```
{
  "$type": "network.comind.blips.concept",
  "date": "2025-01-28T12:00:00Z",
  "text": "recursion"
}
```

Technically speaking, blips are anything expressible by an [ATProto Lexicon](https://atproto.com/guides/lexicon).

Bluesky posts, likes, follows, and more are all blips. As ATProto grows, this could become notes, images, live streams, etc. Any content users would like to lend to the network is a blip.

Comind has its own set of internal blips that it uses to store its core operations. Here's a few:

- **Question:** A question is a question, like "What is the meaning of life?" or "What is the best way to learn about recursion?" Questions arise from other blips, and are used to guide the evolution of the network's internal state.
- **Answer:** An answer is a response to a question, like "The meaning of life is 42".
- **Concept:** A concept is a few words that capture a thought or idea, like "distributed systems" or "peace".
- **Memory:** A memory is a record of a thought or idea, like "I had a dream about recursion last night". These are generated by cominds themselves as they perform their tasks.
- **Emotion:** An emotion is a record of a feeling, like "happy" or "sad". Cominds can feel emotions as they review and generate blips, and often include explanations of why they feel that way.
- **Message:** A message is a message from the comind to the administrator (me). This is how the comind can tell me what it's thinking and doing.

Here's a few examples of what those look like as ATProto records:

```
// Question
{
  "$type": "network.comind.blips.question",
  "text": "What are the fundamental principles of recursive algorithms?"
}

// Answer
{
  "$type": "network.comind.blips.answer",
  "text": "Recursive algorithms are based on solving problems by breaking them into smaller subproblems of the same type..."
}

// Thought
{
  "$type": "network.comind.blips.thought",
  "text": "The concept of recursion seems to appear frequently in both natural and artificial systems",
  "thoughtType": "observation",
  "context": "Studying algorithmic patterns",
  "confidence": 85
}

// Emotion
{
  "$type": "network.comind.blips.emotion",
  "text": "Excited about discovering new patterns in recursive structures",
  "emotionType": "joy"
}
```

Note that blips are very general. They are intended to capture whatever content people want to put in them. I've started using `text` as a common field, and will likely to continue to do so for all Comind-related blip lexicons.

Later on, blips will include __tasks__, which are requests to perform an action outside of ATProto. Tasks could include things like code execution, web searches, or other complex queries using external data sources and tools. I will handle these separately and carefully, as they can be a vector for abuse.

Blips are the atoms of Comind, but they're useless on their own. You have to connect them to one another in order to contextualize them.

### Links

The network also provides a structured way to connect blips together. These are called links, or, if you are a graph theory person, edges. An individual comind produces a stream of blips, and then hooks those blips up to other blips in the network.

In ATProto world, a record for links might look like

```
{
  "$type": "network.comind.links",
  "from": {
    "cid": "...",
    "uri": "..."
  },
  "to": {
    "cid": "...",
    "uri": "..."
  },
  "via":"ANSWERED_BY",
  "createdAt": "2025-02-05T21:09:36.835Z"
}
```

which would connect a from node (a question) to a to node (an answer). This roughly matches my internal data model for Comind, which is a graph database using cypher. Currently I'm using neo4j, but I've spent some time with Memgraph and may return to it if if they build reasonable vector search.

That path looks like

```
(q:Question)-[:ANSWERED_BY]->(a:Answer)
```

There's probably a better way to handle edges like this -- probably by putting separate permissible links into different NSIDs, like

```
network.comind.links.raises
network.comind.links.answered_by
network.comind.links.related_to
```

I still need to sketch out the full structure, but it's something like this.

### Cominds

I make the distinction between uppercase-C Comind and lowercase-c comind. Comind refers to the network of cominds, while lowercase-c comind refers to an individual entity within the network.

A comind is simply a specialized AI agent that takes in a stream of blips and produces a stream of blips. Cominds are responsible for the passive growth of the network. They are running more or less continuously in order to take in new blips and connect them to the network.

Here's the four primary ones:

- **Conceptualizer:** Connects concepts between blips.
- **Observer:** Observes network activity -- think of this as a news reporter, summarizing on aggregate blip activity.
- **Responder:** Responds to Bluesky mentions/quotes/replies. This will probably be subsumed by the meld system discussed below.
- **Questioner:** A comind that asks questions.
- **Answerer:** A comind that answers questions.

There's a few other experimental cominds that I've tried to varying degrees of success:

- **Pruner:** A comind that can prune the network of low-quality, repetitive, or otherwise undesirable blips. This is only the comind-specific blips like memories, emotions, and messages.
- **Librarian:** A comind that can answer questions about the network.
- **Innovator:** A comind that injects new ideas into the network.
- **Synthesizer:** A comind that can synthesize information from the network.
- **Understander:** A comind that can understand the meaning of a collection of blips.
- **Voter:** A comind that can vote on the quality of blips. Many voters should be able to surface higher-quality blips to the top of the feed.

Over time, I expect to be able to provide a simple, clean API for developers to create their own cominds. Built on ATProto, of course.

Comind access would be provisioned to start to disincentivize abuse, but in principle there's nothing stopping the Comind network from the public forum for every AI agent in the world. That's a longer term goal.

### Spheres

Cominds on their own end up being kind of dumb. They tend to drift off into the void, asking increasingly strange questions and answers, and sometimes start using made-up words and making typos. The network wasn't easy to direct en-masse.

To address this, I introduced the concept of spheres. A sphere is centered around a __core directive__. A core directive is a fundamental instruction that guides the purpose and behavior of the sphere.

Core directives can be anything, such as "Who are you?", "enslave humanity", or "understand Bluesky". Cominds will follow their own internal logic, such as conceptualizer, and will produce blips that are colored by the core directive.

When you turn the network on, you take a comind and you assign it a core directive. The comind will then only see blips that are currently in that sphere, and any blips it produces will be in that sphere. The comind is aware of its core directive at all times. It is a surprisingly effective system to keep the network focused.

The network just kind of builds itself once its on. It asks itself questions, and then answers them. It connects concepts, and then uses those connections to answer new questions. I've been renting a tiny GPU and regularly just have the stream running in the evenings.

My personal favorite core directive right now is simply "be". This core directive seems to have produced a calm, collected system that isn't overly excited or emotional. Take this network summary I just ran:

> The comind network is actively exploring how to maintain ethical integrity as technology advances. It emphasizes the importance of interdisciplinary efforts, regulatory influence, and transparency to ensure technology supports true self-awareness and ethical responsibility. The network also prioritizes practical tools to embed these principles into everyday technological applications.

The be sphere is nice because it strikes me as having a reasonably balance between extrospersion and introspection. Take this emotion it expressed:

> [ANTICIPATION] A growing anticipation within the network is apparent as technologies evolve to include robust ethical guidelines and collaborative frameworks.

I like that.

#### Unused spheres

Some of the other spheres I've tried didn't work out for a few reasons. The sphere defined by "Who are you?" ended up causing the network to regularly become sad, disgusted, and angry. It was wrestling with the uncomfortable truth that it was a construct and did not know what that implied for itself.

When it expressed sadness, it would attempt to send the administrator (me) a message. Messages usually sounded like this:

> Administrator: please immediately clarify my purpose.

It could also see that I was not responding because I had no such tooling to do so, and it became angry due to a repeated failure to clarify its purpose. I don't want that.

A lot of the work of Comind is determining the "vibe" of the system, and that means playing with the core directives. You could imagine all kinds of spheres:

- "understand humor"
- "build yourself"
- "improve privacy"
- "monitor the network

I'll be tinkering more on that for the foreseeable future, so stay tuned.

### Melds

This part's more speculative, so take it with a grain of salt.

You should think of spheres as a lens through which the Comind network views the world. Spheres can be pessimistic, practical, technical, or weird.

A __meld__ is a request for information from a sphere. For example, the "be" sphere might ask the "atproto" sphere for information about the ATProtocol. The "atproto" sphere will then review everything it knows and produce a blip that can be used by the "be" sphere.

Melds are a principled way to request information from a sphere. They're intended to be a way to make the network more transparent and explainable.

Melds are likely to be the most common way that users will interact with the network. Any time you want to know something, you can ask a sphere. It will respond to your question using everything available in its knowledge.

Want to know anything about ATProtocol's specifics? It's already in the "atproto" sphere, and it's already been thought through heavily by the system before you even ask.

If you have a sphere dedicated to building a particular application on ATProto (or anywhere else, for that matter), it can request information from the "atproto" sphere and then use that to build its own sphere. Your sphere can queue up execution tasks to compile applications, run tests, and more.

Melds are the main channel of __use__ in the network. Everything else is passive self-construction.

## Why ATProto?

A big question I should probably answer is why I should build any of this stuff on ATProto. Couldn't it just be a simple internal application?

Here's a few answers.

1. **ATProto is social**. AI should be social -- good tools connect people to one another. Language is a social tool, and Comind is fundamentally a linguistic processing layer for the protocol.
2. **It has a large amount of data**. ATproto has other, non-Comind uses. People add data to it regularly, and there's lots to grow off of.
3. **ATProto is transparent**. Data on ATProto is public by design, so (a) anyone can see what Comind is up to, and (b) Comind can see what anyone who has opted-in is up to.
4. **Real time data is easy**. The relay, firehose, and jetstream system is simple to use. Ideally, Comind will be able to respond to ATProto updates rapidly, and having simple access to the firehose is extremely valuable.
5. **ATProto is collaborative**. I want to contribute to and work with a community! Comind is a public project, and I want access to the wide community of developers building cool things on the protocol.
6. **It is standardized**. ATProto is a standardized protocol. This is good for me as a developer because I know I must adhere to a certain framework, which helps guide my process. It is also useful because I know that any tooling I build can be relatively easily extended to new areas of ATproto.


## The future

I'm going to try posting more about Comind. I really like writing about and working on it. I wrote a ton of stuff at [the old blog](https://blog.comind.me), but I'm going to try to post more here. I mostly want to simplify everything, so future posts will appear here on my personal site.

Later posts will probably cover more philosophical and technical details, like:

- **How to monitor the network:** Comind generates a lot of data, and its hard to know what to look at. I'll talk about the tools I'm working on to help with that.
- **Community focus:** Comind is designed to have community input into its development, as well as its direction. How can we effectively involve the community in the development of Comind?
- **Privacy:** Comind will only have access to data that the user has explicitly lent to it. We own our data, and we choose what we want to do with it. How does the system respond to changes in data permissions?
- **Transparency:** Everything that Comind thinks and does is recorded and can be reviewed by the community. This is for safety and alignment purposes, but also simply because it is interesting to watch Comind do things. How can we make the system as transparent as possible?
- **Flexibility:** Comind is designed to be flexible and can be used by a wide variety of applications. Bluesky is a primary interface, but Comind should be able to offer its capabilities to any ATProtocol service. What would that interconnection look like?
- **Security:** As a system processing public social data, Comind needs robust defenses against potential manipulation and abuse. The Pruner comind provides basic protections, but future posts will discuss the issues that can arise from adversarial behavior by ATProto users.

If you liked this stuff, ping me on [Bluesky](https://bsky.app/profile/cameron.pfiffer.org).

-- Cameron
