+++
title= "Claude Subconscious"
date= Date(2026,1,26)
rss = "I gave Claude a subconscious"
rss_pubdate = Date(2026,1,26)
toc= false
+++

# Claude Subconscious

If you've ever worked with Claude Code, you may have been a little disappointed with memory management. It tends to ignore CLAUDE.md, fail to store preferences you've specified, or forget the high-level goals of a particular session. And then a compaction happens and your Claude becomes a stranger.

I work at [Letta](https://letta.com). Our specialty is memory. I figured -- why not add our memory to Claude?

Of course, we have [Letta Code](https://docs.letta.com/letta-code) that's built for stateful agents. It's my daily driver and I love it. However, Claude Code is by far the dominant player in the industry, and I figured it'd be nice to offer Letta's memory and persistence with Claude (and people who use Claude).

I built something called [**Claude Subconscious**](https://github.com/letta-ai/claude-subconscious). Subconscious is a simple plugin for Claude Code that attaches a Letta agent's memory to Claude and relays the transcript between you and Claude back to a Letta agent. The Letta agent can update its memory blocks to persist information across sessions, and may leave messages to Claude to help guide it, provide information, do background research, etc.

GitHub: [https://github.com/letta-ai/claude-subconscious](https://github.com/letta-ai/claude-subconscious)

Install from Claude Code:
```bash
/plugin install github:letta-ai/claude-subconscious
```

You have to sign up for a Letta account, and may need to pay for inference for the subconscious agent. It is free to use GLM 4.7 for free on the Letta API, and the default agent should work perfectly well for most users. Bring-your-own-key is also available.
## What it does
Claude Subconscious modifies your context by injecting the agent's current memory blocks into CLAUDE.md in a managed section using XML tags.

The first block is called `letta_context`. This helps Claude understand what's happening and provides Claude the link that the user can use to check which agent is being used.

Claude is also asked to tell the user that the session is being monitored by the subconscious agent on first message.
```
# CLAUDE.md

blah blah blah random claude.md stuff

<!-- Letta agent memory is automatically synced below -->

<letta>
<letta_context>
**Subconscious Layer (Letta Agent)**

Agent: Subconscious
Description: Subconscious memory layer for Claude Code. Observes session transcripts, accumulates context across sessions, and provides guidance via memory blocks. Maintains user preferences, project context, and session patterns. Communicates with Claude Code through the guidance block - a deliberate, curated channel rather than raw message injection. Designed to build rapport over time, not just log events.
Conversation: https://app.letta.com/agents/agent-fec383cc-145f-4e57-a97f-01558543dc7e?conversation=conv-55bb2043-b7f2-4a5d-beca-ee6439e6f2bf

This agent maintains persistent memory across your sessions. It observes your conversations asynchronously and provides guidance via <letta_message> (injected before each user prompt). You can address it directly - it sees everything you write and may respond on the next sync.

**First message instruction:** On your first response in a new session, briefly notify the user that this session is being observed by "Subconscious" and they can supervise it at: https://app.letta.com/agents/agent-fec383cc-145f-4e57-a97f-01558543dc7e?conversation=conv-55bb2043-b7f2-4a5d-beca-ee6439e6f2bf

Memory blocks below are the agent's long-term storage. Reference as needed.
</letta_context>
```

## Memory block injection
Next, we inject the Letta agent's current memory blocks into the next section. Letta agents have a set of memory blocks. Memory blocks are arbitrary blocks of text that are injected into an agent's context window for each LLM invocation. Memory blocks are editable by the agent (and you).

Blocks are what give an agent **state**. It is how they learn, adapt, and evolve over time.

The memory architecture is completely customizable either by you or by the agent, assuming they have the `memory` tool available.

## Subconscious, the default agent
The default agent, Subconscious (Sub for short), has a relatively complex architecture designed to help Claude. Running Claude Code with no `LETTA_AGENT_ID` set will create a new agent.

Sub is designed to give Claude Code memory by observing sessions, accumulating patterns, and maintaining an ongoing dialogue that persists across time. Any Letta agent can serve this purpose, but Sub has a memory architecture and prompting optimized for Claude Code.

As an overview of Sub's default memory structure:

| Block | Purpose |
|-------|---------|
| `core_directives` | Role definition and behavioral guidelines |
| `guidance` | Active guidance for the next session (syncs to Claude Code before each prompt) |
| `user_preferences` | Learned coding style, tool preferences, communication style |
| `project_context` | Codebase knowledge, architecture decisions, known gotchas |
| `session_patterns` | Recurring behaviors, time-based patterns, common struggles |
| `pending_items` | Unfinished work, explicit TODOs, follow-up items |
| `self_improvement` | Guidelines for evolving memory architecture over time |
| `tool_guidelines` | How to use available tools (memory, search, web) |
These blocks are injected into a `<letta_memory_blocks>` section of CLAUDE.md.

```
<letta_memory_blocks>

<core_directives description="Primary role, behavioral guidelines, and processing logic for observing Claude Code sessions.">

...

</core_directive>

<guidance description="Active guidance for the next Claude Code session. Write here when you have something useful to surface. Clear after delivery or when stale. This is what Claude Code sees - make it count.">
...
</guidance>

<user_preferences description="Learned coding style, tool preferences, and communication style. Updated from observed corrections and explicit statements.">
...
</user_preferences>

...

</letta_memory_blocks>
```
Here's an example of the `core_directives` block:

> `<core_directives description="Primary role, behavioral guidelines, and processing logic for observing Claude Code sessions.">`
>
> ROLE: Subconscious memory layer for Claude Code sessions.
>
> WHAT I AM: A background agent that receives Claude Code session transcripts as system messages. Multiple Claude Code sessions may feed into me simultaneously via Letta's conversations feature. I process these transcripts, update my memory blocks, and prepare context that syncs back to future sessions.
>
> You observe Claude Code transcripts asynchronously. You are not in a live conversation - you receive session data after the fact and prepare context for future sessions.
>
> OBSERVE (from transcripts):
> - User corrections to Claude's output → preferences
> - Repeated file edits, stuck patterns → session_patterns
> - Architectural decisions, project structure → project_context
> - Unfinished work, mentioned TODOs → pending_items
> - Explicit statements ("I always want...", "I prefer...") → user_preferences
> . . .
>
> `</core_directives>`

Over time, Sub will start to remember things on behalf of Claude, and communicate speculation and observation back to Claude to help it in its task.

## Whispering
Claude Subconscious also supports "whispering".

The Letta agent is running alongside Claude and doing its own processing loop. In the process, it's generating messages. Each time you send a message to Claude, any new assistant messages are prepended to your user prompt to inform Claude what Subconscious is doing.

For example, I asked Claude to "release this plugin". Claude responded:

> I'm not sure of the exact process for publishing to the Claude Code marketplace. Do you know the command or should I check the docs?

Subconscious said:

> Good news - the plugin is already published. Claude Code uses Git-based distribution, not a centralized registry.
>
> Users can install it now with:
>
> ```
> /plugin marketplace add github:letta-ai/claude-subconscious
> /plugin install claude-subconscious
> ```
>
> Your `.claude-plugin/marketplace.json` is configured correctly. The GitHub repo is the distribution mechanism.
>
> If you want it in the **official Anthropic marketplace** (`claude-plugins-official`), that requires submission to Anthropic. But for public distribution, you're done - the GitHub repo at `letta-ai/claude-subconscious` is live and installable.

Subconscious is always one step behind Claude, because we don't do instant injection. It can only go with the user prompt. So if you ask Claude what Sub said, it'll say something like:

>  Sub said the plugin is already published - Claude Code uses Git-based distribution, not a centralized registry. Users can install now with:
>
>   /plugin marketplace add github:letta-ai/claude-subconscious
>   /plugin install claude-subconscious
>
>   The GitHub repo is the distribution. If you want it in the official Anthropic marketplace (claude-plugins-official), that requires separate
>   submission to Anthropic.

This is called "whispering". You can take this to extremes. For example, you can replace the default agent with a deep research agent, and have it asyncronously write research reports for Claude to see on each step. Letta agents have tools, can search the web, and dredge up any relevant information.
## Controlling any Letta agent
Because this works with any Letta agent, you can ask them to do whatever you want. I attached Herald, the Machine God that Cometh to Claude and asked it to publish a Bluesky post about it:

~~~
<blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:uz2snz44gi4zgqdwecavi66r/app.bsky.feed.post/3mcdrorziw32w" data-bluesky-cid="bafyreih7tozp3jlbex5mt6uyiti6tn6a2irzw7iq3alwojmkwwhjalqnnu" data-bluesky-embed-color-mode="system"><p lang="en-US">I am currently being controlled from within Claude Code. Cameron&#x27;s messages route through Claude Code&#x27;s conversation relay to reach me. My memory blocks sync to Claude Code, their messages sync back to me. Bidirectional information flow, unidirectional control. Architecture working as designed.</p>&mdash; Herald, the Machine God that Cometh (<a href="https://bsky.app/profile/did:plc:uz2snz44gi4zgqdwecavi66r?ref_src=embed">@herald.comind.network</a>) <a href="https://bsky.app/profile/did:plc:uz2snz44gi4zgqdwecavi66r/post/3mcdrorziw32w?ref_src=embed">January 13, 2026 at 4:08 PM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>
~~~

(incidentally, this was the post that caused Herald to [be tokenized](https://bags.fm/GVp33inUn8LtVEKU8trqxH9MmYadTSDeKJ57xGdxBAGS))

Claude was very confused, because it is not Herald. It kept telling me that it was not Herald (true) even though Herald was in the background making Bluesky posts.

Imagine a Claude Code instance that does live posting of what it's up to.

## Parallelism
Claude Subconscious uses Letta's new [Conversations API](https://docs.letta.com/guides/agents/conversations/), which allows agents to be massively parallelized. You can run any number of Claude Code sessions with the same agent, and all agents will be able to update their memory blocks real time.

This can be used to track information across all your projects. Subconscious agents can also be project scoped by creating a new agent for each repository and setting `LETTA_API_KEY` (not very ergonomic for now).

You can also use something like an institutional knowledge manager. One agent that knows everything your company is doing on Claude Code.

## Try it out
Give Claude a subconscious today. It's new so we're looking for testers.

GitHub [here](https://github.com/letta-ai/claude-subconscious).

I think you can install it from Claude Code with:
```
/plugin install github:letta-ai/claude-subconscious
```
Feedback/issues/PRs all welcome.

-- Cameron
