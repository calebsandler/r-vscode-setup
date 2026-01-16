# R VS Code Setup Template

Template for configuring VS Code for R development on macOS Apple Silicon. Includes setup instructions optimized for two AI coding assistants.

## Prerequisites

- **R** (4.5+) - `brew install r`
- **VS Code** - [Download](https://code.visualstudio.com/)
- **Homebrew** - [Install](https://brew.sh/)

## Quick Start

1. Open this folder in VS Code
2. Install recommended extensions when prompted
3. Choose your AI tool and follow the corresponding setup guide

> **Tip:** If this repo lives inside a parent folder, enable subfolder git detection:
> ```json
> "git.autoRepositoryDetection": "subFolders"
> ```

## Setup Guides

| AI Tool | Setup Guide | Description |
|---------|-------------|-------------|
| **Codex CLI** | `codex/vscode-r-setup.md` | Streamlined setup with validation & troubleshooting |
| **Claude Code** | `claude/r-setup-notes.md` | Detailed notes with GPU acceleration & MCP integration |

## Structure

```
r-vscode-setup/
├── .vscode/           # VS Code settings & extension recommendations
├── codex/             # Codex CLI optimized instructions
│   ├── vscode-r-setup.md
│   ├── validation.md
│   └── troubleshooting.md
├── claude/            # Claude Code optimized instructions
│   ├── r-setup-notes.md
│   └── install_clauder.R
└── README.md
```

## Key Configuration

| Item | Path/Value |
|------|------------|
| R executable | `/opt/homebrew/bin/R` |
| R version | 4.5+ |
| VS Code extensions | REditorSupport.r, RDebugger.r-debugger |

## GPU Acceleration

See `claude/r-setup-notes.md` for torch vs tensorflow guidance:
- **torch**: Best for custom ML models, large matrix ops
- **tensorflow/keras**: Best for standard deep learning, pre-built architectures

## ClaudeR MCP Integration

To enable R tools in Claude Code:
```bash
claude mcp add r-studio
```

See `claude/r-setup-notes.md` for full setup instructions.
