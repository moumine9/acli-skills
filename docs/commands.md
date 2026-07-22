# acli command list

Quick reference for all available `acli` commands. For flags and examples, see [reference.md](reference.md).

`*` = beta or experimental

---

## acli auth

| Command | Description |
|---|---|
| `acli auth login` | Authenticate globally with OAuth |
| `acli auth logout` | Logout from all OAuth accounts |
| `acli auth status` | Show global account status |
| `acli auth switch` | Switch accounts across all products |

---

## acli jira auth

| Command | Description |
|---|---|
| `acli jira auth login` | Authenticate with an Atlassian host |
| `acli jira auth logout` | Remove Jira credentials |
| `acli jira auth status` | Show Jira account status |
| `acli jira auth switch` | Switch between Jira accounts |

---

## acli jira workitem

| Command | Description |
|---|---|
| `acli jira workitem create` | Create a single work item |
| `acli jira workitem create-bulk` | Bulk-create from JSON or CSV |
| `acli jira workitem view` | View one or more work items |
| `acli jira workitem edit` | Edit fields on work items |
| `acli jira workitem assign` | Assign work items to a user |
| `acli jira workitem transition` | Move work items to a new status |
| `acli jira workitem search` | Search with JQL or filter ID |
| `acli jira workitem clone` | Duplicate work items |
| `acli jira workitem archive` | Archive work items |
| `acli jira workitem unarchive` | Restore archived work items |
| `acli jira workitem delete` | Delete work items |
| `acli jira workitem comment create` | Add a comment to a work item |
| `acli jira workitem comment list` | List comments on a work item |
| `acli jira workitem comment update` | Edit a comment |
| `acli jira workitem comment delete` | Remove a comment |
| `acli jira workitem comment visibility` | List visibility groups and roles |
| `acli jira workitem attachment list` | List attachments on a work item |
| `acli jira workitem attachment delete` | Delete an attachment |
| `acli jira workitem link create` | Create a link between work items |
| `acli jira workitem link delete` | Delete a link by ID |
| `acli jira workitem link list` | List links on a work item |
| `acli jira workitem link type` | List available link types |
| `acli jira workitem list-watchers` | List watchers on a work item |
| `acli jira workitem watcher list` (deprecated, use `list-watchers`) | List watchers on a work item |
| `acli jira workitem watcher remove` | Remove a watcher |

---

## acli jira sprint

| Command | Description |
|---|---|
| `acli jira sprint create` | Create a sprint |
| `acli jira sprint view` | View sprint details |
| `acli jira sprint update` | Edit sprint name, dates, state, goal |
| `acli jira sprint delete` | Delete one or more sprints |
| `acli jira sprint list-workitems` | List issues in a sprint |

---

## acli jira board

| Command | Description |
|---|---|
| `acli jira board create` | Create a scrum or kanban board |
| `acli jira board get` (deprecated, use `view`) | Get board details by ID |
| `acli jira board view` | View board details by ID |
| `acli jira board search` | Search boards by name, project, type |
| `acli jira board delete` | Delete one or more boards |
| `acli jira board list-projects` | List projects linked to a board |
| `acli jira board list-sprints` | List sprints for a board |

---

## acli jira project

| Command | Description |
|---|---|
| `acli jira project list` | List projects visible to the user |
| `acli jira project view` | Fetch a project by key |
| `acli jira project create` | Create a new project |
| `acli jira project update` | Update project settings |
| `acli jira project archive` | Archive a project |
| `acli jira project restore` | Restore an archived project |
| `acli jira project delete` | Delete a project |

---

## acli jira field

| Command | Description |
|---|---|
| `acli jira field create` | Create a custom field |
| `acli jira field update` | Update a custom field |
| `acli jira field delete` | Move a custom field to trash |
| `acli jira field restore` | Restore a custom field from trash |
| `acli jira field cancel-delete` (deprecated, use `restore`) | Restore a custom field from trash |

---

## acli jira filter

| Command | Description |
|---|---|
| `acli jira filter list` | List my or favourite filters |
| `acli jira filter get` (deprecated, use `view`) | Get a filter by ID |
| `acli jira filter view` | View a filter by ID |
| `acli jira filter search` | Search filters by name or owner |
| `acli jira filter update` | Update filter name, JQL, permissions |
| `acli jira filter add-favourite` | Mark a filter as favourite |
| `acli jira filter change-owner` | Reassign filter ownership |
| `acli jira filter get-columns` (deprecated, use `list-columns`) | Get configured columns for a filter |
| `acli jira filter list-columns` | List configured columns for a filter |
| `acli jira filter reset-columns` | Reset filter columns to default |

---

## acli jira dashboard

| Command | Description |
|---|---|
| `acli jira dashboard search` | Search dashboards by name or owner |

---

## acli confluence

| Command | Description |
|---|---|
| `acli confluence auth login` | Authenticate with Confluence host |
| `acli confluence auth logout` | Remove Confluence credentials |
| `acli confluence auth status` | Show Confluence account status |
| `acli confluence auth switch` | Switch Confluence accounts |
| `acli confluence page view` | View a Confluence page by ID |
| `acli confluence blog create` | Create a blog post in a space |
| `acli confluence blog list` | List blog posts |
| `acli confluence blog view` | View a blog post by ID |
| `acli confluence space create` | Create a space |
| `acli confluence space list` | List spaces |
| `acli confluence space view` | View a space by ID |
| `acli confluence space update` | Update space details |
| `acli confluence space archive` | Archive a space |
| `acli confluence space restore` | Restore a space from archive |

---

## acli admin

| Command | Description |
|---|---|
| `acli admin auth login` | Authenticate with admin API key |
| `acli admin auth logout` | Remove admin credentials |
| `acli admin auth status` | Show admin account status |
| `acli admin auth switch` | Switch between admin org accounts |
| `acli admin user activate` | Activate a managed user |
| `acli admin user deactivate` | Deactivate a managed user |
| `acli admin user delete` | Delete a managed account |
| `acli admin user cancel-delete` | Cancel a pending account deletion |

---

## acli config

| Command | Description |
|---|---|
| `acli config gov-cloud` | Enable or disable Government Cloud mode |

---

## acli rovodev `*`

| Command | Description |
|---|---|
| `acli rovodev auth login` `*` | Authenticate with Rovo Dev API token |
| `acli rovodev auth logout` `*` | Remove Rovo Dev credentials |
| `acli rovodev auth status` `*` | Show Rovo Dev account status |
| `acli rovodev run` `*` | Start a Rovo Dev AI agent session |
| `acli rovodev oauth` `*` | Manage OAuth authentication credentials |
| `acli rovodev config` `*` | Open the Rovo Dev configuration file in your editor |
| `acli rovodev log` `*` | Open the Rovo Dev log file in your editor |
| `acli rovodev mcp` `*` | Open the Rovo Dev MCP config file in your editor |
| `acli rovodev serve` `*` | Run Rovo Dev CLI in server mode |
| `acli rovodev acp` `*` | Run Rovo Dev as an ACP server |
| `acli rovodev lsp` `*` | Run Rovo Dev CLI as a language server |
| `acli rovodev legacy` `*` | Run the legacy (non-TUI) Rovo Dev CLI |
| `acli rovodev doctor` `*` | Run Rovo Dev CLI diagnostics |

## acli guard `*`

`guard` (Atlassian Guard CLI) ships as a separate plugin, not installed by default — `acli guard` errors with `Plugin guard not found` until installed. Subcommands aren't documented here.

## acli feedback

| Command | Description |
|---|---|
| `acli feedback` | Submit a request or report a problem to Atlassian |

## acli completion

| Command | Description |
|---|---|
| `acli completion bash\|fish\|powershell\|zsh` | Generate a shell autocompletion script |
