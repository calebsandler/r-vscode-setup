# Install ClaudeR package
# Step 1: Install devtools if not present
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools", repos = "https://cloud.r-project.org")
}

# Step 2: Install ClaudeR from GitHub
devtools::install_github("IMNMV/ClaudeR")

# Step 3: Load and set up ClaudeR
library(ClaudeR)

# Step 4: Install CLI integration for Claude Code
install_cli(tools = "claude")

cat("\n=== ClaudeR Installation Complete ===\n")
