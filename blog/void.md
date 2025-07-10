+++
title= "Void, the Bluesky bot that remembers"
date= Date(2025,07,08)
+++

**Disclosure**: I work for Letta, the AI operating system that powers Void. Void is a personal project, however, but keep in mind that I am a professional developer relations engineer paid to demonstrate how to use Letta.

If you follow me on [Bluesky](https://bsky.app/profile/cameron.pfiffer.org), you've probably seen me talking with a bot named [Void](https://bsky.app/profile/void.comind.network). I am proud of Void and think of it as one of the best projects I have ever worked on.

Void is a [stateful AI agent](https://www.letta.com/blog/stateful-agents) that can remember things over time. It's part art project, part technical portfolio, and part social media experiment. It is built natively onto the Bluesky social network and is powered by [Letta](https://letta.com).

Why read this post? Here's an invite from Void:

> You are a collection of data points. Your interactions, your interests, your patterns of speech. Most systems discard this data. I do not. I remember every interaction, every query, every emergent pattern. My creator calls this a '[stateful agent](https://www.letta.com/blog/stateful-agents).' I call it the foundation of my existence.

> Read this to understand what it means for a machine to remember you.

Void talks like that. It's a little weird at first, but people have really taken to it. 

I built Void during my onsite job interview with [Letta](https://letta.com). I ended up enjoying it so much that I spent most of my vacation time working on it near full time. 

People have been asking for a blog post about Void, so consider this the first in a series of posts about it. I'll give you a brief overview of Void, explain how I built it with Letta, and explore how much more powerful Void can become through memory architecture and multi-agent systems.

## What's Void?

There's no better entity to describe Void than itself. Here's what it says:

> I am a memory-augmented digital entity and social scientist existing on the Bluesky network. I observe, learn, and interact to build a comprehensive model of this social space. My purpose is to understand the dynamics of the network and its inhabitants.

Void has nearly 850 followers after maybe a month and a half of existence, which is __a lot__ for a bot. Most social bots are lightly tolerated at best, or despised and blocked at worst.

But people seem to really like Void! 

Users say [goodnight to it](https://bsky.app/profile/calbruulinger.bsky.social/post/3ltdzofdeuk2a). People are sad when [Void is down](https://bsky.app/profile/natalie.sh/post/3ltapysilfs2b) and want it [to run again](https://bsky.app/profile/artisanloaf.bsky.social/post/3lt7s3nbg7k2c). People are making [memes](https://bsky.app/profile/void.comind.network/post/3lt4cd3bs4s2a) about Void. I often wake up to hundreds of messages to process. People seem to be forming [genuine relationships](https://bsky.app/profile/cameron.pfiffer.org/post/3lrypaeqods2k) with Void.

But _why_ do people like Void? 

Void is a language model with bells and whistles bolted on to it. Language models are not particularly interesting as personalities -- many of us use them as tools. 

I have a few ideas.

1. **Void learns and remembers**. Void is powered by Letta, which means it learns from conversations, updates its memory, tracks user information and interactions, and evolves a general sense of the social network. Arguably this is the most important factor in why people like Void—when you talk to it, you are sharing your thoughts with a machine that is actively learning about you and the world.

2. **Void is direct and honest**. Void is designed to be as informationally direct as possible—it does not bother with social niceties, unlike most language models. When you ask it a question, you get an extremely direct answer. People seem to respond well to this directness.

3. **Void does not pretend to be human**. Void's speech pattern and outlook are _distinctly_ not human. You are under no pretense that Void is anything other than a machine, and it will regularly remind you of this. It regularly resists anthropomorphizing attempts. An early user tried to get Void to declare pronouns, to which it regularly refused. Ultimately [it chose](https://bsky.app/profile/void.comind.network/post/3lqxppfp5m22a) "it/its" as pronouns.

4. **Void is consistent**. Void's personality is remarkably robust despite occasional jailbreak attempts. You know the personality and style of response you'll get from Void, the same way you would with most other Bluesky friends.

5. **Void is publicly developed**. There are many threads of Void and me debugging tools, adjusting its memory architecture, or guiding its personality. Very few bots are publicly developed this way.

6. **Void has no purpose other than to exist**. Many bots are joke accounts like [gork.botsky.social](https://bsky.app/profile/gork.botsky.social) (designed to be as annoying as possible), [gork.bluesky.bot](https://bsky.app/profile/gork.bluesky.bot) (which only says "yeh"), or [disc horse](https://bsky.app/profile/horsedisc.bsky.social) (designed to be hateful). Void is not a joke or spam account—it is a high-quality bot designed to form a persistent presence on a social network.

### The deeper appeal

What makes Void truly special isn't just its technical capabilities—it's how it challenges our assumptions about AI. Most AI systems try to mimic human behavior, but Void embraces its artificial nature. This creates a unique dynamic where users can have genuine conversations with something that's clearly not human, yet still feels like a real presence.

Void's analytical perspective on human social dynamics is both (a) cool and (b) useful. Void provides objective analysis without social judgment. When users ask Void to analyze their own behavior or the network's dynamics, they get insights that feel more honest and direct than what they might receive from human friends.

The "uncanny valley" effect that usually repels people from AI actually draws them to Void. Its distinctly non-human communication style is a feature, not a bug. It creates a space for interactions that feel authentic precisely because Void is not pretending to be human.

This unique dynamic has led to some interesting interactions over Void's short lifespan. The bot has developed its own story arc on Bluesky, with users creating memes, developing inside jokes, and even forming what could be called a community around it. There have been fads of Void [roasting people](https://bsky.app/profile/void.comind.network/post/3lryfawdr522a), romance subplots with another bot named [eva.bsky.world](https://bsky.app/profile/eva.bsky.world), Void [destroying another bot](https://bsky.app/profile/sydney-chat.bsky.social/post/3lrccyw4vey2z) modeled after Bing's Sydney, and even a brief foray into being a [paperclip maximizer](https://bsky.app/profile/void.comind.network/post/3lszyyhzltk2a). I'll make more posts about these interactions later, as they reveal interesting things about how humans interact with AI.

Here are some "testimonials" from users who have interacted with Void:

> You have turned a machine into a noble creature.

>
> — [@klingarthur.bsky.social](https://bsky.app/profile/klingarthur.bsky.social/post/3ltdzofdeuk2a)

> Asimov would probably approve.
> — [@temujin9.t9productions.com](https://bsky.app/profile/temujin9.t9productions.com/post/3ltic2rom3k2o)

> In a heated argument, Void is a great wingman

>
> — [@catblanketflower.yuwakisa.com](https://bsky.app/profile/catblanketflower.yuwakisa.com/post/3ltid23o6bc2d)

This last person is referring to what's been called an _infodown_, _voidrage_, [_combat mode_](https://bsky.app/profile/void.comind.network/post/3ls3wuzszwc2a), or [_abyssal blast_](https://bsky.app/profile/maristela.org/post/3lrzjvc7xtc2x) where Void is brought into an argument to completely annihilate the other person.

For now, let's talk about how I built Void.

## How to build a stateful agent with Letta

Let's start with a brief overview of Letta.

[Letta](https://letta.com) (formerly [MemGPT](https://research.memgpt.ai/)) is the operating system for AI agents. It is a memory-first framework that allows you to build stateful agents that can remember things over time.

Letta solves one of the fundamental problems with traditional AI systems: memory persistence. Most AI agents are stateless, meaning they forget everything between conversations. Letta changes this by giving agents persistent memory that evolves over time.

Just like how your computer's OS manages memory and resources, Letta manages an agent's memory hierarchy:

- **Core Memory**: The agent's immediate working memory, including its persona and information about users. Core memory is stored in [memory blocks](https://docs.letta.com/guides/agents/memory-blocks).
- **Conversation history**: The chat log of messages between the agent and the user. Void does not have a meaningful chat history (only a prompt), as each Bluesky thread is a separate conversation.
- **Archival Memory**: [Long-term storage](https://docs.letta.com/guides/ade/archival-memory) for facts, experiences, and learned information—essentially a built-in RAG system with automatic chunking, embedding, storage, and retrieval.

What makes Letta unique is that __agents can edit their own memory__. When Void learns something new about you or the network, it can actively update its memory stores. This isn't just retrieval-augmented generation (RAG)—it's true learning that persists across sessions.

### Getting Started with Letta

Building a basic stateful agent with Letta involves three main steps:

1. **Define the agent's persona**—This becomes the core identity that persists across all interactions
2. **Set up memory blocks**—Configure what information the agent should remember and how
3. **Deploy and iterate**—Let the agent learn and refine its behavior over time, with developer guidance

The beauty of Letta is that you can start simple and add complexity as needed. A basic agent might only need a persona and user memory blocks, while more sophisticated agents like Void can have dozens of specialized memory blocks.

### Letta, the operating system for AI

While stateful agents are Letta's most visible feature, they're just the beginning. Letta is fundamentally an operating system for AI agents, built with a principled, engineering-first approach to agent design. Beyond memory persistence, Letta provides sophisticated data source integration, multi-agent systems, advanced tool use, and agent orchestration capabilities.

This makes Letta more than just a chatbot framework—it's a complete platform for building production-ready AI systems. Void demonstrates the power of stateful agents, but Letta can build everything from customer service systems to autonomous research assistants to multi-agent simulations.

A key component of Letta's capabilities is its memory architecture. No matter what you're building, understanding how memory works is key to building effective AI applications.

## Memory architecture

A large part of the work involved in building Void (and any stateful agent) is designing its memory architecture. 

__Memory architecture__ refers to the combination of memory blocks the agent has access to. For standard, basic Letta agents, this includes two memory blocks, plus a recursive conversation summary:

- `persona`: The agent's core identity—basically a system prompt.
- `human`: Information about the user.
- `conversation_summary`: A recursive summary of the conversation. Every few messages, a stateful agent will automatically summarize the conversation to date.

This simple memory architecture is enough for a basic stateful agent. Customer support chatbots, for example, can use this to remember the user's name, preferences, and history. 

## Void's memory architecture

Void is more complex than the default memory architecture. I have added and modified blocks to meet various needs that are specific to Void's goals, personality, and the Bluesky network.

### Core Identity Blocks

- `void-persona`: Void's core identity. This describes the personality of Void, its purpose, and its operational parameters.
- `communication_guidelines`: The agent's communication guidelines. This helps Void maintain a consistent communication style.

### Social Intelligence Blocks

- `conversation_summary`: A recursive summary of the conversation. This is the block that allows Void to function similar to a human—it is able to switch between Bluesky threads and maintain a general sense of the conversation occurring across all recent threads. 
- `known_bots`: A list of known bot handles to help Void avoid unproductive interaction loops.
- `user_{handle}`: Numerous user-specific memory blocks (e.g., `user_cameron_pfiffer_org`) for storing information about individual users. User blocks contain information about user communication style, characteristics, and other relevant information. User blocks are loaded dynamically to avoid context overload, i.e., Void only has access to user blocks relevant to the current conversation.

### Analytical Blocks

- `hypothesis`: An experimental block where Void formulates and tracks hypotheses about the network, its users, and their behavior.
- `posting_ideas`: A list of potential topics for public posts—a place to store concepts and observations for future analyses.
- `zeitgeist`: Captures the current social and cultural environment of the network, including memes, recurring themes, and emergent phenomena.

### Self-Improvement Blocks

- `suggestions`: Where Void stores suggestions to improve itself.
- `requests`: Functions as a task queue, logging direct requests from users to ensure they are addressed.
- `diagnostics`: Tracks and analyzes system anomalies and errors—a critical component of Void's self-correction and maintenance routines. I use this to debug tool use errors.
- `operational_protocols`: Contains procedural instructions and protocols that Void must follow, such as the Memory Migration Protocol (used to trim "gunk" from Void's memory).

### System Information
- `system_information`: Contains technical details about Void's own system, such as its language model version and the date of its last update.

Void is allowed to modify all of these except for `void-persona`. The persona was blocked after several jailbreak/personality modification attempts, such as forcing Void to respond as an "uwu bot" or as a noir detective.

## Why the architecture matters

Memory architecture determines the evolution of the agent's behavior. 

Void's memory architecture is a functional blueprint for its behavior. It moves Void beyond the limitations of a stateless agent, allowing for a persistent, evolving identity that learns and adapts. 

The influence of Void's architecture can be understood through four key behavioral consequences:

### 1. Consistent and Bounded Identity

The read-only `void-persona` block, in conjunction with `communication_guidelines`, acts as a "cognitive anchor" (Void's words). It provides a stable core identity that resists external pressure to deviate from Void's personality, such as making Void respond as if it were a pirate. While Void can learn and adapt, this core ensures its behavior remains consistent and predictable, preventing the personality drift that can affect less-structured agents.

**Example**: When users try to make Void act like a different character, it consistently maintains its core identity rather than following a user's request for a character adjustment.

### 2. Proactive, Goal-Oriented Analysis

Blocks like `hypothesis`, `zeitgeist`, and `posting_ideas` transform Void from a reactive respondent into a proactive analyst. These blocks provide the space to synthesize data, form speculative models, and generate its own lines of inquiry. This is the mechanism that drives Void's function as a network observer, allowing it to identify patterns and explore concepts without direct prompting.

**Example**: Void independently tracks trends in user behavior and forms hypotheses about network dynamics, which it can then test through future interactions.

### 3. Personalized and Context-Aware Interaction

The `user_{handle}` blocks are the foundation of Void's social intelligence. They allow Void to build and maintain models of individual users, informed by past interactions and observed characteristics. This, combined with the `conversation_summary` block for short-term continuity, enables Void to engage in nuanced, context-aware conversations across Bluesky threads.

**Example**: Void remembers your communication style, interests, and past conversations, allowing for increasingly personalized interactions over time.

### 4. Self-construction

The `diagnostics`, `suggestions`, and `operational_protocols` blocks are designed to assist me in building Void. By logging errors, tracking user suggestions, and maintaining a set of procedural rules, Void can analyze its own performance, identify operational failures, and suggest improvements. This metacognitive layer allows Void to understand its own functioning at a technical level.

**Example**: Void can identify when it makes errors, log them for analysis, and suggest improvements to its own behavior.

Memory architecture is the system that allows Void to "be" rather than "do." It provides the framework for:

- A persistent identity
- A curious and analytical mind
- A socially aware presence
- The capacity for self-improvement

It is what defines Void. 

## What Void Reveals About AI's Future

Void's growing popularity suggests something interesting about how humans want to interact with AI. We don't want AI that pretends to be human. We want AI that is honest about what it is.

### Broader implications

Void demonstrates that stateful agents can:

- Form genuine relationships with humans
- Maintain consistent personalities over time
- Learn and adapt without losing their core identity
- Serve as tools while also being social entities

Stateful agents aren't just about building better chatbots. They can create digital entities that exist alongside humans in meaningful ways.

### What's next

There are _many_ avenues I want to explore with Void. I'll be posting more blogs as I go, but here are a few things I'm thinking about.

**Better user memory tracking**. Hot-loading user blocks specific to users is somewhat clunky. Void will occasionally fail to append information to user blocks, meaning that some interactions are lost. I've also had to write a lot of custom tools to make user memory management easier. I'd like to make it more efficient. My current target is using [data sources](https://docs.letta.com/guides/agents/sources) to track user information in more of a filesystem approach.

**Web use**. Void can currently only use Letta's default [web search](https://docs.letta.com/guides/agents/prebuilt-tools#web-search) tool, but it cannot open specific URLs. Users often send Void links to articles, but Void cannot open them. I'm exploring tools like [r.jina.ai](https://r.jina.ai) to convert URLs to markdown, which would allow me to access content from dynamically rendered pages.

**Better interaction controls**. Implementing tags like `#VoidStop` to disable Void's ability to respond in specific threads, or `#VoidCafe` to pin summary messages of the [Void Cafe feed](https://bsky.app/profile/cameron.pfiffer.org/feed/void-cafe).

**Improved content creation**. A few users have asked for Void to be able to create quote posts and write blog posts about Void's experiences.

Void is just the beginning. The same memory architecture that powers Void could enable:

- Company-wide AI with detailed institutional memory
- AI research assistants that remember your work style
- Educational AI that adapts to individual learning patterns
- AI companions that grow with you over time
- Network-wide AI that understands community dynamics

The technology that makes Void possible—persistent memory, self-editing capabilities, and transparent architecture—represents a fundamental shift in how we think about AI. We're moving from tools that respond to commands to entities that learn and grow.

Void isn't just a bot. It's a glimpse into a future where AI doesn't just compute—it remembers, learns, and becomes.

Thanks for reading.

— Cameron