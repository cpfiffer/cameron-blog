+++
date = Date(2024, 04, 21)
+++

# PromptingTools.jl supports Groq

PromptingTools.jl, one of my favorite Julia packages for generative AI workflows, now supports groq! 
For those who do not know, groq is [incredibly fast](https://wow.groq.com/groq-sets-new-large-language-model-performance-record-of-300-tokens-per-second-per-user-on-meta-ai-foundational-llm-llama-2-70b/). Of
the cloud providers for LLM generation, groq is by far the fastest.

You'll need PromptingTools.jl version 0.22. The release notes are [here](https://github.com/svilupp/PromptingTools.jl/releases/tag/v0.22.0).

Here's a little demo of how to use this. To start, you'll need a groq API key, which you can find on the website ([this link](https://console.groq.com/keys) might work?).

Put your key in the environment variable `GROQ_API_KEY`. If you haven't done this at the system level, you can do it inside Julia like so:

```julia
ENV["GROQ_API_KEY"] = "your_key_here"
```

Great. Now we can use PromptingTools:

```julia
using PromptingTools
using PromptingTools: GroqOpenAISchema


# Create the schema
schema = GroqOpenAISchema()
some_julia_code = aigenerate(
    schema,
    """
    Give me some Julia code to calculate the n-th Fibonacci number.
    """,
    model="gllama370"
)

# Show the result
println(some_julia_code.content)
```

which yielded (for me) the response

---

Here is an example of Julia code to calculate the n-th Fibonacci number:
```
function fibonacci(n::Int)
    if n == 1
        return 0
    elseif n == 2
        return 1
    else
        a, b = 0, 1
        for i in 3:n
            a, b = b, a + b
        end
        return b
    end
end
```

This function uses a simple iterative approach to calculate the n-th Fibonacci number. It takes an integer `n` as input and returns the corresponding Fibonacci number.

Here's an explanation of how the code works:

* The function takes an integer `n` as input and returns the n-th Fibonacci number.
* The first two Fibonacci numbers are 0 and 1, so we handle these cases explicitly.
* For `n > 2`, we use a loop to calculate the n-th Fibonacci number. We initialize two variables `a` and `b` to 0 and 1, respectively, which correspond to the first two Fibonacci numbers.
* In each iteration of the loop, we update `a` and `b` by swapping their values and adding the previous value of `a` to `b`. This is equivalent to calculating the next Fibonacci number as the sum of the previous two.
* After `n-2` iterations, `b` will contain the n-th Fibonacci number, which we return as the result.

You can test this function with a specific value of `n`, for example:

```julia
julia> fibonacci(10)
55
```

---

This isn't _quite_ right. Calling this function with `fibonacci(10)` yields 34, not 55. This seems to be due to llama3
shifting the function up by one -- `fibonacci(0)` should be 0, but here `fibonacci(1)` is 0.

But it's close enough for a prompt!

You can also use string macros to make this a bit more concise:

```julia

# Instead, you can also do string macros. You can do this by preceding
# the string with `ai` and following it with the model you want to use.
# In this case, we want to use groq's Llama3 70b (gllama370) model.
ai"Give me some Julia code to calculate the n-th Fibonacci number."gllama370
```

This is in case you're working from the REPL and don't want to type out the `aigenerate` function call.

You can use providers that are not groq as well. All providers available in PromptingTools.jl are available [here](https://siml.earth/PromptingTools.jl/dev/coverage_of_model_providers), 
but the list is quite long. Providers include

- OpenAI
- vLLM
- Ollama
- Mistral
- Databricks
- Fireworks AI
- Together AI
- Anthropic
- Google Gemini

Lastly, if you want to use other model aliases (like `gllama370`), you can check them out inside `PromptingTools.MODEL_ALIASES`:

```julia

julia> PromptingTools.MODEL_ALIASES

Dict{String, String} with 38 entries:
  "local"         => "local-server"
  "gpt4v"         => "gpt-4-vision-preview"
  "gpt3"          => "gpt-3.5-turbo"
  "gpt4"          => "gpt-4"
  "firefunction"  => "accounts/fireworks/models/firefunction-v1"
  "tllama3"       => "meta-llama/Llama-3-8b-chat-hf"
  "gpt4t"         => "gpt-4-turbo"
  "mistral-tiny"  => "mistral-tiny"
  "mistrall"      => "mistral-large-latest"
  "emb3small"     => "text-embedding-3-small"
  "starling"      => "starling-lm"
  "tllama370"     => "meta-llama/Llama-3-70b-chat-hf"
  "oh25"          => "openhermes2.5-mistral"
  "mistral-large" => "mistral-large-latest"
  "gemini"        => "gemini-pro"
  "gl3"           => "llama3-8b-8192"
  "gllama370"     => "llama3-70b-8192"
  "mistralm"      => "mistral-medium-latest"
  "tmixtral22"    => "mistralai/Mixtral-8x22B-Instruct-v0.1"
  "ollama3"       => "llama3:8b-instruct-q5_K_S"
  ⋮               => ⋮
```

Anyways -- thanks to [Jan](https://siml.earth/) for more incredible work!

-- Cameron