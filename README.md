# GitLab MR MCP Server - Docker Image

Docker image for [gitlab-mr-mcp](https://github.com/amirsina-mandegari/gitlab-mr-mcp), a Model Context Protocol (MCP) server that enables AI assistants to interact with GitLab Merge Requests, perform code reviews, manage approvals, and access CI/CD pipelines.

## Features

- **24 MCP Tools** for comprehensive GitLab integration
- **Merge Request Management**: List, create, update, and merge MRs
- **Code Reviews**: Read reviews, create comments, resolve discussions
- **Approvals**: Approve/unapprove merge requests
- **CI/CD Integration**: Access pipeline status, job logs, and test reports
- **Project Discovery**: Search and list GitLab projects
- Supports both **gitlab.com** and **self-hosted GitLab instances**

## Quick Start

### Pull the Image

```bash
docker pull geodonz/gitlab-mr-mcp:latest
```

### Test Installation

```bash
docker run --rm \
  -e GITLAB_URL=https://gitlab.com \
  -e GITLAB_ACCESS_TOKEN=your-token-here \
  geodonz/gitlab-mr-mcp:latest
```

The server will start in MCP stdio mode, ready to receive JSON-RPC requests.

## Prerequisites

### GitLab Personal Access Token

You need a GitLab Personal Access Token with `api` scope:

1. Go to [GitLab Settings > Access Tokens](https://gitlab.com/-/user_settings/personal_access_tokens)
2. Click **"Add new token"**
3. Configure:
   - **Token name**: `MCP GitLab Server` (or your preferred name)
   - **Expiration date**: Set according to your security policy
   - **Select scopes**: ✅ Check **`api`** (full API access)
4. Click **"Create personal access token"**
5. **Copy the token** immediately (it's only shown once)
   - Format: `glpat-xxxxxxxxxxxxxxxxxxxx`

## Configuration for MCP

### Using with Docker MCP

Create a configuration file for your MCP server catalog. See `gitlab-mr-mcp.yaml.template` in this repository for a complete example.

**Minimal configuration:**

```yaml
registry:
  gitlab-mr:  # Choose any name you prefer
    description: GitLab MR server for code review and CI/CD integration
    title: GitLab MR
    type: server
    image: geodonz/gitlab-mr-mcp:latest
    
    env:
      - name: GITLAB_URL
        value: https://gitlab.com  # Or your self-hosted GitLab URL
      - name: GITLAB_ACCESS_TOKEN
        value: glpat-xxxxxxxxxxxxxxxxxxxx  # Your actual token
```

### Manual Docker Run

```bash
docker run --rm -i \
  -e GITLAB_URL=https://gitlab.com \
  -e GITLAB_ACCESS_TOKEN=glpat-xxxxxxxxxxxxxxxxxxxx \
  geodonz/gitlab-mr-mcp:latest
```

### For Self-Hosted GitLab

Simply change the `GITLAB_URL` environment variable:

```bash
docker run --rm -i \
  -e GITLAB_URL=https://gitlab.yourcompany.com \
  -e GITLAB_ACCESS_TOKEN=glpat-xxxxxxxxxxxxxxxxxxxx \
  geodonz/gitlab-mr-mcp:latest
```

## Available Tools

The server provides 24 MCP tools organized by category:

### Project Discovery
- `search_projects` - Search GitLab projects by name/description
- `list_my_projects` - List your accessible projects

### Merge Request Management
- `list_merge_requests` - List MRs in a project
- `get_merge_request_details` - Get detailed info about an MR
- `create_merge_request` - Create a new MR
- `update_merge_request` - Update existing MR
- `merge_merge_request` - Merge an MR

### Approvals
- `approve_merge_request` - Approve an MR
- `unapprove_merge_request` - Remove your approval

### Reviews & Comments
- `get_merge_request_reviews` - Get all review comments
- `reply_to_review_comment` - Reply to a comment
- `create_review_comment` - Add new review comment
- `resolve_review_discussion` - Resolve a discussion thread

### Commit Discussions
- `get_commit_discussions` - Get discussions on commits

### Branch & Pipeline
- `get_branch_merge_requests` - Find MRs for a branch
- `get_merge_request_pipeline` - Get pipeline info for an MR
- `get_job_log` - Fetch CI job logs

### Test Reports
- `get_pipeline_test_summary` - Pipeline test summary
- `get_merge_request_test_report` - MR test report

### Project Information
- `list_project_members` - List project team members
- `list_project_labels` - List available labels

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `GITLAB_URL` | Yes | - | GitLab instance URL (e.g., `https://gitlab.com`) |
| `GITLAB_ACCESS_TOKEN` | Yes | - | Personal Access Token with `api` scope |

## Building from Source

```bash
# Clone this repository
git clone git@github.com:geodon/gitlab-mr-mcp.git
cd gitlab-mr-mcp

# Build the image
docker build -t geodonz/gitlab-mr-mcp:latest .

# Verify build
docker images | grep gitlab-mr-mcp
```

## Image Details

- **Base Image**: `python:3.11-slim`
- **Size**: ~184 MB
- **Package**: `gitlab-mr-mcp` from PyPI (latest version)
- **Entry Point**: `gitlab-mcp`
- **Protocol**: MCP stdio mode (JSON-RPC over stdin/stdout)

## Troubleshooting

### Error: "GITLAB_ACCESS_TOKEN environment variable is required"

The token is mandatory. Make sure you've set it in your environment or MCP configuration:

```bash
# Test manually
docker run --rm \
  -e GITLAB_URL=https://gitlab.com \
  -e GITLAB_ACCESS_TOKEN=glpat-xxxx \
  geodonz/gitlab-mr-mcp:latest
```

### Verify Token Permissions

Test your token with curl:

```bash
curl -H "PRIVATE-TOKEN: glpat-xxxx" "https://gitlab.com/api/v4/user"
```

Should return your GitLab user information.

### Connection Issues to Self-Hosted GitLab

- Verify the URL is accessible from the container
- Check if SSL certificates are valid
- Ensure the token has appropriate permissions on the self-hosted instance

## License

This Docker image packages the [gitlab-mr-mcp](https://github.com/amirsina-mandegari/gitlab-mr-mcp) project, which is licensed under the MIT License.

## Credits

- **Original Project**: [gitlab-mr-mcp](https://github.com/amirsina-mandegari/gitlab-mr-mcp) by [amirsina-mandegari](https://github.com/amirsina-mandegari)
- **MCP Protocol**: [Model Context Protocol](https://modelcontextprotocol.io/) by Anthropic

## Links

- [GitLab MR MCP on GitHub](https://github.com/amirsina-mandegari/gitlab-mr-mcp)
- [Model Context Protocol Documentation](https://modelcontextprotocol.io/)
- [GitLab API Documentation](https://docs.gitlab.com/ee/api/)
