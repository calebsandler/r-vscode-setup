# Codex VS Code R Setup (macOS Apple Silicon)

Codex-friendly setup steps for R development in VS Code.

> **Note:** See `troubleshooting.md` if you encounter any errors.

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

## 2) Install VS Code extensions

```bash
code --install-extension REditorSupport.r
code --install-extension RDebugger.r-debugger
code --list-extensions | grep -i reditorsupport
```

## 3) Install R packages

```bash
R -q -e 'install.packages("languageserver", repos="https://cloud.r-project.org/")'
R -q -e 'install.packages("httpgd", repos="https://cloud.r-project.org/")'
```

## 4) Optional: radian (enhanced terminal)

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
  "r.rterm.option": ["--no-save", "--no-restore"],
  "r.bracketedPaste": true,
  "r.plot.useHttpgd": true,
  "r.lsp.enabled": true,
  "r.lsp.diagnostics": true,
  "r.sessionWatcher": true,
  "editor.formatOnSave": false,
  "files.associations": { "*.R": "r", "*.Rmd": "rmd" },
  "[r]": { "editor.tabSize": 2, "editor.wordWrap": "on" }
}
```

If using radian, set `"r.rterm.mac"` to its path from `which radian`.

## 7) Sample script

Create `~/r-workspace/scripts/test.R`:

```r
x <- 1:10
mean(x)
plot(x, x^2, type = "b", main = "Test Plot")
df <- data.frame(id = 1:5, value = rnorm(5))
print(df)
message("R environment configured successfully!")
```

## 8) Validation

See `validation.md` for the full checklist. Quick check:

1. Open `scripts/test.R` - confirm syntax highlighting
2. Hover `mean` - confirm LSP docs appear
3. Type `data.f` - confirm autocomplete
4. Run the plot - confirm httpgd viewer opens
