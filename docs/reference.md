# acli CLI reference

Source: https://developer.atlassian.com/cloud/acli/reference/commands/

`acli` is the Atlassian CLI for Jira Cloud. It lets you automate and interact with Jira from the terminal.

---

## acli jira auth

Manage authentication state.

| Subcommand | Description |
|---|---|
| `acli jira auth login` | Authenticate with an Atlassian host (interactive browser flow) |
| `acli jira auth logout` | Remove stored credentials |
| `acli jira auth status` | Show current authentication state |
| `acli jira auth switch` | Switch between Jira accounts |

---

## acli jira workitem

Create and manage Jira work items (issues).

| Subcommand | Description |
|---|---|
| `acli jira workitem create` | Create a new work item |
| `acli jira workitem create-bulk` | Bulk create issues from a file |
| `acli jira workitem view [key]` | Retrieve details for one or more work items |
| `acli jira workitem edit [key]` | Edit a work item's fields |
| `acli jira workitem assign [key]` | Assign a work item to one or more users |
| `acli jira workitem transition [key]` | Move a work item to a different status |
| `acli jira workitem search` | Search work items using JQL |
| `acli jira workitem comment` | Add or manage comments on a work item |
| `acli jira workitem attachment` | Add or manage attachments |
| `acli jira workitem link` | Link two work items together |
| `acli jira workitem clone [key]` | Duplicate an existing work item |
| `acli jira workitem archive [key]` | Archive a work item |
| `acli jira workitem unarchive [key]` | Unarchive a work item |
| `acli jira workitem delete [key]` | Delete a work item |
| `acli jira workitem watcher` | Manage watchers on a work item |

**JQL search examples**
```bash
# Issues assigned to me in a project
acli jira workitem search --jql 'project = MYPROJ AND assignee = currentUser()'

# Open bugs created this week
acli jira workitem search --jql 'issuetype = Bug AND status != Done AND created >= -7d'

# Issues in a specific sprint
acli jira workitem search --jql 'sprint = "Sprint 12" AND project = MYPROJ'
```

---

## acli jira sprint

Manage and browse Jira sprints.

| Subcommand | Description |
|---|---|
| `acli jira sprint list-workitems` | List all work items in a given sprint |

**Example**
```bash
acli jira sprint list-workitems --board-id 42 --sprint-id 7
```

---

## acli jira project

Manage Jira projects.

| Subcommand | Description |
|---|---|
| `acli jira project list` | List all projects visible to the current user |
| `acli jira project view [key]` | Fetch details for a project |
| `acli jira project create` | Create a new project |
| `acli jira project update [key]` | Update project settings |
| `acli jira project archive [key]` | Archive a project |
| `acli jira project restore [key]` | Restore an archived project |
| `acli jira project delete [key]` | Delete a project |

---

## acli jira board

Browse Jira boards (useful for finding board IDs needed by sprint commands).

| Subcommand | Description |
|---|---|
| `acli jira board list` | List boards visible to the current user |
| `acli jira board view [id]` | View a specific board |

---

## acli jira filter

Manage saved JQL filters.

| Subcommand | Description |
|---|---|
| `acli jira filter list` | List saved filters |
| `acli jira filter view [id]` | View a specific filter |

---

## acli jira field

Inspect Jira fields (useful for scripting custom field values).

| Subcommand | Description |
|---|---|
| `acli jira field list` | List all available fields |

---

## acli jira dashboard

Manage dashboards.

| Subcommand | Description |
|---|---|
| `acli jira dashboard list` | List dashboards |
| `acli jira dashboard view [id]` | View a dashboard |

---

## Global flags (all commands)

```
-h, --help   Show help
```

---

Full reference: https://developer.atlassian.com/cloud/acli/reference/commands/
