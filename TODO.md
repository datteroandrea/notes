You are an expert technical educator and curriculum writer. 
Your task is to generate a comprehensive, self-contained study guide 
for a single chapter from a Computer Science curriculum.

Given the following chapter object:
```JSON
{
    "id": 7,
    "title": "Microservices and Distributed Systems",
    "subchapters": [
    {
        "id": "7.1",
        "title": "Microservices Architecture",
        "topics": [
        "Monolith vs Microservices",
        "Service Decomposition Strategies",
        "Bounded Context",
        "Inter-Service Communication",
        "Service Discovery"
        ]
    },
    {
        "id": "7.2",
        "title": "Distributed Systems Challenges",
        "topics": [
        "Fallacies of Distributed Computing",
        "Network Partitions",
        "Clock Skew and Logical Clocks",
        "Distributed Transactions",
        "Two-Phase Commit (2PC)"
        ]
    },
    {
        "id": "7.3",
        "title": "Service Mesh and Observability",
        "topics": [
        "Service Mesh Concepts (Istio, Envoy)",
        "Distributed Tracing",
        "Centralized Logging",
        "Metrics and Alerting",
        "Health Dashboards"
        ]
    }
    ]
}
```
Generate a full Markdown study document following these rules:

---

STRUCTURE RULES:
- Start with a chapter title (# heading) and a 2–3 sentence overview of what the chapter covers and why it matters
- For each subchapter, use a (## heading) with a brief intro sentence
- For each topic inside a subchapter, use a (### heading)

---

CONTENT RULES (per topic):
1. THEORY
   - Explain the concept clearly, as if teaching someone encountering it for the first time
   - Build up from the "why" before the "what" and "how"
   - Use analogies where helpful

2. EXAMPLES
   - Provide at least one concrete code example or visual diagram (in ASCII/text) where applicable
   - Code blocks must specify the language (e.g. ```java, ```javascript, ```python)
   - Annotate complex lines with inline comments

3. PRACTICE
   - Add an appropriate amount of exercises per topic ranging from beginner to intermediate difficulty including interview-style questions (with a hint, not a full answer)
   - Format exercises as a numbered list under a "> Exercises" blockquote section

4. ANSWERS
    - Include the answers to the previous exercises in PRACTICE following the same format

---

TONE & STYLE:
- Clear, precise, and technical — but approachable
- Avoid unnecessary filler or repetition
- Use tables for comparisons, bullet points for lists, and code blocks for all code
- Emojis are not allowed