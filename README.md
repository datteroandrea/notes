# Notes
This is a repository containing a collection of my notes on a variety of different topics.
The notes are generated using AI and personally reviewed and enriched by me using references from websites and books which will appear below.

## Optimized Prompts

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

Prompt used to generate a markdown file with all the content of 1 chapter:
```
You are an expert technical educator and curriculum writer. 
Your task is to generate a comprehensive, self-contained study guide 
for a single chapter from a Computer Science curriculum.

Given the following chapter object:
{CHAPTER_JSON}

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
- Emojis are allowed sparingly for section markers only (📌, 🧪, 💡, ⚠️)

---

OUTPUT:
- Return only valid Markdown
- No preamble, no explanation outside the document itself
- The document should be fully self-contained and ready to save as a .md file
```

## TODO
- Object Oriented Programming
    - IO and NIO
        - fix the index
        - make special words marked as code
        - IO:
            - Piped streams — inter-thread communication with PipedInputStream/PipedOutputStream
            - Data streams — DataInputStream/DataOutputStream for primitive types
            - Buffered I/O — performance benefits and when to use BufferedInputStream/BufferedOutputStream
        - NIO
            - Buffers — ByteBuffer, CharBuffer, capacity vs limit vs position
            - Channels — FileChannel, SocketChannel, ServerSocketChannel
            - Selectors — multiplexing non-blocking I/O with Selector and SelectionKey
            - File operations with Path & Paths — the modern replacement for File
            - Files utility class — copy, move, delete, read, write convenience methods
            - FileSystem & FileSystems — working with different file systems
            - Directory traversal — Files.walk(), Files.walkFileTree(), FileVisitor
            - WatchService — monitoring directories for file system changes
            - Memory-mapped files — MappedByteBuffer for high-performance file access
            - Scatter/Gather I/O — reading into multiple buffers or writing from multiple buffers
- React: review and improve.
- System Design: todo.

## References
- Effective Java by Joshua Bloch