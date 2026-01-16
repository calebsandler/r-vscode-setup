# R Setup Notes for macOS (Apple Silicon)

## Current Installation

| Component | Version | Purpose |
|-----------|---------|---------|
| R | 4.5.2 | Core R environment |
| OpenBLAS | 0.3.30 | Optimized CPU linear algebra |
| GCC | 15.2.0 | Package compilation |
| libomp | - | Parallel processing |

## GPU Acceleration Options

### Limitation
True CUDA GPU support is not available on macOS. Apple Silicon uses Metal/MPS instead.

### Option 1: torch (PyTorch for R)
```r
install.packages("torch")
```

Example usage:
```r
library(torch)

# Check MPS availability
torch$backends$mps$is_available()

# Create tensors on GPU
x <- torch_randn(1000, 1000, device = "mps")
y <- torch_randn(1000, 1000, device = "mps")
result <- torch_mm(x, y)

# Neural network on GPU
model <- nn_sequential(
  nn_linear(784, 256),
  nn_relu(),
  nn_linear(256, 10)
)$to(device = "mps")
```

**Best for:** Deep learning, neural networks, large matrix operations, custom ML models

### Option 2: tensorflow/keras
```r
install.packages("tensorflow")
install.packages("keras")
```

Requires Python tensorflow-metal:
```bash
pip install tensorflow-metal
```

Example usage:
```r
library(tensorflow)
library(keras)

# Check GPU detection
tf$config$list_physical_devices()

# Build model (auto-uses GPU)
model <- keras_model_sequential() %>%
  layer_dense(units = 256, activation = "relu", input_shape = c(784)) %>%
  layer_dropout(rate = 0.4) %>%
  layer_dense(units = 10, activation = "softmax")

model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = "adam",
  metrics = c("accuracy")
)

model %>% fit(x_train, y_train, epochs = 10, batch_size = 128)
```

**Best for:** Standard deep learning, image classification, pre-built architectures

## When GPU Helps

| Task | GPU Benefit |
|------|-------------|
| Deep learning / neural nets | High |
| Large matrix multiplication | High |
| Monte Carlo simulations | Medium |
| Standard regression (lm, glm) | Low |
| Data wrangling (dplyr) | None |
| Small datasets (<10k rows) | None |

## Claude Code Integration Options

### Option 1: ClaudeR Package (RStudio ↔ Claude)
Connects RStudio directly to Claude for interactive coding.

**Install:**
```r
if (!require("devtools")) install.packages("devtools")
devtools::install_github("IMNMV/ClaudeR")

library(ClaudeR)
install_cli(tools = "claude")  # For Claude Code CLI
```

**Features:**
- `execute_r`: Run R code from Claude
- `execute_r_with_plot`: Generate visualizations
- `get_active_document`: Access RStudio's active file
- `get_r_info`: Get R environment info
- Direct package installation and data analysis

**Usage:**
```r
library(ClaudeR)
claudeAddin()  # Start server, keep active during AI sessions
```

Source: https://github.com/IMNMV/ClaudeR

### Option 2: Scientific Skills Plugin
140 skills for data science/bioinformatics (Python-based, R-compatible outputs).

**Install:**
```
/plugin marketplace add K-Dense-AI/claude-scientific-skills
/plugin install scientific-skills@claude-scientific-skills
```

Includes: Statistical testing, visualization, network analysis, database queries (PubMed, GEO, UniProt), ML tools.

Source: https://github.com/K-Dense-AI/claude-scientific-skills

### Option 3: Local R Skill (Created)
Custom skill at `~/.claude/skills/r-dev/SKILL.md` covering:
- R environment commands
- Package management
- GPU acceleration (torch/tensorflow)
- Code style guidelines
- Common patterns and debugging

## Additional Resources

- [Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills) - Curated skill collection
- [Claude Code for Data Scientists](https://www.dataquest.io/blog/getting-started-with-claude-code-for-data-scientists/) - Best practices
- [Skills Marketplace](https://skillsmp.com/) - 63,000+ agent skills

## Installation Log (Jan 16, 2026)

### Homebrew Packages Installed
```bash
brew install r openblas gcc libgit2
```

### R Packages Installed
- `devtools` - Package development tools
- `ClaudeR` - Claude Code MCP integration
- `ggplot2` - Visualization (dependency)
- Plus ~50 dependencies

### ClaudeR MCP Server Setup
```bash
# Created Python venv for MCP dependencies
python3 -m venv "/Users/calebsandler/Code Repos/Personal/brennan-proj/.venv"
source .venv/bin/activate && pip install mcp httpx

# Added MCP server to Claude Code
claude mcp add r-studio --scope user \
  "/Users/calebsandler/Code Repos/Personal/brennan-proj/.venv/bin/python" \
  "/opt/homebrew/lib/R/4.5/site-library/ClaudeR/scripts/persistent_r_mcp.py"
```

### Files in This Directory
| File | Purpose |
|------|---------|
| `r-setup-notes.md` | This documentation |
| `install_clauder.R` | R installation script |

**Note:** The `.venv/` for MCP can be recreated with:
```bash
python3 -m venv .venv && source .venv/bin/activate && pip install mcp httpx
```

### Global Skill Created
- Location: `~/.claude/skills/r-dev/SKILL.md`
- Provides: R environment commands, package management, GPU setup, debugging

## Open Questions / TODOs

- [ ] Decide between torch vs tensorflow based on use case
- [x] Set up CLI coding agent skill for R development
- [x] Install ClaudeR package and MCP integration
- [ ] Test GPU acceleration with a sample workflow
- [ ] Install scientific-skills plugin (optional, for bioinformatics)
- [ ] Test R MCP server in a new Claude Code session
