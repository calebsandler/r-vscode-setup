# R VS Code Setup Template

Template repository for configuring VS Code for R development on macOS Apple Silicon, with Claude Code MCP integration.

## Prerequisites

- **R** (4.5+) - Install via `brew install r`
- **VS Code** - [Download](https://code.visualstudio.com/)
- **Homebrew** - [Install](https://brew.sh/)

## Quick Start

1. Open this folder in VS Code
2. Install recommended extensions when prompted
3. Follow `codex/vscode-r-setup.md` for full setup
4. Verify with `codex/validation.md`

> **Tip:** If this repo lives inside a parent folder, enable subfolder git detection in VS Code:
> ```json
> "git.autoRepositoryDetection": "subFolders"
> ```

## Documentation

### Primary (Use These)

| File | Purpose |
|------|---------|
| `codex/vscode-r-setup.md` | Step-by-step setup instructions |
| `codex/validation.md` | Verification checklist |
| `codex/troubleshooting.md` | Common fixes |

### Reference

| File | Purpose |
|------|---------|
| `claude/r-setup-notes.md` | GPU acceleration, ClaudeR MCP setup, detailed notes |
| `claude/install_clauder.R` | R script for ClaudeR installation |

## Structure

```
brennan-proj/
├── .vscode/           # VS Code settings & extension recommendations
├── codex/             # Setup instructions (machine-specific)
├── claude/            # Reference documentation
└── README.md          # This file
```

## Key Configuration

| Item | Path/Value |
|------|------------|
| R executable | `/opt/homebrew/bin/R` |
| R version | 4.5.2 |
| ClaudeR MCP | `claude mcp add r-studio` (already configured) |
| VS Code extensions | REditorSupport.r, RDebugger.r-debugger |

## For AI Agents

**Use `codex/` for setup instructions** - it contains the machine-specific, refined version.

### MCP Tools Available

When the R MCP server is running, these tools are available:
- `mcp__r-studio__execute_r` - Run R code
- `mcp__r-studio__execute_r_with_plot` - Run R code that generates plots
- `mcp__r-studio__get_r_info` - Get R environment info
- `mcp__r-studio__get_active_document` - Get active RStudio document

### GPU Acceleration

See `claude/r-setup-notes.md` for torch vs tensorflow guidance. Summary:
- **torch**: Best for custom ML models, large matrix ops
- **tensorflow/keras**: Best for standard deep learning, pre-built architectures
