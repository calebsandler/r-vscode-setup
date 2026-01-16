# Claude Code MCP Setup for R

Connect Claude Code to your R environment using the Model Context Protocol (MCP).

## Option 1: ClaudeR (Recommended)

R package specifically designed for Claude Code integration.

### Install

```r
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools", repos = "https://cloud.r-project.org")
}
devtools::install_github("IMNMV/ClaudeR")
```

Or run the provided script:
```bash
Rscript claude/install_clauder.R
```

### Add to Claude Code

```bash
claude mcp add r-studio --scope user \
  "$(which python3)" \
  "/opt/homebrew/lib/R/4.5/site-library/ClaudeR/scripts/persistent_r_mcp.py"
```

Note: ClaudeR requires a Python environment with MCP dependencies:
```bash
pip install mcp httpx
```

### Start the Server

In RStudio or an R session:
```r
library(ClaudeR)
claudeAddin()  # Keep this running during Claude Code sessions
```

### Available Tools

Once configured, Claude Code has access to:
- `mcp__r-studio__execute_r` - Run R code
- `mcp__r-studio__execute_r_with_plot` - Generate visualizations
- `mcp__r-studio__get_r_info` - Get R environment info
- `mcp__r-studio__get_active_document` - Access RStudio's active file

## Option 2: mcptools

Official R MCP package from Posit. Works with Claude Code, Codex CLI, and VS Code Copilot.

### Install

```r
install.packages("mcptools")
```

### Add to Claude Code

```bash
claude mcp add r-mcptools -s user -- Rscript -e "mcptools::mcp_server()"
```

### Connect R Sessions

To give Claude Code access to variables in a running R session:

```r
library(mcptools)
mcp_session()
```

Add to your `.Rprofile` for automatic connection:

```r
if (interactive()) {
  mcptools::mcp_session()
}
```

### Available Tools

- `list_r_sessions()` - Discover available R sessions
- `select_r_session()` - Choose which session to use
- `run_r_code()` - Execute R code
- Access to R package documentation

## Option 3: rstudiomcp

Alternative MCP server for deep RStudio integration.

### Install

```r
install.packages("remotes")
remotes::install_github("zygi/rstudiomcp")
```

### Add to Claude Code

```bash
claude mcp add rstudio -s user -- Rscript -e "rstudiomcp::run_mcp_server()"
```

## Verify Setup

```bash
claude mcp list
```

## Which Option to Choose?

| Option | Best For |
|--------|----------|
| **ClaudeR** | RStudio users, bidirectional communication, active document access |
| **mcptools** | Multi-tool support (Codex, Copilot), session management, official Posit support |
| **rstudiomcp** | Deep RStudio integration, project management features |

## Troubleshooting

### Server not found

Check the MCP server is registered:
```bash
claude mcp list
```

### Python dependencies missing (ClaudeR)

```bash
pip install mcp httpx
```

Or use a virtual environment:
```bash
python3 -m venv ~/.claude-r-venv
source ~/.claude-r-venv/bin/activate
pip install mcp httpx
```

### Rscript not in PATH

Use full path in the MCP command:
```bash
claude mcp add r-mcptools -s user -- /opt/homebrew/bin/Rscript -e "mcptools::mcp_server()"
```

## Resources

- [ClaudeR GitHub](https://github.com/IMNMV/ClaudeR)
- [mcptools documentation](https://posit-dev.github.io/mcptools/)
- [R and the Model Context Protocol](https://tidyverse.org/blog/2025/07/mcptools-0-1-0/)
