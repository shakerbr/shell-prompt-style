# Aurora — Adaptive Customizable Bash Prompt

A beautiful, feature-rich Bash prompt with automatic dark/light mode, six color themes, git integration, and dozens of configuration options — all in a single file with no external dependencies.

**Author:** [Shaker Br](https://github.com/shakerbr) · [shbhky@gmail.com](mailto:shbhky@gmail.com)

## Features

- **6 themes** — `aurora`, `dracula`, `cyberpunk`, `forest`, `ocean`, `mono`
- **Auto dark/light mode** — follows GNOME / Ptyxis system preference, or force dark/light
- **Git status** — branch, dirty/staged/untracked markers, ahead/behind upstream, stash count
- **Smart directory display** — full path, truncated parents, or basename only
- **Command timer** — shows how long the last command took (configurable threshold)
- **Python venv & Conda** — detects active virtual environments
- **SSH indicator** — highlights remote sessions
- **Background jobs** — shows running job count
- **Exit code** — success/failure indicator with optional error code
- **Customizable symbols** — swap emoji/unicode for plain text if you don't use a Nerd Font
- **Prompt styles** — chevron, arrow, lambda, dollar, rocket, or minimal
- **Connector styles** — rounded, sharp, dots, dashes, or none

## Requirements

- **Bash** 4.0+
- **Git** (optional — only needed for git prompt segments)
- **gsettings / dconf** (optional — only needed for `AURORA_MODE="auto"` on GNOME-based desktops)

## Quick Start

### 1. Back up your existing `.bashrc`

```bash
cp ~/.bashrc ~/.bashrc.bak
```

### 2. Add Aurora to your shell

**Option A — Source the file directly**

```bash
curl -fsSL https://raw.githubusercontent.com/shakerbr/shell-prompt-style/main/bashrc -o ~/.aurora-prompt.sh
echo 'source ~/.aurora-prompt.sh' >> ~/.bashrc
```

**Option B — Clone and source**

```bash
git clone https://github.com/shakerbr/shell-prompt-style.git ~/.config/aurora-prompt
echo 'source ~/.config/aurora-prompt/bashrc' >> ~/.bashrc
```

**Option C — Copy the contents**

Open [`bashrc`](bashrc), copy everything, and paste it at the end of your `~/.bashrc`.

### 3. Reload your shell

```bash
source ~/.bashrc
```

## Configuration

All options live at the top of [`bashrc`](bashrc) in the **CONFIGURATION** section. No need to edit anything below the engine divider.

| Variable | Default | Description |
|---|---|---|
| `AURORA_THEME` | `aurora` | Color theme (`aurora`, `dracula`, `cyberpunk`, `forest`, `ocean`, `mono`) |
| `AURORA_MODE` | `auto` | Appearance mode (`auto`, `dark`, `light`) |
| `AURORA_SHOW_USER` | `true` | Show username |
| `AURORA_SHOW_HOST` | `true` | Show hostname |
| `AURORA_SHOW_TIME` | `true` | Show clock |
| `AURORA_SHOW_GIT` | `true` | Show git branch & status |
| `AURORA_SHOW_GIT_STASH` | `true` | Show stash count |
| `AURORA_SHOW_GIT_UPSTREAM` | `true` | Show ahead/behind upstream |
| `AURORA_SHOW_TIMER` | `true` | Show command execution time |
| `AURORA_TIMER_THRESHOLD` | `3` | Min seconds before showing timer |
| `AURORA_SHOW_VENV` | `true` | Show Python venv / Conda env |
| `AURORA_SHOW_JOBS` | `true` | Show background job count |
| `AURORA_SHOW_SSH` | `true` | Highlight SSH sessions |
| `AURORA_SHOW_EXIT_CODE` | `true` | Show exit code on failure |
| `AURORA_BOLD_INPUT` | `true` | Bold typed commands |
| `AURORA_INPUT_COLOR` | `6` | Custom input color (256-color code) |
| `AURORA_DIR_STYLE` | `full` | Directory display (`full`, `truncate`, `basename`) |
| `AURORA_TIME_FORMAT` | `24h` | Clock format (`24h`, `12h`) |
| `AURORA_ARROW_STYLE` | `chevron` | Prompt arrow (`chevron`, `arrow`, `lambda`, `dollar`, `rocket`, `minimal`) |
| `AURORA_CONNECTOR_STYLE` | `rounded` | Line connectors (`rounded`, `sharp`, `dots`, `dashes`, `none`) |

### Example: minimal dark Dracula

```bash
AURORA_THEME="dracula"
AURORA_MODE="dark"
AURORA_SHOW_HOST=false
AURORA_SHOW_TIME=false
AURORA_ARROW_STYLE="lambda"
AURORA_CONNECTOR_STYLE="none"
```

### Symbols without Nerd Font

If your terminal font doesn't render unicode symbols well, replace them with plain text:

```bash
AURORA_SYM_FOLDER=""
AURORA_SYM_GIT="git:"
AURORA_SYM_SUCCESS="ok"
AURORA_SYM_FAIL="err"
```

## Project Structure

```
shell-prompt-style/
├── bashrc       # The entire prompt — config + engine in one file
├── LICENSE      # MIT License
└── README.md    # This file
```

## Uninstall

Remove the `source` line (or pasted block) from your `~/.bashrc`, then reload:

```bash
source ~/.bashrc
```

Your backup at `~/.bashrc.bak` is untouched if you followed the quick start.

## License

[MIT](LICENSE) © [Shaker Br](https://github.com/shakerbr)

## Contributing

Issues and pull requests are welcome on [GitHub](https://github.com/shakerbr/shell-prompt-style).
