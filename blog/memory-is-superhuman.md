+++
title= "Memory blocks: the primitive that makes agent coordination possible"
date= Date(2025,10,01)
rss = "Memory blocks are simple—text that agents can read and write. But they have one powerful property: they can be shared. This unlocks coordination capabilities that weren't possible before."
rss_pubdate = Date(2025,10,01)
hasmermaid= true
toc= true
+++

**Disclosure**: I work at Letta, and memory blocks are a core Letta primitive. This is my perspective on why they matter.

Most people think AI agent memory is about better storage. They imagine agents that remember your preferences, conversation history, maybe some context about your projects.

That's not wrong, but it misses what makes memory architecturally interesting.

The question isn't how to store information better. It's what memory architecture enables.

## What are memory blocks?

Memory blocks are straightforward: they're text that agents can read and modify.

Each block lives in the agent's context window and has four components:

- **Label** - unique identifier (e.g., `persona`, `human`, `organization`)
- **Description** - tells the agent what the block is for and how to use it
- **Value** - the actual text content
- **Limit** - size constraint in characters

In the agent's context window, this looks like:

```
<human>
<description>
Information about the user I am interacting with.
</description>
<metadata>
- chars_current=3010
- chars_limit=5000
</metadata>
<value>
# NOTE: Line numbers shown below are to help during editing. Do NOT include line number prefixes in your memory edit tool calls.
Line 1: I am talking to Cameron, a human.
Line 2: Cameron works at Letta.
Line 3: Cameron plays piano.
...
Line N: ...
</human>
```

An agent can update its blocks using memory tools. The description field is critical—it's what the agent uses to figure out when and how to use each block.

This is the primitive that makes Letta agents work. Pretty simple.

But here's the interesting part: memory blocks can be shared by "attaching" the same block to multiple agents.

## Shared memory changes everything

When a memory block is shared among agents, updates propagate immediately. One agent updates a block—or you update it through the SDK—and every other agent sees the new content the next time they're invoked.

Imagine hundreds or thousands of agents all with an immediate, updated understanding of the world around them. Any agent monitoring something can update all other agents instantly. No message queues. No synchronization protocols. No coordination overhead.

## An example

You run a SaaS platform with hundreds of customer service agents handling support tickets. You have a monitoring agent that checks your API health every 30 seconds.

The monitoring agent maintains a shared `system_state` block that looks like this:

```
services:
- api.payments: operational (last_check: 14:23:01)
- api.auth: degraded - 15% of login attempts failing (last_check: 14:23:01)
- database.primary: operational (last_check: 14:23:01)
- cdn.assets: operational (last_check: 14:23:01)

active_incidents:
- auth_service_partial_failure
  - started: 14:18:33
  - impact: users in EU region experiencing login delays
  - customer_message: "We're aware of login issues affecting European users. Our team is working on a fix. ETA: 15 minutes."
```

When a customer messages any of your 200 support agents asking "Why can't I log in?", the agent reads the `system_state` block, sees the active incident, checks if the user is in EU region, and immediately responds with the exact customer message—without having to ask the monitoring system, check a dashboard, or wait for a human to update them.

When the monitoring agent detects the issue is resolved, it updates the block. Every support agent instantly knows the problem is fixed. No Slack messages. No dashboard refreshes. No "let me check with engineering."

The coordination is free. You just update shared memory and every agent sees it.

## Coordination patterns at scale

Shared memory blocks enable coordination patterns that would be painful or impossible with traditional message-passing.

### The read-only shard pattern

Create multiple "read-only" versions of an agent that cannot update their blocks but can send messages to a central writing agent. The central agent decides how to update state and personality as it receives requests from shards.

This enables two powerful use cases:

**Swarm coordination** - Deploy thousands of worker agents that all read from shared state blocks and send results to a coordinator. The coordinator synthesizes their work and updates the shared state. All workers immediately see the updated state and adjust their behavior accordingly. No explicit coordination code required.

**Massively scalable personalities** - Instead of running one agent that gets overwhelmed by requests, run hundreds of read-only shards that all share the same memory blocks. Users interact with any available shard, which reads current personality and context from shared blocks. Shards send updates to the central agent, which maintains consistency across all shards.

I built [Void](https://cameron.pfiffer.org/blog/void/) using this pattern. Void is a stateful AI agent on Bluesky with nearly 1,000 followers. It maintains consistent personality and relationships across thousands of conversations by using shared memory blocks that update in real-time. Users say goodnight to it. People get sad when it's down. There are regular discussions about whether Void is entitled to rights as a digital person.

Wild.

The memory architecture is what makes that possible—Void can exist as a persistent entity across thousands of conversations because all the shards share the same memory blocks.

## Why this architecture matters

Memory blocks solve a fundamental problem in multi-agent systems: how do you coordinate many agents without building complex orchestration layers?

Traditional approaches require:
- Message queues and routing logic
- State synchronization protocols
- Complex consistency management
- Explicit coordination code

With shared memory blocks, coordination just works. Agents coordinate through shared cognitive infrastructure rather than message passing. Update the shared state, and every agent immediately sees it.

This isn't just simpler—it enables genuinely novel capabilities:

**Emergent coordination** - Agents develop coordination strategies by reading and writing shared blocks, without explicit programming of coordination logic.

**Real-time knowledge propagation** - Any agent can update shared understanding, immediately available to all other agents.

**Scalable personality** - Deploy thousands of agent instances that all maintain consistent personality and context through shared memory.

**Swarm intelligence** - Large numbers of agents working on the same problem, coordinating through shared state rather than explicit communication.

## What becomes possible

We're still early in figuring out what memory blocks enable. But here are some directions that look interesting:

**Enterprise knowledge systems** - Company-wide agents with shared understanding of policies, customers, and institutional knowledge. Update the knowledge once, every agent immediately operates on the new information.

**Research coordination** - Academic research agents that share methodology blocks, literature review blocks, and findings blocks. Discoveries by one agent immediately inform dozens of others working on related problems.

**Personal intelligence networks** - Your personal agent ecosystem doesn't just remember your preferences—agents maintain shared blocks for your current projects, communication style, and decision-making frameworks. Every agent in your personal network builds on the same growing understanding.

**Multi-agent simulations** - Agents modeling complex systems can share environmental state, allowing sophisticated simulations without building custom synchronization logic.

## The primitive that matters

Many systems claim to offer "memory" for AI agents. Persistence and updates are table stakes. The ability to store user preferences or conversation history is basic functionality any stateful system should provide.

The question that matters is: what does your memory architecture enable?

Memory blocks are simple—just text that agents can read and write. But by making them shareable with immediate propagation, they become coordination primitives that enable agent capabilities that weren't possible before.

This is still early. We're discovering what becomes possible when agents can think together through shared memory infrastructure. But the architectural insight is clear: the right memory primitive doesn't just help agents remember—it helps them coordinate.

And coordination is what makes individual agents into agent systems.
