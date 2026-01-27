+++
title= "A guide to getting started with Letta Code"
date= Date(2026,1,27)
rss = "Practical tips and tricks for the memory-first agent harness"
rss_pubdate = Date(2026,1,27)
toc= false
+++

# A guide to getting started with Letta Code

If you've just installed [Letta Code](https://docs.letta.com/letta-code), you're about to have a great time. You may be wondering how to get started with models, tools, and general development flow.

Installation:
```bash
npm install -g @letta-ai/letta-code
```

Here are some tips to use Letta effectively, as some things are different from other harnesses that you may also use (Claude Code, Codex, OpenCode, etc.)

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
You can also use this menu to select any agent in your organization by hitting tab twice (to the "All" tab). If you have an existing agent you want to find and pin, this is also how you would do that.
### Model selection
I typically recommend Opus 4.5, but this can be quite expensive. I usually use Opus to do the initial learning of a project (type `/init` in a new project) and then switch to something like Sonnet 4.5 or GLM 4.7. Gemini 3 is decent but I usually go to Opus if I'm going to use a premium model. I hate the GPT-5 series unless I'm using it for a roleplaying/personal agent.

Any time you want an agent to deeply understand something, go for Opus. If you have simple implementation tasks, GLM 4.7.

GLM 4.7 is free on the Letta API so I usually recommend it if you want a lot of milage.

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
If you are new, you should use the `/remember` command. This is a command with special prompting that you can use to have the agent remember a piece of content.

You can provide a specific thing to remember:
```
/remember to always use uv instead of pip
```
If you do not provide a specific thing (just `/remember`), the agent will do its best to understand what to remember from its current context.

**Memory defragmentation**
Agents can sometimes accumulate "gunk" or have poorly organized memory architecture. You can fix this by asking your agent to use the [memory](https://docs.letta.com/letta-code/subagents#memory) subagent, which will defragment your coding agent's memory.

You can ask the agent to invoke this in your request, like
```
Use a memory agent to clean up and reorganize my memory blocks
```
The agent should invoke the `Task` tool to invoke a subagent. You can also customize your request, such as asking the agent to get the memory agent to consolidate project information, remove contradictions, etc. You can also ask the agent to remember to use the memory agent regularly in certain circumstances, such as after a pull request is submitted.

### Skills
[Skills](https://agentskills.io/) are packages of procedural memory that help an agent how to perform a specialized task. In Letta Code, we typically recommend building or using existing skills to help your agent. Skills are significantly more flexible and powerful than Letta's built-in server-side tools.

I recommend skills over custom server-side tools when using Letta Code agents.

The quick way to get a skill is to ask the agent to make one! We're big skill people here at Letta, and focus on continual learning of skills.

Your agent can [create skills](https://docs.letta.com/letta-code/skills) directly through the `/skill` command:
```
/skill # No prompt provided, agent will guess
/skill create a skill to handle database migrations
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
- GLM 4.7 for simple stuff. Opus for big stuff.
- Keep your skills up to date. Every time you notice your agent solve a problem, ask it to update or create a new skill. Make sure it learns.
