+++
title= "Models for production AI"
date= Date(2025,10,28)
rss = "Some general notes on the landscape of AI right now."
rss_pubdate = Date(2025,11,04)
hasmermaid= true
toc= true
+++

# Models for Production AI

A friend recently asked me a few questions about model selection, pricing, and the competitive landscape. I work at Letta, so my perspective is shaped by building stateful AI agents, but I figured these answers might be useful more broadly. Here's my unfiltered take on what actually matters when you're building production AI systems.

## Model Performance: What Actually Matters

### Which models perform best?

The answer depends on what you're optimizing for. There's no single "best" model. The paid models from Anthropic, OpenAI, and Google each have different strengths. Open-source and Chinese models exist, but for production work, they're not worth the effort yet.

### Anthropic: Best for Stateful Agents

Anthropic's models are the strongest choice if you're building stateful agents. They focus on agentic memory and post-train their models to use the `memory` tool for dynamically managing state. This isn't marketing. It's a real architectural advantage.

Their models understand that memory isn't just retrieval. It's about maintaining and updating persistent state across interactions. When your agent needs to remember user preferences, track ongoing conversations, or maintain context across sessions, Anthropic's models handle this more naturally than alternatives.

The practical difference shows up in how agents behave over time. An agent built on Anthropic's models will more reliably update its own memory blocks, recognize when information conflicts with what it already knows, and maintain coherent long-term context. In Letta Code ([github.com/letta-ai/letta-code](https://github.com/letta-ai/letta-code)), Sonnet 4.5 performs excellently for code generation with persistent memory.

### OpenAI: Best for Tool Calling

OpenAI models have the most reliable tool calling support. Better than Anthropic's in many cases. If you're building agents that need to execute actions consistently, this matters. The models are solid across the board. I'm less thrilled about the personality, but they do fine. If you already use OpenAI extensively, they're probably fine for your purposes.

Letta maintains benchmarks for different models on agentic context management at [leaderboard.letta.com](https://leaderboard.letta.com/).

## Lock-In? Design It Away

### How easy is it to switch models, and will that get easier or harder?

Lock-in shouldn't be a big risk if you design for it. The key is separating your agent's intelligence from model-specific behaviors. Letta was built to abstract the model away entirely. You can swap to any other model in five seconds, and much of your agent will perform similarly if it has a decently built state and memory architecture.

### What Makes Switching Easy

Your agent's intelligence should come from its memory architecture, not from being tightly coupled to a specific model's quirks. When you build on top of persistent memory blocks, switching providers becomes trivial. You're not rewriting prompt engineering hacks or restructuring your entire application. You're just pointing to a different API endpoint.

Concretely, this means:
- Store conversation history and context in structured memory, not in prompt templates
- Use tool schemas that work across providers rather than provider-specific formats
- Test your agent with multiple models during development to ensure portability
- Avoid relying on model-specific behaviors (like specific output formatting quirks)

### Getting Easier Over Time

This will only get easier as models improve and respond better to context. As model capabilities converge toward similar performance levels, the differentiation shifts from "which model is smartest" to "which model fits my cost/speed/reliability requirements for this specific task." Good architecture lets you make those trade-offs dynamically rather than being locked into decisions you made months ago.

The models themselves are becoming more similar in how they handle common patterns (tool calling, structured output, context management). This convergence makes switching less risky. The bigger risk is building your entire system around a specific model's quirks and then discovering you can't leave.

## Pricing: Build First, Optimize Later

### How do you think about token pricing and cost structure?

### Quality First

Many people don't particularly care about token costs. At least not in the way you'd expect. When you're building something genuinely useful with AI, you should optimize for quality first. Your engineering time costs more. Your opportunity cost of shipping slower costs more. The difference between building something valuable and building nothing matters far more than spending $50 versus $500 a month on API calls.

Letta does usage-based pricing where you're billed per *message*, not per token. The idea is to get people thinking in terms of agents rather than trying to optimize token consumption. The entire token-counting optimization game is a distraction from building something that actually works.

### When to Use Cheaper Models

There is a use case for smaller, cheaper models, but you have to be extremely specific about why you're using them. They aren't designed for high-power stateful agents.

Start with a powerful model while building your agent. Get it working. Then step down to progressively cheaper models until you find the performance threshold where things start breaking.

You'll learn what actually matters. Maybe your agent's creative reasoning needs Claude Opus, but its routine database queries work fine with Haiku. Maybe your customer support agent needs Sonnet for complex troubleshooting but can use Haiku for FAQ responses. Maybe your code review agent needs GPT-4 for architecture feedback but can use GPT-4 Mini for style checks. You can't know these trade-offs until you've built something that works first.

If you're particularly price sensitive, design using an evals framework from the get-go so you can systematically test different model tiers. Letta's eval framework is open source at [github.com/letta-ai/letta-evals](https://github.com/letta-ai/letta-evals).

### Non-Agent Use Cases

You can use cheaper models outside of agents entirely. Good use cases: content classification, sentiment analysis, data extraction. Any narrow task that needs speed over sophisticated reasoning.

### What Actually Matters

Beyond token cost, I don't look at any other pricing features significantly. Latency matters far more than marginal cost differences. Reliability matters even more than latency.

## Open Source Models: Getting Better, But Still Behind

### What's your view on open-source LLMs?

Open-source and open-weight models are getting better, but they're still primarily suited for hobbyist use cases rather than production deployments. Most people doing serious work in AI aren't using open-weight models for their core functionality. The projects built on open-weight models tend to be much smaller in scale.

### The Privacy Argument

The privacy argument deserves examination. Yes, if you're handling extremely sensitive data, running models on-premises might be necessary. But most companies invoking privacy concerns are either over-estimating their risk or under-estimating the operational burden of self-hosting.

The actual cost of running open-weight models at any meaningful scale (infrastructure, engineering time, reliability engineering, keeping up with model updates) almost always exceeds what you'd pay Anthropic or OpenAI for API access. And you get worse quality in the bargain.

### The Quality Gap

Current Chinese models and open-weight models are roughly on par with frontier models from 8-12 months ago. That's a decade in the AI world. I expect them to remain behind frontier models for the foreseeable future. The gap might narrow from 12 months to 6 months, but the gap will persist because the frontier labs have more resources, more data, and more ability to push the boundaries.

### The Speed Advantage

The big advantage of open-weight models is the companies that serve them: Groq, Cerebras, and SambaNova. These three companies have the fastest inference, and it is not close. If you want raw speed and are okay with tolerating lower-quality models, you have to go to the open-weight providers. OpenAI, Anthropic, and Google just can't compete on speed yet.

This speed advantage is real and meaningful. If you're building something where sub-second latency is more important than response quality (autocomplete, real-time suggestions, interactive experiences where users expect instant feedback), the speed tier providers become extremely attractive. A slightly worse answer delivered in 100ms is often better than the perfect answer delivered in 2 seconds. But know what you're trading off.

## The Real Trade-Offs

The AI landscape is moving fast, but the fundamental trade-offs remain consistent. You're choosing between quality, speed, cost, and interoperability. The trick is knowing which dimensions actually matter for your use case.

Most people are optimizing for the wrong things. They obsess over token counts, self-hosting complexity, and marginal cost differences. Meanwhile, they ignore what actually determines whether their AI project succeeds: building something that works, shipping it quickly, and iterating based on real usage.

Pick Anthropic if you're building stateful agents. Pick OpenAI if tool calling reliability is critical. Pick Groq/Cerebras/SambaNova if you need raw speed. Design for interoperability from day one so you can switch when requirements change. Start with quality, then optimize for cost once you understand what actually matters.

The models themselves are becoming commoditized. The differentiation is shifting to architecture, memory management, and how well you understand your specific requirements. Don't get locked into a provider because you built your entire system around their quirks. Build on top of persistent memory and structured state instead.

Most importantly: optimize for building something that works before you optimize for anything else. Engineering time is expensive. Opportunity cost is expensive. Model costs are cheap.

-- Cameron
