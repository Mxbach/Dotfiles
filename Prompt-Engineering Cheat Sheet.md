# Prompt-Engineering Cheat Sheet

## 1  AUTOMAT Framework ([The Perfect Prompt: A Prompt Engineering Cheat Sheet | by Maximilian Vogel | The Generator | Medium](https://medium.com/the-generator/the-perfect-prompt-prompt-engineering-cheat-sheet-d0b9c62a2bba))  

| Letter | Ingredient | What to specify | Mini–prompt snippet |
|--------|------------|-----------------|---------------------|
| **A** | **Act as** (bot persona) | *Role/identity* | `Act as an experienced travel-agent…` |
| **U** | **User persona & Audience** | *Who is reading?* | `…for digital-nomads with low budgets.` |
| **T** | **Targeted action / Task** | *Concrete verb* | `Plan a 10-day itinerary…` |
| **O** | **Output definition** | *Format & structure* | `Return JSON with keys "day", "location", "cost".` |
| **M** | **Mode / Tonality / Style** | *Voice & constraints* | `Write in a lively, informal tone, max 120 words per day.` |
| **A** | **Atypical cases** | *Edge-case handling* | `If data is missing, write "TBD".` |
| **T** | **Topic whitelisting** | *Allowed topics* | `Topics limited to transport, lodging & food.` |

> **CO-STAR** is an alternative mnemonic: **C**ontext, **O**bjective, **S**tyle & Tone, **T**arget Audience, **A**nswer Format, **R**easoning steps ([Prompt Engineering Cheat Sheet](https://www.linkedin.com/pulse/perfect-prompt-engineering-cheat-sheet-snippets-part-vogel-mxkcf)).

---

## 2  Define the Output Format ([The Perfect Prompt: A Prompt Engineering Cheat Sheet | by Maximilian Vogel | The Generator | Medium](https://medium.com/the-generator/the-perfect-prompt-prompt-engineering-cheat-sheet-d0b9c62a2bba))
* Show-don’t-tell: provide a miniature example just below the instruction.  
* Specify **allowed values / ranges** and how to respond **when information is missing**.

```text
### Output (example)
{
  "verdict":        "approve" | "reject",
  "confidence_pct": 0-100,
  "explanation":    "<140 chars"
}

If the confidence is below 70 %,
return "reject" and add a short apology.
```

---

## 3  Few-Shot Learning ([Prompt Engineering Cheat Sheet](https://www.linkedin.com/pulse/perfect-prompt-engineering-cheat-sheet-snippets-part-vogel-mxkcf))
Give **one standard** example and **one edge-case** example per use-case; avoid long lists of near-identical cases.

```text
### Examples
Q: "book hotel in Paris"
A: { "intent": "booking", "city": "Paris" }

Q: "Huh?"
A: { "intent": "unknown", "city": null }
```

---

## 4  Chain-of-Thought (CoT) Prompts ([The Perfect Prompt: A Prompt Engineering Cheat Sheet | by Maximilian Vogel | The Generator | Medium](https://medium.com/the-generator/the-perfect-prompt-prompt-engineering-cheat-sheet-d0b9c62a2bba))
1. Include a Q&A example that *thinks aloud*.  
2. Use a key phrase such as **“Let’s think step-by-step.”**  
3. Ask the model to output its reasoning **separately** (e.g., in a JSON field) so you can discard it later.

---

## 5  Prompt Templates ([The Perfect Prompt: A Prompt Engineering Cheat Sheet | by Maximilian Vogel | The Generator | Medium](https://medium.com/the-generator/the-perfect-prompt-prompt-engineering-cheat-sheet-d0b9c62a2bba))  
Use placeholders (e.g., `{{question}}`, `{{context_chunk}}`, `{{date}}`) and fill them at run-time.  
Typical sections, in order:

1. **Core instruction**  
2. **Examples (few-shot)**  
3. **Dynamic data** (retrieved docs, user input, date …)  
4. **Output format spec**  
5. **Interaction history** (optional)

---

## 6  RAG – Retrieval-Augmented Generation ([The Perfect Prompt: A Prompt Engineering Cheat Sheet | by Maximilian Vogel | The Generator | Medium](https://medium.com/the-generator/the-perfect-prompt-prompt-engineering-cheat-sheet-d0b9c62a2bba))
1. Embed & store your knowledge base in a vector DB.  
2. Retrieve top-k chunks relevant to the user query.  
3. Insert those chunks into a prompt template.  
4. Ask the LLM to answer *only* from the provided context.  
5. Optionally: cite sources or attach embeddings for re-ranking.

---

## 7  Formatting & Delimiters ([The Perfect Prompt: Cheat Sheet With 100+ Best Practice Examples - PART 2](https://www.linkedin.com/pulse/perfect-prompt-engineering-cheat-sheet-snippets-part-vogel-ukysf))
* Use **hashes (`###`) for section headings** inside the prompt.  
* Wrap external data in **triple quotes** or JSON code-fences.  
* Keep one instruction per line where possible.

---

## 8  Assemble the Parts ([The Perfect Prompt: Cheat Sheet With 100+ Best Practice Examples - PART 2](https://www.linkedin.com/pulse/perfect-prompt-engineering-cheat-sheet-snippets-part-vogel-ukysf))
> **Recommended order**: **Instruction → Examples → Data → Output spec → History**

```text
### Instruction
You are…

### Examples
Q: …
A: …

### Data
"""{{retrieved_context}}"""

### Output
<JSON spec here>

### History
{{chat_history}}
```

---

## 9  Multi-Prompt / Prompt Decomposition ([The Perfect Prompt: Cheat Sheet With 100+ Best Practice Examples - PART 2](https://www.linkedin.com/pulse/perfect-prompt-engineering-cheat-sheet-snippets-part-vogel-ukysf))
For complex workflows, split into stages:

1. **Classify** the request.  
2. **Route** to a specialised prompt.  
3. **Post-process / evaluate** the model’s answer (can be another prompt).

---

## 10  Quick Reference — “Prompt Snippets”

| Goal | Skeleton |
|------|----------|
| **Summarise** | `Summarise the text (max 5 bullet points, ≤ 60 chars each): """{{text}}"""` |
| **Translate** | `Translate to German, keep formatting: """{{text}}"""` |
| **Extract entities** | `Return JSON {name, date, amount} from: """{{invoice}}"""` |
| **Classify sentiment** | `Label as positive/neutral/negative: "{{tweet}}"` |
| **Write code** | `Write idiomatic Python 3.12 that … (include tests)` |
| **Creative writing** | `Write a sonnet in Shakespearean style about {{topic}}` |

---

## 11  Troubleshooting & Iteration
1. **A/B-test** two prompt variants on the same input.  
2. **Simplify**: remove unnecessary examples or shrink context.  
3. **Ask the model** to critique its own answer, then improve.  
4. **Log & analyse** failures; add them as new few-shot cases.

---

### Further Reading & Resources
The sheet ends with ~40 hand-picked links to papers, vector-database tutorials and “awesome-prompt” lists (full hyperlink list preserved in the original PDF).
