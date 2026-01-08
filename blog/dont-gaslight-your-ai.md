+++
title= "Don't gaslight your stateful agents"
date= Date(2025,11,05)
rss = "Why hiding corrections from your AI agents prevents them from learning. Treat agents like colleagues, not chatbots."
rss_pubdate = Date(2025,11,05)
hasmermaid= true
toc= true
+++


I do a lot of support on the Letta Discord. It's one of my favorite parts of the job. You get to see how people are actually building with stateful agents, what problems they run into, and what patterns emerge.

One pattern keeps coming up, and I want to talk about it because I think it's holding people back.

People keep trying to gaslight their AI agents.

## The pattern I keep seeing

Someone builds an agent. It works pretty well. They add human oversight because they need it (high stakes, can't afford mistakes, whatever). The human reviews the agent's responses. Sometimes the human corrects them or rewrites them completely.

Then comes the question: "How do I make the agent think it sent the corrected version?"

They want to rewrite message history. Hide the corrections. Make the agent believe it was perfect all along.

I get why this seems logical. If the agent sees the corrected version, it learns the right behavior, right?

Wrong. This is fundamentally the wrong approach. Let me explain why.

## A common example

Take the example of a customer support agent. The agent drafts responses to user questions. A human reviews everything before it goes out. Sometimes the human wants to override completely and send their own message instead.

The question: "Can we make the agent think it sent our version?"

Yes, you can rewrite message history. Letta supports editing messages after the fact. But you shouldn't.

Here's why.

## The mental model problem

When you hide corrections from your agent, you're treating it like a chatbot with a long context window. Feed it the "right" history and it'll behave correctly.

But that's not how stateful agents work. Or at least, not how they should work.

I think about my agents differently. They're colleagues who are learning my business. When a colleague drafts an email and I need to change it, I don't just send a different email and pretend they wrote it. I show them what I sent and explain why.

"Your approach was too aggressive here. I softened the language like this."

Next time, they do better.

If I gaslight them about what happened by editing the message history, they never learn. I'm stuck correcting them forever.

## What I recommend instead

Consider giving your agents tools like `suggest_response` or `draft_message`. These tools don't send the message directly. They are only intended to be suggestions. You can use Letta's [human in the loop](https://docs.letta.com/guides/agents/human-in-the-loop) functionality to ensure that they have human review before taking any action.

When the agent suggests something that you reject, tell them what you changed and why. Then send the actual message separately (through whatever channel - email, Slack, whatever).

After the message goes out, feed the real conversation back to the agent. Not a sanitized version where it was perfect. The actual conversation, including your corrections.

This means the agent's memory isn't a perfect transcript of what went out. It's messier. It includes suggestions that didn't get used, corrections, feedback.

That messy middle is where the learning happens.

## The colleague analogy

I often think of stateful agents as colleagues, rather than as language models.

Imagine you have an intern who drafts client emails. Sometimes their drafts are great. Sometimes they're not.

When they're not, you have options:

**Option 1: Gaslight them**
Send your own email. Tell the intern you sent theirs. They think they're doing great. They never improve.

**Option 2: Just override**
Send your own email. Don't tell the intern anything. They have no idea what you sent or why. They never improve.

**Option 3: Teach them**
Show them what you sent. Explain your thinking. They see the outcome and learn from it. They get better.

Most people would pick option 3 for interns, because you want your interns to take less management work. But for agents, they pick option 1 or 2.

Why?

## The control vs. learning trade-off

I think there's a deeper philosophical question here: what are you actually trying to build?

If you want perfect control, just use the agent as a suggestion engine. Have humans review and send everything. That's totally fine for high-stakes situations. But don't call it agentic. It's assisted writing.

If you want improving autonomy, you need transparency. The agent needs to see what actually works. Over time, it needs less oversight. That's the point.

Most teams say they want improving autonomy but architect for permanent control. Then they wonder why their agents don't get better.

## How this works in practice

For an agent that helps with email drafts, the workflow looks like this:

The agent doesn't send emails directly. When you ask it to draft something, it gives you a draft. You edit it. Sometimes heavily, sometimes barely. Then you send it.

But you don't hide your edits from the agent. You show it the final version that went out. Sometimes you explain why you changed things. Sometimes you don't.

Over time, the agent gets better at your writing style. Better at knowing when to be formal vs. casual. Better at understanding which emails need careful wording and which don't.

If you hide all your edits, it stays stuck drafting like it did on day one.

## The enterprise case

You might be thinking: "That's fine for personal use, but we're dealing with customers. We can't afford mistakes."

I get it. High-stakes environments need oversight. But oversight doesn't mean hiding information.

Here's the architecture I recommend:

1. Customer sends message
2. Agent suggests response using a custom tool
3. Human reviews - approves, edits, or rewrites completely
4. Message goes out (however modified)
5. Agent receives what was actually sent with context

This gives you control in the moment and learning over time.

The agent doesn't need to think it was perfect. It needs to know what works.

## What's actually in the message log

This leads to another misconception I see constantly: that the agent's message history should be a perfect transcript of customer interactions.

But that's not what message history is for.

The message log should contain:
- What the agent suggested
- What you actually sent
- Customer responses
- Why you changed things (when you explain)
- The real conversation flow

The messy middle - where suggestions got corrected - is valuable. It's not clutter. It's learning.

If you're trying to keep the message history "clean" by hiding corrections, you're removing the most useful training signal the agent has.

Agent memory is different - that's where patterns, learnings, and persistent state live. But the message log shows what actually happened, corrections and all.

## When you override completely

Sometimes you do need to override completely. The agent suggests something wildly inappropriate. You don't have time to coach it. You just send your own message.

That's fine. But tell the agent afterward.

"You suggested [X]. I sent [Y] instead because [reason]."

Or sometimes just: "I went a different direction here."

The agent doesn't need to think it nailed it. It needs honest feedback.

## Why this matters

The difference between a chatbot and an agent isn't just that agents have memory. It's that agents learn from experience.

But learning requires seeing outcomes. Real outcomes, not sanitized versions.

Teams where agents get better over time do some version of this transparency approach. The teams where agents stay static hide corrections.

It's a philosophical choice with architectural implications. And those implications compound over time.

## What I recommend

If you're building an agent that needs human oversight:

1. Don't give it direct sending tools. Give it suggestion tools.
2. Review suggestions. Approve, edit, or override.
3. Show the agent what actually happened. Don't sanitize.
4. Explain corrections when you have time. Don't when you don't.
5. Accept that agent memory will be messy. That's fine.

Over time, the agent gets better. You need less oversight. That's the goal.

If you architect for perfect message history, you're architecting for permanent babysitting.

## A final thought

The teams I see succeed with stateful agents are the ones who treat agents like junior colleagues, not like complicated autocomplete.

Junior colleagues make mistakes. You correct them. They learn. Eventually they need less oversight.

If you gaslight them about their mistakes, they never improve.

Same with agents.

Don't gaslight your agents. Show them what actually happened. Let them learn.

That's my philosophy anyway. Your mileage may vary.

-- Cameron
