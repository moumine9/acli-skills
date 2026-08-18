---
name: atlassian-document-format
description: Convert Markdown content into Atlassian Document Format (ADF) JSON for use with Jira descriptions/comments (--description-file, --body-adf) or Confluence page bodies. Use when the user wants to publish markdown content to Jira or Confluence, or explicitly asks to convert markdown to ADF.
user-invocable: true
disable-model-invocation: false
argument-hint: "[markdown text or file path]"
model: haiku
effort: low
---

## Task

Convert Markdown content into valid Atlassian Document Format (ADF) JSON, ready to hand off to `acli` for Jira or Confluence.

## Steps

### 1. Get the markdown

Take the markdown from `$ARGUMENTS` (inline text or a file path). If neither is given, **ask the user** for the markdown content or file to convert.

---

### 2. Convert to ADF

Every ADF document is a single JSON object:

```json
{"version": 1, "type": "doc", "content": [ ... ]}
```

Map each markdown construct to its ADF node/mark using this table:

| Markdown | ADF |
|---|---|
| Paragraph | `{"type": "paragraph", "content": [...]}` |
| `# H1` … `###### H6` | `{"type": "heading", "attrs": {"level": 1-6}, "content": [...]}` |
| `- item` / `* item` | `{"type": "bulletList", "content": [listItem, ...]}` |
| `1. item` | `{"type": "orderedList", "content": [listItem, ...]}` |
| list item | `{"type": "listItem", "content": [paragraph, ...]}` — content must be block nodes, never bare text |
| \`\`\`lang ... \`\`\` | `{"type": "codeBlock", "attrs": {"language": "lang"}, "content": [{"type": "text", "text": "..."}]}` |
| `> quote` | `{"type": "blockquote", "content": [paragraph, ...]}` |
| `---` | `{"type": "rule"}` |
| tables | `{"type": "table", "content": [tableRow, ...]}`, rows contain `tableHeader`/`tableCell`, each wrapping a `paragraph` |
| `**bold**` | text node with mark `{"type": "strong"}` |
| `*italic*` / `_italic_` | text node with mark `{"type": "em"}` |
| `` `code` `` | text node with mark `{"type": "code"}` |
| `~~strike~~` | text node with mark `{"type": "strike"}` |
| `[text](url)` | text node with mark `{"type": "link", "attrs": {"href": "url"}}` (a mark, not a node) |

Every leaf of text is `{"type": "text", "text": "...", "marks": [...]}` — omit `marks` when there are none.

Nested lists nest a `bulletList`/`orderedList` directly inside a `listItem`'s content, alongside or after the item's paragraph.

Validate the result before moving on: valid JSON, top-level `version`/`type`/`content` keys present, every node has a recognized `type`.

---

### 3. Hand off to acli

Write the JSON to a file (e.g. via `Write` or a temp file) rather than inlining large ADF into a shell argument.

**Jira** — pass the file to `workitem`/`comment` subcommands:

```bash
acli jira workitem create --summary "<summary>" --project "<KEY>" --type "<Task>" --description-file "<adf.json>"
acli jira workitem comment create --key "<KEY>" --body-file "<adf.json>"
```

See [skills/workitem/SKILL.md](../workitem/SKILL.md) for the full workitem/comment flow. Note `-d/--description` and `-b/--body` also accept plain text or an inline ADF string, not only files.

**Confluence** — as of this writing, `acli confluence page` only exposes `view` (which can *read* a page as ADF via `--body-format atlas_doc_format`); there is no documented `create`/`update` subcommand that accepts an ADF body. Before assuming Confluence publishing is possible, run `acli confluence page --help` (or check [docs/reference.md](../../docs/reference.md#acli-confluence-page)) to confirm current support, and tell the user if it isn't available yet.

---

### 4. Output

Show the user the generated ADF JSON (or the file path it was written to) and the exact next `acli` command to run with it.

---

For the underlying `acli` flags, see [docs/reference.md](../../docs/reference.md#acli-jira-workitem) and [docs/reference.md](../../docs/reference.md#acli-confluence-page).
