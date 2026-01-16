# Codex CLI MCP Setup for R

Connect Codex CLI to your R environment using the Model Context Protocol (MCP).

## Option 1: mcptools (Recommended)

Official R MCP package from Posit (RStudio).

### Install

```r
install.packages("mcptools")
```

### Add to Codex

```bash
codex mcp add r-mcptools -- Rscript -e "mcptools::mcp_server()"
```

Or edit `~/.codex/config.toml`:

```toml
[mcp_servers.r-mcptools]
command = "Rscript"
args = ["-e", "mcptools::mcp_server()"]
```

### Connect R Sessions

To give Codex access to variables in a running R session:

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

Once configured, Codex has access to:
- `list_r_sessions()` - Discover available R sessions
- `select_r_session()` - Choose which session to use
- `run_r_code()` - Execute R code
- Access to R package documentation

## Option 2: rstudiomcp

Alternative MCP server for RStudio integration.

### Install

```r
install.packages("remotes")
remotes::install_github("zygi/rstudiomcp")
```

### Add to Codex

```bash
codex mcp add rstudio -- Rscript -e "rstudiomcp::run_mcp_server()"
```

## Verify Setup

```bash
codex mcp list
```

In Codex TUI, type `/mcp` to see active servers.

## Troubleshooting

### Server not starting

Check Rscript is in PATH:
```bash
which Rscript
```

If not found, use full path:
```toml
[mcp_servers.r-mcptools]
command = "/opt/homebrew/bin/Rscript"
args = ["-e", "mcptools::mcp_server()"]
```

### Timeout errors

Increase startup timeout in config:
```toml
[mcp_servers.r-mcptools]
command = "Rscript"
args = ["-e", "mcptools::mcp_server()"]
startup_timeout_sec = 30
```

## Resources

- [mcptools documentation](https://posit-dev.github.io/mcptools/)
- [Codex MCP documentation](https://developers.openai.com/codex/mcp/)
- [R and the Model Context Protocol](https://tidyverse.org/blog/2025/07/mcptools-0-1-0/)
