# Troubleshooting

## code CLI not in PATH

Use the full path:

```bash
code_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
"$code_bin" --version
```

Or install the CLI from VS Code:
Command Palette -> "Shell Command: Install 'code' command in PATH".

## R package lock errors

If install fails with `failed to lock directory`, remove stale locks and retry:

```bash
rm -rf /opt/homebrew/lib/R/4.5/site-library/00LOCK-*
```

## httpgd not available on CRAN

Install from GitHub:

```bash
R -q -e 'if (!requireNamespace("remotes", quietly=TRUE)) install.packages("remotes", repos="https://cloud.r-project.org/")'
R -q -e 'remotes::install_github("nx10/httpgd")'
```

## pip PEP 668 errors

If pip refuses to install system-wide:

```bash
brew install pipx
pipx install radian
```

Or use a local venv:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install radian
```

## R user library permissions

If R tries to install to a system library, create the user library and retry:

```bash
R -q -e 'dir.create(Sys.getenv("R_LIBS_USER"), recursive=TRUE, showWarnings=FALSE)'
```

