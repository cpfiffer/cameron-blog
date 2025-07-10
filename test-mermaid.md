+++
title = "Test Mermaid Diagrams"
hasmermaid = true
+++

# Testing Mermaid Diagrams

This page tests Mermaid diagram rendering.

## Simple Flowchart

~~~
<div class="mermaid">
graph TD
    A[Start] --> B{Is it working?}
    B -->|Yes| C[Great!]
    B -->|No| D[Debug]
    D --> A
</div>
~~~

## Sequence Diagram

~~~
<div class="mermaid">
sequenceDiagram
    participant User
    participant Blog
    participant Mermaid
    User->>Blog: View page
    Blog->>Mermaid: Render diagram
    Mermaid->>Blog: Return SVG
    Blog->>User: Display diagram
</div>
~~~

## Pie Chart

~~~
<div class="mermaid">
pie title Languages Used
    "Julia" : 45
    "JavaScript" : 30
    "CSS" : 25
</div>
~~~