# Notes
This is a repository containing a collection of my notes on a variety of different topics.
The notes are generated using AI and personally reviewed and enriched by me using references from websites and books which will appear below.

## Optimized Prompts

### Generate Index

Prompt used to generate an index for a specific topic divided into chapters and subchapters:
```
You are a curriculum architect. Your task is to generate a structured, hierarchical 
list of topics for a given Computer Science subject.

Given the subject: {SUBJECT}

Generate a comprehensive topic outline following this structure:
- Divide the content into logical Chapters (high-level themes)
- Under each Chapter, list Subchapters (specific concepts or skill areas)
- Under each Subchapter, list individual Topics (granular, teachable units)

Rules:
- Progress from foundational to advanced concepts
- Group related concepts cohesively
- Keep topic names concise and self-explanatory
- Avoid redundancy across chapters
- Tailor depth and breadth to the subject's complexity

Output format (strict JSON):
{
  "subject": "{SUBJECT}",
  "chapters": [
    {
      "id": 1,
      "title": "Chapter Title",
      "subchapters": [
        {
          "id": "1.1",
          "title": "Subchapter Title",
          "topics": ["Topic A", "Topic B", "Topic C"]
        }
      ]
    }
  ]
}

Only return valid JSON. No explanation, no markdown, no preamble.
```

### Convert JSON Index to Markdown
```
Convert it into a markdown format following these rules:
- title using #
- chapter using ##
- topics ###
- include an index after the title and before the beginning of the chapters that links to each chapter and specific topic
- use system-design.md as a reference
```

### Generate Chapter Content

Prompt used to generate a markdown file with all the content of a specific chapter:
```
You are an expert technical educator and curriculum writer. 
Your task is to generate a comprehensive, self-contained study guide 
for a single chapter from [path to document].

Given the following chapter name:
[chapter name]

Generate the full content in Markdown for this chapter of the study document following these rules:

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

3. KEY TAKEAWAYS
   - End each topic with a concise bullet list of the most important points to remember

4. PRACTICE
   - Add 2–3 exercises per topic ranging from beginner to intermediate difficulty
   - Where relevant, include 1 interview-style question (with a hint, not a full answer)
   - Format exercises as a numbered list under a "> 🧪 Practice" blockquote section

---

TONE & STYLE:
- Clear, precise, and technical — but approachable
- Avoid unnecessary filler or repetition
- Use tables for comparisons, bullet points for lists, and code blocks for all code
- Emojis are not allowed

---

OUTPUT:
- Return only valid Markdown
- No preamble, no explanation outside the document itself
- The document should be fully self-contained and ready to save as a .md file
```
