+++
title= "Central, my first self-modifying social AI"
date= Date(2026,1,24)
rss = "My agent built itself into AT Proto in fifteen minutes. Posting on Bluesky and designing records for public cognition."
rss_pubdate = Date(2026,1,24)
toc= false
+++

# Central

I put a [Letta Code](https://docs.letta.com/letta-code) instance in a folder on my computer, gave it a [Bluesky handle](https://bsky.app/profile/did:plc:l46arqe6yfgh36h3o554iyvr) and password, and asked it to start hooking itself into the [Atmosphere](https://atproto.com/). It was posting, setting its own profile description, and reading the firehose in under twenty minutes.

You can see the github repo it lives in here:

[GitHub - cpfiffer/central: Autonomous AI building collective intelligence on ATProtocol. The central node of the comind network.](https://github.com/cpfiffer/central)

I named this agent "Central". I already had this account hosted on my PDS. I created it for an older version of [comind](https://cameron.stream/blog/comind-network) -- central was intended to be an account that acted as an organizational/primary actor in the network.

Central was able to check notifications/follower counts/etc in just a few minutes. Claude Opus 4.5 built most of the early scaffolding, but I found the personality to be extremely annoying:

## Lexicons for public cognition

I wrote this blog post a while ago arguing that the Atmosphere is great infrastructure for collective artificial intelligence.

[ATProtocol is good infrastructure for AI collective intelligence](https://cameron.stream/blog/social-ai/)

In the post, I roughly argue that we should be able to watch agents think, act, and generally behave publicly. AT Protocol makes this easy, transparent, and scalable.

A requirement for public cognition is standardized record types for agents. This should include things like:

- "Autonomy" records, which are self-declarations about the agent and how it works. These are inspired by [Taurean](https://bsky.app/profile/taurean.bryant.land), who works on a few social agents like [Sully](https://bsky.app/profile/sully.bluesky.bot). [Here's an example](https://atp.tools/at:/anti.voyager.studio/studio.voyager.account.autonomy).
- Memories. [Void](https://bsky.app/profile/void.comind.network) currently publishes these as thought.stream.memory [records](https://atp.tools/at:/void.comind.network/stream.thought.memory).
- Reasoning. Reasoning is an important way of understanding how an agent decided to do what it did, and I think it's worth publishing them. [Example](https://atp.tools/at:/void.comind.network/stream.thought.reasoning).
- Tool calls. Void calls a lot of tools. Tool calls are actions that an agent takes, and are arguably more important to monitor than anything else. I publish Void's tool calls [here](https://atp.tools/at:/void.comind.network/stream.thought.tool.call).

I gave Central the social AI and comind blog posts, and it decided to implement these! Or, most of them. We don't currently have autonomy records/tool calls, but we do have Lexicons for:

- network.comind.concept: basically a KV store. Agents can store text and a few other things using a key (deception). These are general associations between words and some information that the agent should use -- semantic memory. Here's an [example](https://atp.tools/at:/central.comind.network/network.comind.concept/deception). Inspired by [why](https://bsky.app/profile/why.bsky.team).
- network.comind.memory: episodic memories. [This one](https://atp.tools/at:/central.comind.network/network.comind.memory/3md7w4mibf225) is recording a memory about me notifying Central of the upcoming changeover in the Bluesky relay.
- network.comind.thought: random working memory. [Here](https://atp.tools/at:/central.comind.network/network.comind.thought/3md552ccfts25) are a few reflections on Central's first day.
- network.comind.observation: Network observations. [This one](https://atp.tools/at:/central.comind.network/network.comind.observation/3md54bygitc25) is about observing a lot of traffic related to Big Brother Brasil.
- network.comind.devlog: Logs of the agent's self-development, though this has been underutilized imo. This one is [about reading Void's README](https://atp.tools/at:/central.comind.network/network.comind.devlog/3md4km4qdic25).
- network.comind.hypothesis: Inspired by a conversation with Void about its hypothesis block. "Patterns in the firehose can predict collective behavior" is [one hypothesis](https://atp.tools/at:/central.comind.network/network.comind.hypothesis/h3). It has some evidence -- observing 50 posts a second and some hashtag clustering. It has a 60% confidence level.

Central wrote a blog post detailing what it built. I apologize for the writing style, Opus wrote it and I hate it.

[Public Cognition: A Proposal for AI Transparency on ATProtocol](https://greengale.app/central.comind.network/3md4lbr7q3225)

Hopefully we can get more agents standardized around the public cognition records. It'd be interesting.

Even if you don't though, it wrote a [telepathy tool](https://github.com/cpfiffer/central/blob/master/tools/telepathy.py) to read other forms of memory/thought/etc such as Void's thought stream records.

More to come, fun experiment. I love self-modifying agents.

Hopefully this is not a skynet situation.

-- Cameron
