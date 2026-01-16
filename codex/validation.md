# Validation

## Open the workspace

If `code` is in PATH:

```bash
code ~/r-workspace
```

If not, use the full path:

```bash
code_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
"$code_bin" ~/r-workspace
```

## Editor checks

- Open `scripts/test.R`, confirm syntax highlighting.
- Hover `mean` and confirm documentation appears.
- Type `data.f` and confirm `data.frame` autocomplete.

## Terminal checks

- Open the VS Code terminal and run `R` (or `radian` if configured).
- Run a line with Cmd+Enter and confirm it executes in the terminal.

## Plot checks

- Run the `plot(...)` line in `test.R`.
- Confirm the plot shows in the httpgd viewer panel.
- If needed, run `httpgd::hgd()` manually in the R console and retry.

