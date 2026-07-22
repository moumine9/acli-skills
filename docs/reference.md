# acli CLI reference

`acli` is the Atlassian CLI. It covers Jira Cloud, Confluence Cloud, organization admin tasks, and the Rovo Dev AI coding agent.

Top-level commands: `jira`, `confluence`, `admin`, `auth`, `config`, `rovodev`, `guard`, `feedback`, `completion`

`guard` (Atlassian Guard CLI) ships as a separate plugin that isn't installed by default — running `acli guard` errors with `Plugin guard not found` until it's installed, so its subcommands aren't documented here.

---

## acli auth

Global OAuth authentication across all products.

| Subcommand | Description |
|---|---|
| `acli auth login` | Authenticate globally with OAuth (browser flow) |
| `acli auth logout` | Logout from all active OAuth accounts |
| `acli auth status` | Show global account status |
| `acli auth switch` | Switch globally between accounts for all products |

**Flags for `switch`**
```
-s, --site string    Target site (e.g. mysite.atlassian.net)
-e, --email string   Target account email
```

---

## acli jira auth

Jira-scoped authentication. Mirrors `acli auth` but applies to Jira only.

| Subcommand | Description |
|---|---|
| `login` | Authenticate with an Atlassian host |
| `logout` | Remove Jira credentials |
| `status` | Show Jira account status |
| `switch` | Switch between Jira accounts |

**Flags for `login`**
```
-s, --site string    Site URL (e.g. mysite.atlassian.net)  [required for token auth]
-e, --email string   User email                            [required for token auth]
    --token          Read API token from stdin
-w, --web            Use browser OAuth flow
```

**Token auth (non-interactive)**
```bash
# Unix
acli jira auth login --site mysite.atlassian.net --email user@example.com --token < token.txt

# Windows
Get-Content token.txt | acli jira auth login --site mysite.atlassian.net --email user@example.com --token
```

**Flags for `switch`**
```
-s, --site string    Target site
-e, --email string   Target account email
```

---

## acli jira workitem

| Subcommand | Description |
|---|---|
| `create` | Create a single work item |
| `create-bulk` | Bulk-create from JSON or CSV |
| `view [key]` | View one or more work items |
| `edit` | Edit fields on one or more work items |
| `assign` | Assign work items to a user |
| `transition` | Move work items to a new status |
| `search` | Search with JQL or filter ID |
| `clone` | Duplicate work items |
| `archive` | Archive work items |
| `unarchive` | Restore archived work items |
| `delete` | Delete work items |
| `comment` | Subgroup: create/list/update/delete/visibility |
| `attachment` | Subgroup: list/delete |
| `link` | Subgroup: create/delete/list/type |
| `list-watchers` | List watchers of an issue |
| `watcher` | Subgroup: list (deprecated, use `list-watchers`)/remove |

### create

```
-s, --summary string            Work item summary
-p, --project string            Project key
-t, --type string               Issue type (Epic, Story, Task, Bug, etc.)
-a, --assignee string           Email, account ID, '@me', or 'default'
-d, --description string        Plain text or ADF
    --description-file string   Read description from file
-l, --label strings             Labels (comma-separated)
    --parent string             Parent work item ID
-e, --editor                    Open $EDITOR for summary+description
-f, --from-file string          Read summary/description from file
    --from-json string          Read full issue definition from JSON file
    --generate-json             Print example JSON structure
    --json                      Output result as JSON
```

### create-bulk

```
    --from-json string    JSON file with array of issue objects
    --from-csv string     CSV file (columns: summary, projectKey, issueType, description, label, parentIssueId, assignee)
    --generate-json       Print example JSON structure
    --ignore-errors       Skip failed items and continue
    --yes                 Skip confirmation
```

### view

```
acli jira workitem view KEY-123 [flags]

-f, --fields string   Comma-separated field list; '*all', '*navigable', or prefix with '-' to exclude
-j, --json            Output as JSON
-w, --web             Open in browser
```

Default fields: `key,issuetype,summary,status,assignee,description`

### edit

```
-k, --key string                Comma-separated work item keys
    --jql string                JQL selector
    --filter string             Filter ID selector
-s, --summary string
-d, --description string
    --description-file string
-a, --assignee string
    --remove-assignee
-l, --labels string
    --remove-labels string
-t, --type string
    --from-json string
    --generate-json
    --ignore-errors
-y, --yes
    --json
```

### assign

```
-k, --key string         Work item key(s)
    --jql string
    --filter string
-f, --from-file string
-a, --assignee string    Email, account ID, '@me', or 'default'; omit with --remove-assignee
    --remove-assignee
    --ignore-errors
-y, --yes
    --json
```

### transition

```
-k, --key string       Work item key(s)
    --jql string
    --filter string
-s, --status string    Target status name
    --ignore-errors
-y, --yes
    --json
```

### search

```
-j, --jql string      JQL query
    --filter string   Filter ID
-f, --fields string   Display fields (default: issuetype,key,assignee,priority,status,summary)
-l, --limit int       Max results
    --paginate        Fetch all pages
    --count           Print total count only
    --csv
    --json
-w, --web             Open results in browser
```

### clone

```
-k, --key string
    --jql string
    --filter string
-f, --from-file string
    --to-project string   Target project key
    --to-site string      Target site (default: current)
    --ignore-errors
-y, --yes
    --json
```

### archive / unarchive / delete

All three accept the same selectors:
```
-k, --key string
    --jql string
    --filter string
-f, --from-file string
    --ignore-errors
-y, --yes
    --json
```

### workitem comment

| Subcommand | Description |
|---|---|
| `create` | Add a comment |
| `list` | List comments |
| `update` | Edit a comment |
| `delete` | Remove a comment |
| `visibility` | List available visibility groups/roles |

**comment create flags**
```
-k, --key string
    --jql string
    --filter string
-b, --body string        Plain text or ADF
-F, --body-file string   File path
-e, --edit-last          Edit last comment by the same author
    --editor             Open $EDITOR
    --ignore-errors
    --json
```

**comment list flags**
```
    --key string
    --limit int      (default 50)
    --order string   created|updated, prefix with + or - (default "+created")
    --paginate
    --json
```

**comment update flags**
```
    --key string
    --id string              Comment ID
-b, --body string
    --body-file string
    --body-adf string        ADF JSON file
    --visibility-role string
    --visibility-group string
    --notify
    --json
```

**comment visibility flags**
```
    --role             List project roles
    --group            List groups
    --project string   Project key (required with --role)
```

### workitem attachment

| Subcommand | Flags |
|---|---|
| `list` | `--key string`, `--json` |
| `delete` | `--id string` |

### workitem link

| Subcommand | Description |
|---|---|
| `create` | Create link(s) between work items |
| `delete` | Delete link(s) by ID |
| `list` | List links on a work item |
| `type` | List available link types |

**link create flags**
```
    --out string         Outward work item key
    --in string          Inward work item key
    --type string        Link type (outward description, e.g. "Blocks")
    --from-json string
    --from-csv string
    --generate-json
    --ignore-errors
    --yes
```

**link delete flags**
```
    --id string
    --from-json string
    --from-csv string
    --ignore-errors
    --yes
```

### workitem watcher

| Subcommand | Flags |
|---|---|
| `list` [DEPRECATED, use `acli jira workitem list-watchers`] | `--key string`, `--json` |
| `remove` | `--key string`, `--user string` (account ID) |

`acli jira workitem list-watchers` takes the same flags as the deprecated `watcher list` and is now the documented way to list watchers.

---

## acli jira sprint

| Subcommand | Description |
|---|---|
| `create` | Create a sprint |
| `view` | View sprint details |
| `update` | Edit sprint name, dates, state, goal |
| `delete` | Delete one or more sprints |
| `list-workitems` | List issues in a sprint |

### create

```
    --name string    Sprint name  [required]
    --board int      Origin board ID  [required]
    --start string   ISO 8601 start date (e.g. 2025-01-01 or 2025-01-01T09:00:00Z)
    --end string     ISO 8601 end date
    --goal string    Sprint goal
    --json
```

### view

```
    --id string   Sprint ID  [required]
    --json
```

### update

```
    --id string              Sprint ID  [required]
    --name string
    --goal string
    --state string           future | active | closed
    --start string           ISO 8601
    --end string             ISO 8601
    --complete-date string   ISO 8601
    --board int
    --json
```

### delete

```
    --id string   One or more sprint IDs (comma-separated)
    --yes
```

### list-workitems

```
    --sprint int      Sprint ID  [required]
    --board int       Board ID   [required]
    --jql string      Additional JQL filter
    --fields string   (default: key,issuetype,summary,assignee,priority,status)
    --limit int       (default 50)
    --paginate
    --csv
    --json
```

---

## acli jira board

| Subcommand | Description |
|---|---|
| `create` | Create a scrum or kanban board |
| `get` [DEPRECATED, use `view`] | Get board details by ID |
| `view` | View details of a board by ID |
| `search` | Search boards by name, project, type |
| `delete` | Delete one or more boards |
| `list-projects` | List projects associated with a board |
| `list-sprints` | List sprints for a board |

### create

```
    --name string           Board name  [required]
    --type string           scrum | kanban  [required]
    --filter-id int         Jira filter ID  [required]
    --location-type string  project | user  [required]
    --project string        Project key or ID (required when location-type=project)
    --json
```

### get (deprecated)

Deprecated since 2026-05-13, removal scheduled for 2026-12-01. Use `view` instead.

```
    --id string   Board ID
    --json
```

### view

```
    --id string   ID of the board to view  [required]
    --json
```

### search

```
    --name string       Partial name match
    --project string    Project key
    --type string       scrum | kanban | simple
    --filter string     Filter ID
    --order-by string   name | -name | +name
    --private           Append private boards
    --limit int         (default 50)
    --paginate
    --csv
    --json
```

### delete

```
    --id string   Comma-separated board IDs  [required]
    --yes
```

### list-projects

```
    --id string     Board ID  [required]
    --limit int     (default 50)
    --paginate
    --csv
    --json
```

### list-sprints

```
    --id string       Board ID  [required]
    --state string    future | active | closed (comma-separated)
    --limit int       (default 50)
    --paginate
    --csv
    --json
```

---

## acli jira project

| Subcommand | Description |
|---|---|
| `list` | List projects visible to the user |
| `view` | Fetch a project by key |
| `create` | Create a new project |
| `update` | Update project settings |
| `archive` | Archive a project |
| `restore` | Restore an archived project |
| `delete` | Delete a project |

### list

```
    --limit int    (default 30)
    --recent       Return up to 20 recently viewed projects
    --paginate     Ignore --limit and fetch all
    --json
```

### view

```
    --key string   Project key  [required]
-j, --json
```

### create

```
-k, --key string            New project key  [required]
-n, --name string           Project name  [required]
-f, --from-project string   Clone from an existing project key (company-managed only)
-d, --description string
-l, --lead-email string
-u, --url string
-j, --from-json string      Read from JSON file
-g, --generate-json         Print example JSON structure
```

### update

```
-p, --project-key string   Project to update  [required]
-k, --key string           New key
-n, --name string          New name
-d, --description string
-l, --lead-email string
-u, --url string
-j, --from-json string
-g, --generate-json
```

### archive / restore / delete

```
    --key string   Project key  [required]
```

---

## acli jira field

Manages custom fields. Note: there is no `list` subcommand; use `create`, `update`, `delete`, and `restore`.

| Subcommand | Description |
|---|---|
| `create` | Create a custom field |
| `update` | Update a custom field |
| `delete` | Move a custom field to trash |
| `restore` | Restore a custom field from trash |
| `cancel-delete` [DEPRECATED, use `restore`] | Restore a custom field from trash |

### create

```
    --name string           Field name
    --type string           Full type key (e.g. com.atlassian.jira.plugin.system.customfieldtypes:textfield)
    --description string
    --searcher-key string   Searcher key
    --json
```

### update

```
    --id string             Custom field ID (e.g. customfield_12345)  [required]
    --name string
    --description string
    --searcher-key string
    --from-json string
    --json
```

### delete / restore / cancel-delete (deprecated)

`cancel-delete` is deprecated since 2026-05-13, removal scheduled for 2026-12-01. Use `restore` instead.

```
    --id string   Custom field ID  [required]
```

---

## acli jira filter

| Subcommand | Description |
|---|---|
| `list` | List my or favourite filters |
| `get` [DEPRECATED, use `view`] | Get a filter by ID |
| `view` | View a filter by ID |
| `search` | Search filters by name/owner |
| `update` | Update filter name, JQL, permissions |
| `add-favourite` | Mark a filter as favourite |
| `change-owner` | Reassign filter ownership |
| `get-columns` [DEPRECATED, use `list-columns`] | Get configured columns for a filter |
| `list-columns` | List configured columns for a filter |
| `reset-columns` | Reset columns to default |

### list

```
    --my          List my filters
    --favourite   List favourite filters
    --json
```

### get (deprecated) / view

Deprecated since 2026-05-13, removal scheduled for 2026-12-01. Use `view` instead.

```
    --id string   Filter ID  [required]
    --json
    --web         Open filter in browser
```

### search

```
-n, --name string    Partial name match
-e, --owner string   Owner email
-l, --limit int      (default 30)
    --paginate
    --csv
    --json
```

### update

```
    --id string                    Filter ID  [required]
    --name string
    --jql string
    --description string
    --share-permissions string     JSON array of SharePermission objects
    --edit-permissions string      JSON array of SharePermission objects
    --json
```

### add-favourite

```
    --filter-id string   Filter ID  [required]
```

### change-owner

```
    --id string          Comma-separated filter IDs
    --owner string       New owner email
-f, --from-file string   File with filter IDs
    --ignore-errors
    --json
```

### get-columns (deprecated) / list-columns / reset-columns

`get-columns` is deprecated since 2026-05-13, removal scheduled for 2026-12-01. Use `list-columns` instead.

```
    --key string   Filter ID or key  [required]
    --json                            (get-columns / list-columns only)
```

---

## acli jira dashboard

| Subcommand | Description |
|---|---|
| `search` | Search dashboards by name or owner |

### search

```
-n, --name string    Partial name match
-e, --owner string   Owner email
-l, --limit int      (default 30)
    --paginate
    --csv
    --json
```

---

## acli confluence auth

Same subcommands and flags as `acli jira auth`.

| Subcommand | Description |
|---|---|
| `login` | Authenticate with Confluence host |
| `logout` | Remove Confluence credentials |
| `status` | Show Confluence account status |
| `switch` | Switch Confluence accounts |

Login supports `--web`, `--site`, `--email`, `--token` (same as Jira).

---

## acli confluence page

| Subcommand | Description |
|---|---|
| `view` | View a Confluence page by ID |

### view

```
    --id string                                  Page ID  [required]
    --body-format string                         storage | atlas_doc_format | view (default "view")
    --version int                                Specific version number
    --status string                              Comma-separated: current,draft,archived (default "current")
    --get-draft                                  Return draft version
    --include-labels
    --include-properties
    --include-versions
    --include-version
    --include-collaborators
    --include-direct-children
    --include-likes
    --include-operations
    --include-webresources
    --include-favorited-by-current-user-status
    --json
```

---

## acli confluence blog

| Subcommand | Description |
|---|---|
| `create` | Create a blog post in a space |
| `list` | List blog posts |
| `view` | View a blog post by ID |

### create

```
    --space-id string     Space ID  [required unless --from-json]
    --title string        Blog post title  [required unless --from-json]
    --body string         Content in Confluence storage format (XHTML)
    --from-file string    Read content from file
    --from-json string    Read full payload from JSON file
    --generate-json       Print example JSON structure
    --status string       current (published) | draft  (default "current")
    --private             Create as private
    --created-at string   ISO 8601 timestamp (optional backdating)
-j, --json
```

### list

```
    --space-id string      Comma-separated space IDs
    --id string            Comma-separated blog post IDs
    --title string         Title filter
    --status string        Comma-separated: current,deleted,trashed
    --body-format string   storage | atlas_doc_format
    --cursor string        Pagination cursor from previous response
-l, --limit int            (default 25)
    --sort string
    --csv
-j, --json
```

### view

```
    --id string            Blog post ID  [required]
    --body-format string   (default "view")
    --version int          Specific version
    --status string        current | trashed | deleted | historical | draft  (default "current")
    --draft                Return draft version
    --include string       Comma-separated: labels,properties,operations,likes,versions,version,favorited,webresources,collaborators,all
-j, --json
```

---

## acli confluence space

| Subcommand | Description |
|---|---|
| `create` | Create a space |
| `list` | List spaces |
| `view` | View a space by ID |
| `update` | Update space details |
| `archive` | Archive a space by key |
| `restore` | Restore a space from trash or archive |

### create

```
    --key string            Space key  [required]
    --name string           Space name  [required]
    --description string
    --alias string          URL-friendly identifier
    --template-key string   Template to use
    --private               Create as private
    --json
```

### list

```
    --keys string     Comma-separated space keys to filter
    --type string     global | personal
    --status string   current | archived  (default "current")
    --expand string   Comma-separated: description,homepage,permissions
-l, --limit int       (default 50)
    --json
```

### view

```
    --id string          Space ID  [required]
    --desc-format string plain | view
    --icon               Include space icon
    --labels             Include labels
    --operations         Include allowed operations
    --permissions        Include space permissions
    --properties         Include space properties
    --role-assignments   Include role assignments (EAP sites only)
    --include-all        Include all of the above
    --json
```

### update

```
    --key string          Space key  [required]
    --name string
    --description string
    --status string
    --type string
    --json
```

### archive / restore

```
    --key string   Space key  [required]
    --json
```

---

## acli admin auth

Authentication for organization admin tasks. Uses API key, not OAuth.

| Subcommand | Description |
|---|---|
| `login` | Authenticate with admin API key |
| `logout` | Remove admin credentials |
| `status` | Show admin account status |
| `switch` | Switch between admin org accounts |

### login

```
-e, --email string   Admin email  [required]
    --token          Read API key from stdin
```

Create an API key at: https://admin.atlassian.com -> Settings -> API Keys

### switch

```
-o, --org string   Org name to switch to
```

---

## acli admin user

| Subcommand | Description |
|---|---|
| `activate` | Activate a managed user |
| `deactivate` | Deactivate a managed user |
| `delete` | Delete a managed account |
| `cancel-delete` | Cancel a pending account deletion |

All four commands share the same selection flags:
```
-e, --email string       Comma-separated emails
    --id string          Comma-separated Atlassian account IDs
-f, --from-file string   File with emails or account IDs
    --ignore-errors      Continue past individual failures
    --json
```

---

## acli config

| Subcommand | Description |
|---|---|
| `gov-cloud` | Enable or disable Atlassian Government Cloud mode |

### gov-cloud

```
    --enable        Enable Gov Cloud (default true); use --enable=false to disable
    --status        Show current Gov Cloud status
```

Interactive mode (no flags) prompts for enable/disable.

---

## acli feedback

Submit a request or report a problem directly to Atlassian.

```
acli feedback --summary "I have a problem" --details "..." --email "user@atlassian.com"
```

| Flag | Description |
|---|---|
| `-s, --summary string` | Summary of the feedback |
| `-d, --details string` | Details of the feedback |
| `-e, --email string` | Email address to receive the response |
| `-a, --attachments strings` | Files to attach (repeatable) |
| `-t, --time string` | Estimated timeframe when the problem occurred, e.g. `1h`, `15m` |

---

## acli completion

Generate a shell autocompletion script.

```
acli completion bash|fish|powershell|zsh
```

---

## acli rovodev (Beta)

Atlassian's AI coding agent. `acli rovodev` wraps a separately-downloaded Rovo Dev CLI binary (Python/Typer-based — its own `--help` uses an `[OPTIONS] COMMAND [ARGS]` usage line, not the Go/Cobra style of the rest of `acli`). The binary downloads automatically the first time any `acli rovodev ...` subcommand runs.

Setup:
1. Create token: https://go.atlassian.com/rovo-dev-api-token
2. `acli rovodev auth login`
3. `acli rovodev run`

| Subcommand | Description |
|---|---|
| `run` | Run the Rovo Dev TUI application |
| `auth` | Subgroup: login/logout/status |
| `oauth` | Manage OAuth authentication credentials |
| `config` | Open the Rovo Dev configuration file in your editor |
| `log` | Open the Rovo Dev log file in your editor |
| `mcp` | Open the Rovo Dev MCP config file in your editor |
| `serve` | Run Rovo Dev CLI in server mode |
| `acp` | Run Rovo Dev as an ACP server |
| `lsp` | Run Rovo Dev CLI as a language server |
| `legacy` | Run the legacy (non-TUI) Rovo Dev CLI |
| `doctor` | Run Rovo Dev CLI diagnostics (local checks are read-only; `--twg` adds live TWG probes) |

Only `auth` and `run` are covered by this repo's skills; the rest (`oauth`, `config`, `log`, `mcp`, `serve`, `acp`, `lsp`, `legacy`, `doctor`) are new since this reference was last generated — check `acli rovodev <command> --help` for current flags before relying on them.

### acli rovodev auth

| Subcommand | Description |
|---|---|
| `login` | Authenticate with email and Rovo Dev API token |
| `logout` | Remove Rovo Dev credentials |
| `status` | Show Rovo Dev account status |

**login flags**
```
-e, --email string   User email  [required]
    --token          Read API token from stdin
```

**Windows example**
```powershell
Get-Content token.txt | acli rovodev auth login --email user@example.com --token
```

### acli rovodev run

Starts the Rovo Dev AI agent session. Requires authentication first.

---

## Common output flags

Most commands support these output flags:

| Flag | Effect |
|---|---|
| `--json` | Output as JSON |
| `--csv` | Output as CSV |
| `--paginate` | Fetch all pages of results |
| `--limit int` | Cap the number of results returned |
| `--yes` / `-y` | Skip confirmation prompts |
| `--ignore-errors` | Continue past individual failures in bulk operations |
| `--web` / `-w` | Open result in browser |

---

## Notes

- Work item selectors (`--key`, `--jql`, `--filter`, `--from-file`) are interchangeable in most bulk commands.
- `--jql` accepts any valid Jira Query Language expression.
- `--from-file` accepts keys or IDs separated by commas, spaces, or newlines.
- `--generate-json` prints an example payload structure for JSON-driven commands; redirect to a file and edit before use.
- Descriptions accept plain text or Atlassian Document Format (ADF). Pass ADF as a JSON string or via `--description-file`.
- `acli rovodev` commands are in Beta and require a separate scoped API token distinct from regular Jira/Confluence tokens.
- `acli admin` uses a separate API key from Atlassian Administration, not the product API tokens.
