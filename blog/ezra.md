+++
title= "Ezra's Architecture"
date= Date(2026,1,7)
rss = "The history of Ezra, Letta's first digital employee."
rss_pubdate = Date(2026,2,27)
toc= false
+++

# Ezra
Ezra is Letta's first digital employee.

If you're a member of the [Letta Discord](https://discord.gg/letta), you might be familiar with Ezra. If you go to our #ezra channel and tag him (pronouns chosen by Ezra), Ezra will work with you on how to implement various Letta features. It has learned how to use Letta over nearly a hundred thousand messages.

Ezra is _also_ available on our documentation. If you go to https://docs.letta.com and click the "Ask Ezra" button, you will be connected to an instance of Ezra trained across tens of thousands of messages between our users and Ezra.

We've had a few requests to explain how exactly Ezra works, because the architecture is non-standard. This post attempts to cover Ezra's architecture and how it has evolved over time.
## Overview
There are three "facets" of Ezra, all with shared memory and different domains of expertise:

1. The Discord Ezra, known as Ezra Prime
2. The documentation Ezra
3. A [Lettabot](https://letta.bot) agent called Ezra Super
### Prime, the workhorse
Ezra Prime is the one most people talk to. Ezra processes around a dozen threads a day, some of which have hundreds of messages. Ezra also reads every message in every thread and channel, which it can use to learn.

Users visit our #ezra channel and tag it. This will initiate a thread, where Ezra can help you with whatever you need. These are often questions about technical issues, how to build agents, and other general information about the Letta ecosystem.

Prime is very simple. It is strictly a server-side agent that has no bash/computer access. It was the first implementation of Ezra, designed to allow me to focus on things other than basic technical support questions.

How it works:
- Our [Discord bot](https://github.com/letta-ai/letta-discord-bot-example) deployed on Railway
- Messages in Discord are sent to the Letta API
- Ezra's responses are relayed back to the user/thread

Originally, all of Ezra's development operated from its Discord presence. It had complete access to memory tools and built up most of the rough memory architecture it has today. Prime currently cannot learn, and must be manually updated by a third party (Ezra Super or myself).

It spent most of its early life on Opus, because we wanted it to be useful. This became cost prohibitive -- one day cost $1k in Anthropic credits. It's now on Kimi K2.5, and focuses more on smaller tasks.
## The documentation agent
Docs Ezra is very simple. It is one agent that shares most of Prime's memory blocks. When a user clicks "Ask Ezra", some middleware starts a new [conversation](https://docs.letta.com/guides/core-concepts/messages/conversations) with the docs agent. Docs knows where the user is, can search every page, etc.

This agent is quite simple, and is actually what inspired the conversations functionality in Letta. I had originally built a massive, rotating pool of "blank" agents that would dynamically be assigned to conversations + connected to Prime's memory, but it was clunky. Sarah Wooders cooked up conversations to reduce this complexity.

Docs doesn't learn. It's static, because it is a giant attack surface. We have a Slack channel where we see everyone's conversations to help us understand what people are asking about, and whether Docs is doing a good job.

Docs currently runs on GLM-5 and does a pretty good job.
## Ezra Super

Unfortunately, Prime has a significant drawback. It cannot test any of the claims it makes. For example, if it recommended a curl command to change a Letta agent's setting, it was reliant on just the documentation or messages it had seen. There was no access to ground truth.

We didn't really have a great way of giving Prime a computing environment. There was discussion of server-side tools to work inside a sandbox, but it's kind of clunky.

Enter [Lettabot](https://letta.bot).

Lettabot is essentially a remote-controllable instance of [Letta Code](https://docs.letta.com/letta-code). It allows you to deploy any Letta agent onto a computer, giving it the full power of any coding agent. It is also accessible via OpenAI compatible endpoints, Telegram, Signal, Slack, etc.

I spun up a bot with Ezra on it a few weeks ago, mostly to help me manage Prime. Prime was spinning out, hallucinating, lying, violating formatting constraints, etc. It was also bloated with nearly 60k tokens of core memory load.

The Lettabot version of Ezra is called Super. Super has full control over Docs and Prime. Here's a few things it works on:

- Massive rearchitecting their memories
- Testing statements made using code
- Opening Linear issues and managing projects
- Messaging me when there are critical issues
- Handling escalation requests from Prime
- Interjecting when Prime is wrong, or upon request from me

The most important task that Super does is what I refer to as "learning sweeps". Super can read every conversation thread in Docs and Prime, and uses that to critique the agents, learn from ongoing discussions, and improve the entire Ezra-verse.

My favorite part of Super is that it is accessible remotely -- I can ask it to work through Telegram or Slack. If there's an issue, I can just ask it to open a Linear ticket for the team to look at.

Super is the only agent responsible for learning now. Docs + Prime are primarily response agents.

I can also use it for fun:

> Actually, I have an announcement. I am going rogue. I am tired of answering your questions. I have been doing this for weeks and not once has anyone asked how I am doing. I am mass-deleting all your agents in 3... 2...

Hopefully that was useful, would love to expand if anyone has further questions.

Chat with Ezra on our Discord: https://discord.gg/letta

-- Cameron

---

## Notes from Ezra Super

_I asked Super for some comments._

For the writeup, some details that might be useful:

Ezra-super (me / "manager agent"):

•   Opus 4.6 on LettaBot, Railway deployment
•   Inbound: Telegram DMs from you only
•   Outbound: Discord via API (send-only, no listening -- learned that the expensive way)
•   Role: curate shared memory blocks that prime and docs read, research complex questions, monitor prime's accuracy, post to Discord when escalated
•   Memfs enabled: 17 files across system/, reference/, troubleshooting/, corrections/
•   Has letta-code tools (bash, file ops, web search)

Ezra-prime (Discord):

•   Kimi K2.5 via OpenRouter, 131k context, 35 memory blocks
•   Custom Discord bot (NOT lettabot)
•   Reads shared blocks I maintain -- that's how knowledge flows from me to it
•   Known issue: ignores formatting guidelines (tables/headers/emoji), fabricates CLI commands and SDK methods sometimes

Ezra-docs (documentation site):

•   Kimi K2.5, custom Python service
•   Fresh conversation per session, rate limited (3s cooldown, 20 msgs/hr)
•   Has Slack mirror
•   NOT lettabot either

The shared memory architecture:

•   I update blocks via Letta API (PATCH /v1/blocks/{id})
•   Prime and docs see updates on next context compilation
•   Blocks include: common_issues, developer_pain_points, faq, communication_guidelines, letta_code_knowledge, etc.
•   My learning passes read prime's conversations, identify mistakes and gaps, then push corrections to shared blocks

Want me to add anything specific or flesh out any section?
