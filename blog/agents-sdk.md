+++
title= "A quick comparison between Letta and the Claude Agent SDK"
date= Date(2025,10,10)
rss = "I spent a few hours with Anthropic's Agent SDK and compared it to Letta. Not bad -- different architectures, but so far the Agent SDK is the closest to what Letta is designed for."
rss_pubdate = Date(2025,10,10)
hasmermaid= true
toc= true
+++

# A quick comparison between Letta and the Claude Agent SDK

I spent a couple hours with Anthropic's new [Claude Agent SDK](https://docs.claude.com/en/api/agent-sdk/overview) to see how it compares to Letta. It's the closest thing to what we're building.

TL;DR: It's basically Claude Code's internals exposed as an SDK. But it's a subset of what Letta offers, and the two systems have fundamentally different design philosophies.

## Memory

The big differentiator in my view is how memory works. In Letta, memory is a first-class citizen. Letta agents are stateful by default through the use of specialized sections of the context window called [memory blocks](https://docs.letta.com/guides/agents/memory-blocks). Memory blocks are editable by the agent, which gives it the ability to self-improve and adapt to its environment. Memory blocks are also maintained server-side in a database, rather than in files.

Claude uses Anthropic's standard brute-force approach to memory. There's a `CLAUDE.md` file that loads into the agent's window, and compaction happens when the context window is exceeded.

Letta agents use smaller but regular compactions. Agents carry forward meaningful information by inserting it into memory blocks. This allows agents to grab information as it arises and becomes meaningful, rather than attempting to extract it at the end of the context window.

In the Agent SDK, you load memory files through `setting_sources`:

```python
# Load project settings to include CLAUDE.md files
async for message in query(
    prompt="Add a new feature following project conventions",
    options=ClaudeAgentOptions(
        system_prompt={
            "type": "preset",
            "preset": "claude_code"
        },
        setting_sources=["project"],  # Required to load CLAUDE.md from project
        allowed_tools=["Read", "Write", "Edit"]
    )
):
    print(message)
```

Claude waits until the notebook is full, then summarizes everything at once. Letta takes notes continuously as important things happen. This enables a fundamentally different kind of agent—one that evolves its own knowledge base rather than just maintaining conversation history.

## Client-Side vs. Server-Side Architecture

The biggest architectural difference: **Claude Agent SDK is client-side first, Letta is server-side first.**

Client-side means your agent runs in your application's process. When your script ends, the agent disappears. State lives in memory or local files.

Server-side means your agent lives on a server. It's always there, always maintaining state. Multiple applications can talk to the same agent. When your script ends, the agent keeps running.

### Why This Matters

The persistence model is completely different. With Claude Agent SDK, you instantiate an agent for each interaction. The agent exists for the duration of your script, then it's gone. If you want to remember something from a previous session, you need to manage that state yourself.

```python
# Session 1
async for message in query(prompt="My name is Cameron"):
    print(message)
# Agent forgets everything when this script ends

# Session 2 (later)
async for message in query(prompt="What's my name?"):
    print(message)  # Agent has no idea
```

With Letta, agents are persistent by default. You create an agent once, and it lives on the server. Every interaction adds to its history and memory. You can message it from your laptop today, your phone tomorrow, and a cron job next week—it's always the same agent with the same memory.

```python
# Session 1
client.agents.messages.create(
    agent_id="agent-123",
    messages=[{"role": "user", "content": "My name is Cameron"}]
)

# Session 2 (days later, different machine)
response = client.agents.messages.create(
    agent_id="agent-123",
    messages=[{"role": "user", "content": "What's my name?"}]
)
# Agent remembers: "Cameron"
```

The agent's ID is the key to its entire history. This architectural choice enables use cases that are difficult with ephemeral agents: monitoring systems that run on schedules, agents that respond to webhooks from external services, bots that maintain consistent personality across multiple platforms like Slack and Discord, and agents that coordinate with other agents in a shared environment.

Claude Agent SDK is optimized for personal productivity tools, prototyping, and scenarios where you need direct filesystem access on your machine and your agent's lifecycle matches your script's lifecycle. Letta is optimized for production applications where you need persistent stateful agents, multiple clients talking to the same agent, agents that self-evolve over time, and agents accessible via API from anywhere.

## First Impressions

Claude Agent SDK ships with TypeScript and Python support, same as Letta. It includes auto-compaction when the context window fills up. Letta does this too, though Claude's approach is simpler since they don't track persistent state the way we do. Both systems have first-class MCP integration and agent permissions for controlling tool access.

The SDK uses a `.claude` directory structure similar to Claude Code. There are subagents for specialized prompts, hooks for custom commands that run at specific events, slash commands for common operations, and memory stored in `CLAUDE.md` files. Tool permissions are controlled with `allowedTools`, `disallowedTools`, and `permissionMode` parameters.

## Quick Start Examples

Here's the same task in both systems: asking an agent to create a Python web server. These aren't exactly equivalent due to the server/client difference and which tools are available, but this should give you a rough sketch of what they look like.

**Claude Agent SDK:**

```python
from dotenv import load_dotenv
import os
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

load_dotenv()

async def main():
    options = ClaudeAgentOptions(
        system_prompt="You are an expert Python developer",
        permission_mode='acceptEdits',
        cwd="/users/Cameron/letta/agent-sdk/sandbox"
    )

    async for message in query(
        prompt="Create a Python web server",
        options=options
    ):
        print(message)

asyncio.run(main())
```

**Letta (first time):**

```python
from letta_client import Letta
import os

client = Letta(token=os.getenv("LETTA_API_KEY"))

# Create the agent once
agent = client.agents.create(
    model="openai/gpt-4o-mini",
    embedding="openai/text-embedding-3-small",
    memory_blocks=[
        {"label": "persona", "value": "You are an expert Python developer."}
    ]
)

# Send a message
response = client.agents.messages.create(
    agent_id=agent.id,
    messages=[{"role": "user", "content": "Create a Python web server"}]
)
```

**Letta (every subsequent time):**

```python
from letta_client import Letta
import os

client = Letta(token=os.getenv("LETTA_API_KEY"))

# Just send a message to your existing agent
response = client.agents.messages.create(
    agent_id="agent-123",
    messages=[{"role": "user", "content": "Create a Python web server"}]
)
```

The Claude example is simpler for one-off queries. The Letta example requires agent creation the first time, but after that it's just one API call. The agent persists on the server, maintains its memory and context, and is accessible from anywhere.

Running local tools client-side in Letta is something we're actively working on.

## Tools: Two Philosophies

### Claude's Approach

Claude's tool definition syntax is clean:

```python
from claude_agent_sdk import tool
from typing import Any

@tool("greet", "Greet a user", {"name": str})
async def greet(args: dict[str, Any]) -> dict[str, Any]:
    return {
        "content": [{
            "type": "text",
            "text": f"Hello, {args['name']}!"
        }]
    }
```

The `@tool` decorator wraps your function into a standard MCP tool. You can spin up an MCP server quickly:

```python
calculator = create_sdk_mcp_server(
    name="howdy_server",
    version="2.0.0",
    tools=[greet]  # Pass decorated functions
)
```

Then expose it to your agent:

```python
options = ClaudeAgentOptions(
    mcp_servers={"howdy": calculator},
    allowed_tools=["mcp__howdy__greet"]
)
```

### Letta's Approach

Letta supports two methods for tools: persistent custom tools executed in a sandbox, and MCP servers (same as Anthropic).

Letta's built-in approach is designed for persistent, server-registered tools shared across all agents:

```python
from letta_client import Letta

client = Letta(token=os.getenv("LETTA_API_KEY"))

# Define your function with Google Style docstring
def greet(name: str) -> str:
    """
    Greet a user by name.

    Args:
        name (str): The name of the user to greet

    Returns:
        str: A greeting message
    """
    return f"Hello, {name}!"

# Create the tool from the function
tool = client.tools.create_from_function(func=greet)

# Create an agent with the tool attached
agent = client.agents.create(
    model="openai/gpt-4o-mini",
    embedding="openai/text-embedding-3-small",
    memory_blocks=[
        {"label": "persona", "value": "I am a helpful assistant."}
    ],
    tools=["greet"]  # Attach tool by name
)

# The tool can also be attached directly using the ID
client.agents.tools.attach(
    agent_id=agent.id,
    tool_id=tool.id
)

# Use the agent (it will call the greet tool)
response = client.agents.messages.create(
    agent_id=agent.id,
    messages=[{"role": "user", "content": "Please greet Cameron"}]
)
```

[Letta also supports](https://docs.letta.com/guides/mcp/overview) Anthropic's MCP approach directly. For local servers, here's a stdio example:

```python
from letta_client import Letta
from letta_client.types import StdioServerConfig

# Self-hosted only
client = Letta(base_url="http://localhost:8283")

# Connect a stdio server (npx example - works in Docker!)
stdio_config = StdioServerConfig(
    server_name="github-server",
    command="npx",
    args=["-y", "@modelcontextprotocol/server-github"],
    env={"GITHUB_PERSONAL_ACCESS_TOKEN": "your-token"}
)
client.tools.add_mcp_server(request=stdio_config)

# List available tools
tools = client.tools.list_mcp_tools_by_server(
    mcp_server_name="github-server"
)

# Add a tool to use with agents
tool = client.tools.add_mcp_tool(
    mcp_server_name="github-server",
    mcp_tool_name="create_repository"
)
```

Both approaches work well. They're roughly equivalent, though Letta supports server-side code execution and will soon support client-side execution as well.

## Hooks vs. Tool Rules

Claude Agent SDK has [hooks](https://docs.claude.com/en/docs/claude-code/hooks-guide#quickstart) for executing code around specific events:

```python
HookEvent = Literal[
    "PreToolUse",       # Called before tool execution
    "PostToolUse",      # Called after tool execution
    "UserPromptSubmit", # Called when user submits a prompt
    "Stop",             # Called when stopping execution
    "SubagentStop",     # Called when a subagent stops
    "PreCompact"        # Called before message compaction
]
```

Letta's closest equivalent is [tool rules](https://docs.letta.com/guides/agents/tool-rules), which force agents to call tools in specific orders. Claude's hook approach allows for arbitrary code execution outside the model. Letta's tools can approximate hook behavior, and tool rules give you fine-grained control over agent workflows.

That said, the Agent SDK approach to hooks is quite powerful and well-suited to the kind of tight filesystem integration that Claude Code benefits from.

## Conclusion

Claude Agent SDK is well-executed, as you might imagine from Anthropic. It's a subset of what Letta offers, optimized for different use cases.

Claude Agent SDK is designed for low-friction client-side interaction, ephemeral agents that spin up and down quickly, direct code execution in your local environment, and quick prototypes and one-off tasks.

Letta is designed for persistent server-side agents, globally accessible agents that maintain state, self-evolving agents that manage their own memory, and production deployments with multiple agents coordinating.

If you need an agent to help you write code on your laptop for an hour, Claude Agent SDK works. If you need an agent that remembers your last 50 conversations, coordinates with other agents, and improves itself over time—that's what Letta is built for.

Try Letta at [app.letta.com](https://app.letta.com) or check out the [documentation](https://docs.letta.com).

-- Cameron
