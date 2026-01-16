# Codex VS Code R Setup (macOS Apple Silicon)

This is a Codex-friendly version of the setup steps for this machine.

## Known paths on this machine

- R: `/opt/homebrew/bin/R`
- VS Code app: `/Applications/Visual Studio Code.app`
- VS Code CLI: `/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code`

## 1) Prerequisites

```bash
/opt/homebrew/bin/R --version
/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code --version
echo "$SHELL"
```

If the `code` CLI is not in PATH, use the full path above or install it from
VS Code: Command Palette -> "Shell Command: Install 'code' command in PATH".

## 2) Install VS Code extensions

```bash
code_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
"$code_bin" --install-extension REditorSupport.r
"$code_bin" --install-extension RDebugger.r-debugger
"$code_bin" --list-extensions | rg -i '^reditorsupport\\.r$'
```

## 3) Install R packages (user library recommended)

```bash
R -q -e 'dir.create(Sys.getenv("R_LIBS_USER"), recursive=TRUE, showWarnings=FALSE)'
R -q -e 'install.packages("languageserver", repos="https://cloud.r-project.org/")'
```

If you see `failed to lock directory`, remove the lock and retry:

```bash
rm -rf /opt/homebrew/lib/R/4.5/site-library/00LOCK-*
```

Install httpgd (CRAN first, GitHub fallback if CRAN is unavailable):

```bash
R -q -e 'install.packages("httpgd", repos="https://cloud.r-project.org/")'
R -q -e 'if (!requireNamespace("httpgd", quietly=TRUE)) { if (!requireNamespace("remotes", quietly=TRUE)) install.packages("remotes", repos="https://cloud.r-project.org/"); remotes::install_github("nx10/httpgd") }'
```

## 4) Optional: radian (enhanced terminal)

On macOS with Homebrew Python, prefer `pipx`:

```bash
brew install pipx
pipx install radian
which radian
```

## 5) Create workspace structure

```bash
mkdir -p ~/r-workspace/.vscode
mkdir -p ~/r-workspace/scripts
mkdir -p ~/r-workspace/data
mkdir -p ~/r-workspace/output
```

## 6) VS Code settings

Create `~/r-workspace/.vscode/settings.json`:

```json
{
  "r.rterm.mac": "/opt/homebrew/bin/R",
  "r.rterm.option": [
    "--no-save",
    "--no-restore"
  ],
  "r.bracketedPaste": true,
  "r.plot.useHttpgd": true,
  "r.lsp.enabled": true,
  "r.lsp.diagnostics": true,
  "r.sessionWatcher": true,
  "editor.formatOnSave": false,
  "files.associations": {
    "*.R": "r",
    "*.Rmd": "rmd"
  },
  "[r]": {
    "editor.tabSize": 2,
    "editor.wordWrap": "on"
  }
}
```

If using radian, set `"r.rterm.mac"` to its path from `which radian`.

## 7) Sample script

Create `~/r-workspace/scripts/test.R`:

```r
# Test script to verify VS Code R setup

x <- 1:10
mean(x)

plot(x, x^2, type = "b", main = "Test Plot")

df <- data.frame(
  id = 1:5,
  value = rnorm(5)
)
print(df)

message("R environment configured successfully!")
```

## 8) Validation checklist

```bash
code ~/r-workspace
```

In VS Code:
- Open `scripts/test.R`, confirm syntax highlighting.
- Hover `mean` for LSP docs.
- Type `data.f` and confirm autocomplete.
- Run selected line with Cmd+Enter.
- Run the plot and check the httpgd viewer.

## Optional: ClaudeR MCP server (already installed)

If you want the ClaudeR MCP server again, use a local venv:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install mcp httpx
claude mcp add r-studio --scope user \
  "/Users/calebsandler/Code Repos/Personal/brennan-proj/.venv/bin/python" \
  "/opt/homebrew/lib/R/4.5/site-library/ClaudeR/scripts/persistent_r_mcp.py"
```

## Next steps

- Validate the setup with `codex/validation.md`.
- Use `codex/troubleshooting.md` if anything fails.
