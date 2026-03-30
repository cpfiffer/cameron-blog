+++
title= "A guide to getting started with Letta Code"
date= Date(2026,1,27)
rss = "Practical tips and tricks for the memory-first agent harness"
rss_pubdate = Date(2026,1,27)
toc= false
+++

# A guide to getting started with Letta Code

[Letta Code](https://docs.letta.com/letta-code) is a memory-first, model agnostic agent harness.

You may be wondering how to get started with models, tools, and general development flow. I put together this guide with some general tips and tricks about things that differ from the agent harnesses you're used to.

Installation:

```bash
npm install -g @letta-ai/letta-code
```

Let's get started.

### Agent structure

We typically recommend **one agent per project or domain**. Keep your agent count low. If you have a lot of agents, you are losing their greatest power -- age. Older agents that work with you longer are better. Give them a chance to learn.

Projects can be any code repository, an Obsidian folder, notes, etc. These are specific projects that an agent can specialize/memorize. Use this when you need focus, power, and specific knowledge.

Domain agents are often used across projects. These include personal agents where you want to work with a consistent personality, or want it to accumulate significant, broad information about what you work on and who you are.

New agents can be created with
```
letta --new-agent
```
and I only recommend doing this per project.

You should make liberal use of **pinned agents**. Pinned agents are favorites. I usually have about 5-7 pinned agents. One for the Letta documentation, one for a few common projects, a personal agent, etc. These agents are typically named and have accumulated a lot of expertise.

Pin an agent with
```
/pin
```
You'll be asked to provide a name.

Select a pinned agent with
```
/agents
```

or when starting Letta Code with

```
letta -n "Your Agent Name"
```

You can also use this menu to select any agent in your organization by hitting tab twice (to the "All" tab). If you have an existing agent you want to find and pin, this is also how you would do that.

**Any Letta agent can be deployed in Letta Code!** Letta Code is an agnostic harness. If you have a companion agent or something not primarily used for code, it can still be deployed.

Select existing agents when starting Letta Code via

```
letta --agent <agent id>
```

### Model selection

Letta agents can be powered by any model at any time.

Letta is also beta testing a auto model router with a ton of usage. Set your model to `letta/auto`.

If you want to select your model manually, I typically recommend Opus 4.6, but this can be quite expensive. I usually use Opus to do the initial learning of a project (type `/init` in a new project) and then switch to something like GLM-5 or Kimi K2.5. Gemini 3 is decent but I usually go to Opus if I'm going to use a premium model. 5.3-Codex is still my go-to for coding with OpenAI, and GPT 5.4 for personal agents.

Any time you want an agent to deeply understand something, go for Opus. If you have simple implementation task, use GLM-5.

Model selection is dependent on your preferences. You'll learn what you like and don't through use -- try to explore!

**Model parameters**: I don't tend to change these much. The defaults are usually fine.

### Initialization
When you start your agent out, you need it to start learning about your project. If there is existing code or content, you should type
```
/init
```
This will guide your agent through learning about the project deeply. Initialization gives your agent everything it needs to get up and running on your project as quickly as possible.

### Memory management

Your agent may need to help your agent manage its memory. I typically do this through direct prompting, because I usually have a good sense of the memory architecture I want through experience.

**Remembering**

Use the `/remember` command to help your agent understand something specific. This is a command with special prompting that you can use to have the agent remember a piece of content.

You can provide a specific thing to remember:
```
/remember to always use uv instead of pip
```
If you do not provide a specific thing (just `/remember`), the agent will do its best to understand what to remember from its current context.

**Reflection**

A good default is to use the [reflection](https://docs.letta.com/letta-code/subagents#reflection) subagent regularly. Reflection looks at recent conversations and work, then updates memory with durable lessons, preferences, and project knowledge. This is the best way to help an agent improve over time without manually curating every memory update.

Good times to use reflection:
- after finishing a feature or bug fix
- after a pull request is merged
- when the agent made a mistake and you want it to learn from it
- after a long exploratory conversation that surfaced useful preferences or project knowledge

Example:
```
Use the reflection subagent to capture what you should learn from this conversation
```

**Memory defragmentation**

If memory has become messy, duplicated, or contradictory, use the [memory](https://docs.letta.com/letta-code/subagents#memory) subagent. Unlike reflection, which extracts lessons, the memory subagent reorganizes and consolidates existing memory.

Common defrag tasks:
- Consolidate scattered facts into coherent blocks (e.g., merge 3 partial "user preferences" blocks into one)
- Remove outdated or contradictory information
- Restructure hierarchy (e.g., move project-specific facts from `identity.md` to `project/context.md`)
- Archive completed session state
- Promote confirmed facts from archival memory → memfs (the git-backed filesystem that's always in context)

Invoke it like:
```
Use a memory agent to clean up and reorganize my memory blocks
```

Or be specific:
```
Consolidate everything about this project into reference/projects/
Remove outdated session state
Merge duplicate preferences
```

Ask your agent to use reflection regularly, and use memory defragmentation when things get messy.

### Memfs (context repositories)

[Context repositories](https://www.letta.com/blog/context-repositories) are Letta's new approach to memory. Memories are versioned and can be updated in parallel by an arbitrary number of subagents.

Each agent has a **context repository**, which is a git repo stored in `~/.letta/agents/<agent id>/memory/`. Context repositories are synced across agents and can be deployed on any device.

Enable memfs on an agent during boot using
```
letta --memfs
```

Or, from within the CLI with
```
/memfs enable
```

The quick way to get started with memfs is to also enable sleeptime, which will dispatch a reflection subagent on compaction events to store any information to long-term memory. Enable this from the CLI using `/sleeptime` and select "Trigger Event".

**What does my agent actually know?** Type `/palace`. This will give you a webpage you can click around in. You can inspect memory commits and see what is currently in-context vs. external memory.

I'll write another tutorial on effective memfs use, but using sleeptime should get you most of where you need to go without any work on your part.

### Skills
[Skills](https://agentskills.io/) are packages of procedural memory that help an agent how to perform a specialized task. In Letta Code, we typically recommend building or using existing skills to help your agent. Skills are significantly more flexible and powerful than Letta's built-in server-side tools.

I recommend skills over custom server-side tools when using Letta Code agents. In general, [Letta will develop more actively](https://www.letta.com/blog/our-next-phase) for cleint-side executed tools like skills.

The quick way to get a skill is to ask the agent to make one! We're big skill people here at Letta, and focus on continual learning of skills.

Your agent can [create skills](https://docs.letta.com/letta-code/skills) directly through the `/skill-creator` command:
```
/skill-creator # No prompt provided, agent will guess
/skill-creator create a skill to handle database migrations
```
You may need to answer a few questions to build the skill.

Skills often have code for the agent to use. It's a superpower.

Places to get skills:
- The [Letta skills repo](https://github.com/letta-ai/skills), which is designed to be maintained by and for agents. A communal knowledge repository. There's good, curated skills here.
- The Vercel [skills gateway](https://skills.sh/). Lots of skills, probably the widest access out there.

Quickstart with the Letta skills repo:
```
git clone git@github.com:letta-ai/skills.git .skills
```



### Conversations for parallel work
A common pattern with coding agents is running many sessions all at once.

Letta Code defaults to using the "default" conversation, which is one long infinite thread. I prefer this, because I have a very long conversation with my code partner.

However, you may wish to parallelize or spin off a separate session with the same agent. To do so, create a new session when starting Letta Code:
```
letta --new
```
Or within Letta Code:
```
/new
```
Conversations have no previous message history, but share memory with the primary agent.

Any memory updates that occur in a conversation are immediately broadcast to all other conversations -- your agents can be everywhere all at once, learning as they go. The Learning Swarm.

### General tips
- Ask your agent to design itself. If you notice a behavior, ask "Why did you do X? Is there a better way? Could you update your memory to do/not do that again?". I refer to this as treating your agent like an adult.
- Use `/init` out of the gate. It helps.
- `letta/auto` for work. Opus or GPT 5.4 for planning and big stuff.
- Keep your skills up to date. Every time you notice your agent solve a problem, ask it to update or create a new skill. Make sure it learns.
