# ╔══════════════════════════════════════════════════════════════╗
# ║  ✨ Aurora v1.0 — Adaptive Customizable Bash Prompt        ║
# ║  Edit the CONFIG section below to make it yours!            ║
# ╚══════════════════════════════════════════════════════════════╝
#
# Author:  Shaker Br  <shbhky@gmail.com>
# GitHub:  https://github.com/shakerbr/shell-prompt-style
# License: MIT

# ┌─────────────────────────────────────────────────────────────┐
# │                    ⚙  CONFIGURATION                        │
# └─────────────────────────────────────────────────────────────┘

# ── Theme ─────────────────────────────────────────────────────
# Choose: "aurora" | "dracula" | "cyberpunk" | "forest" | "ocean" | "mono"
AURORA_THEME="aurora"

# ── Appearance Mode ───────────────────────────────────────────
# Choose: "auto" | "dark" | "light"
#   auto  →  Detects GNOME/system dark/light preference automatically
#   dark  →  Force dark terminal colors
#   light →  Force light terminal colors
AURORA_MODE="auto"

# ── Feature Toggles (true / false) ───────────────────────────
AURORA_SHOW_USER=true          # Show username
AURORA_SHOW_HOST=true          # Show hostname
AURORA_SHOW_TIME=true          # Show clock
AURORA_SHOW_GIT=true           # Show git branch & status
AURORA_SHOW_GIT_STASH=true    # Show stash count (requires git)
AURORA_SHOW_GIT_UPSTREAM=true  # Show ahead/behind upstream
AURORA_SHOW_TIMER=true         # Show command execution time
AURORA_TIMER_THRESHOLD=3       # Min seconds before showing timer
AURORA_SHOW_VENV=true          # Show Python venv / Conda env
AURORA_SHOW_JOBS=true          # Show background job count
AURORA_SHOW_SSH=true           # Highlight SSH sessions
AURORA_SHOW_EXIT_CODE=true     # Show exit code on failure (not just ✘)
AURORA_BOLD_INPUT=true         # Make typed commands bold (true / false)
AURORA_INPUT_COLOR="6"          # Custom input color code (e.g. "141" for purple, "" for default)

# ── Directory Style ──────────────────────────────────────────
# Choose: "full" | "truncate" | "basename"
#   full     →  ~/projects/my-app/src/components
#   truncate →  ~/p/m/s/components  (first letter of parents)
#   basename →  components
AURORA_DIR_STYLE="full"

# ── Time Format ──────────────────────────────────────────────
# Choose: "24h" | "12h"
AURORA_TIME_FORMAT="24h"

# ── Prompt Arrow Style ───────────────────────────────────────
# Choose: "chevron" | "arrow" | "lambda" | "dollar" | "rocket" | "minimal"
#   chevron →  ❯❯❯
#   arrow   →  ➜
#   lambda  →  λ
#   dollar  →  $
#   rocket  →  🚀
#   minimal →  ▸
AURORA_ARROW_STYLE="chevron"

# ── Connector Style ──────────────────────────────────────────
# Choose: "rounded" | "sharp" | "dots" | "dashes" | "none"
#   rounded →  ╭─ / ╰─
#   sharp   →  ┌─ / └─
#   dots    →  ┊  / ┊
#   dashes  →  ── / ──
#   none    →  (no connectors)
AURORA_CONNECTOR_STYLE="rounded"

# ── Symbols (change to plain text if no Nerd Font) ──────────
AURORA_SYM_FOLDER="🗀"          # Directory icon     (alt: "📂" or "" or "🗁")
AURORA_SYM_GIT="⎇ "            # Git branch icon    (alt: "🔀" or "git:")
AURORA_SYM_TIMER="◴"          # Timer icon         (alt: "⏱" or "took")
AURORA_SYM_VENV="⧉"           # Python venv icon   (alt: "🐍" or "venv:")
AURORA_SYM_SSH="⌁"            # SSH indicator      (alt: "🔌" or "ssh")
AURORA_SYM_JOBS="⚙"           # Background jobs    (alt: "⏳" or "jobs:")
AURORA_SYM_SUCCESS="✔"        # Success indicator  (alt: "✓" or "ok")
AURORA_SYM_FAIL="✘"           # Failure indicator  (alt: "✗" or "err")
AURORA_SYM_DIRTY="✎"          # Uncommitted changes
AURORA_SYM_STAGED="●"         # Staged changes
AURORA_SYM_UNTRACKED="+"      # Untracked files
AURORA_SYM_AHEAD="⇡"          # Ahead of upstream
AURORA_SYM_BEHIND="⇣"         # Behind upstream
AURORA_SYM_STASH="≡"          # Stash count

# ┌─────────────────────────────────────────────────────────────┐
# │              ENGINE — (no need to edit below)               │
# └─────────────────────────────────────────────────────────────┘

# ── Dark/Light Auto-Detection ─────────────────────────────────
__aurora_is_light() {
    case "$AURORA_MODE" in
        light) return 0 ;;
        dark)  return 1 ;;
        auto)
            # Step 1: Check Ptyxis's own preference
            local ptyxis_style
            ptyxis_style=$(dconf read /org/gnome/Ptyxis/interface-style 2>/dev/null | tr -d "'")
            case "$ptyxis_style" in
                dark)  return 1 ;;
                light) return 0 ;;
                system|"")
                    # Step 2: Ptyxis follows system — check GNOME
                    local scheme
                    scheme=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")
                    case "$scheme" in
                        prefer-dark) return 1 ;;
                        *)           return 0 ;;  # prefer-light or default = light
                    esac
                    ;;
            esac
            # fallback: assume dark
            return 1
            ;;
    esac
}

# ── Theme Definitions ─────────────────────────────────────────
__aurora_load_theme() {
    local light=false
    __aurora_is_light && light=true

    if [[ "$light" == true ]]; then
        # ── LIGHT MODE PALETTES ──
        case "$AURORA_THEME" in
            aurora)
                _C_USER='97'   _C_HOST='28'   _C_DIR='27'
                _C_GIT='166'   _C_TIME='244'  _C_VENV='30'
                _C_SSH='160'   _C_JOBS='97'   _C_OK='28'
                _C_ERR='160'   _C_GOLD='130'  _C_FAINT='249'
                _C_ARR1='98'   _C_ARR2='97'   _C_ARR3='140'
                ;;
            dracula)
                _C_USER='91'   _C_HOST='29'   _C_DIR='25'
                _C_GIT='130'   _C_TIME='244'  _C_VENV='29'
                _C_SSH='124'   _C_JOBS='91'   _C_OK='29'
                _C_ERR='124'   _C_GOLD='136'  _C_FAINT='249'
                _C_ARR1='91'   _C_ARR2='127'  _C_ARR3='170'
                ;;
            cyberpunk)
                _C_USER='127'  _C_HOST='30'   _C_DIR='24'
                _C_GIT='136'   _C_TIME='244'  _C_VENV='28'
                _C_SSH='124'   _C_JOBS='127'  _C_OK='28'
                _C_ERR='124'   _C_GOLD='136'  _C_FAINT='249'
                _C_ARR1='127'  _C_ARR2='30'   _C_ARR3='80'
                ;;
            forest)
                _C_USER='64'   _C_HOST='22'   _C_DIR='22'
                _C_GIT='94'    _C_TIME='244'  _C_VENV='64'
                _C_SSH='124'   _C_JOBS='64'   _C_OK='22'
                _C_ERR='124'   _C_GOLD='94'   _C_FAINT='249'
                _C_ARR1='22'   _C_ARR2='64'   _C_ARR3='108'
                ;;
            ocean)
                _C_USER='25'   _C_HOST='24'   _C_DIR='20'
                _C_GIT='94'    _C_TIME='244'  _C_VENV='30'
                _C_SSH='130'   _C_JOBS='25'   _C_OK='30'
                _C_ERR='124'   _C_GOLD='130'  _C_FAINT='249'
                _C_ARR1='20'   _C_ARR2='25'   _C_ARR3='68'
                ;;
            mono)
                _C_USER='236'  _C_HOST='240'  _C_DIR='233'
                _C_GIT='238'   _C_TIME='244'  _C_VENV='240'
                _C_SSH='233'   _C_JOBS='238'  _C_OK='236'
                _C_ERR='240'   _C_GOLD='238'  _C_FAINT='252'
                _C_ARR1='240'  _C_ARR2='236'  _C_ARR3='244'
                ;;
        esac
    else
        # ── DARK MODE PALETTES ──
        case "$AURORA_THEME" in
            aurora)
                _C_USER='183'  _C_HOST='114'  _C_DIR='75'
                _C_GIT='216'   _C_TIME='245'  _C_VENV='73'
                _C_SSH='209'   _C_JOBS='141'  _C_OK='114'
                _C_ERR='204'   _C_GOLD='222'  _C_FAINT='240'
                _C_ARR1='98'   _C_ARR2='141'  _C_ARR3='183'
                ;;
            dracula)
                _C_USER='141'  _C_HOST='84'   _C_DIR='117'
                _C_GIT='215'   _C_TIME='61'   _C_VENV='84'
                _C_SSH='203'   _C_JOBS='141'  _C_OK='84'
                _C_ERR='203'   _C_GOLD='228'  _C_FAINT='60'
                _C_ARR1='91'   _C_ARR2='141'  _C_ARR3='183'
                ;;
            cyberpunk)
                _C_USER='201'  _C_HOST='51'   _C_DIR='45'
                _C_GIT='226'   _C_TIME='239'  _C_VENV='46'
                _C_SSH='196'   _C_JOBS='201'  _C_OK='46'
                _C_ERR='196'   _C_GOLD='226'  _C_FAINT='238'
                _C_ARR1='129'  _C_ARR2='201'  _C_ARR3='213'
                ;;
            forest)
                _C_USER='151'  _C_HOST='108'  _C_DIR='71'
                _C_GIT='180'   _C_TIME='243'  _C_VENV='107'
                _C_SSH='173'   _C_JOBS='151'  _C_OK='107'
                _C_ERR='167'   _C_GOLD='179'  _C_FAINT='240'
                _C_ARR1='65'   _C_ARR2='108'  _C_ARR3='151'
                ;;
            ocean)
                _C_USER='111'  _C_HOST='74'   _C_DIR='39'
                _C_GIT='180'   _C_TIME='243'  _C_VENV='80'
                _C_SSH='209'   _C_JOBS='111'  _C_OK='80'
                _C_ERR='168'   _C_GOLD='223'  _C_FAINT='240'
                _C_ARR1='26'   _C_ARR2='33'   _C_ARR3='75'
                ;;
            mono)
                _C_USER='252'  _C_HOST='248'  _C_DIR='255'
                _C_GIT='250'   _C_TIME='243'  _C_VENV='248'
                _C_SSH='255'   _C_JOBS='250'  _C_OK='252'
                _C_ERR='245'   _C_GOLD='250'  _C_FAINT='240'
                _C_ARR1='243'  _C_ARR2='248'  _C_ARR3='252'
                ;;
        esac
    fi
}

# ── Command Timer ─────────────────────────────────────────────
__timer_start() { __cmd_timer=${__cmd_timer:-$SECONDS}; }
__timer_stop() {
    local elapsed=$(( SECONDS - ${__cmd_timer:-$SECONDS} ))
    unset __cmd_timer
    if (( elapsed >= 3600 )); then
        __last_duration="$(( elapsed / 3600 ))h $(( (elapsed % 3600) / 60 ))m $(( elapsed % 60 ))s"
    elif (( elapsed >= 60 )); then
        __last_duration="$(( elapsed / 60 ))m $(( elapsed % 60 ))s"
    elif (( elapsed >= AURORA_TIMER_THRESHOLD )); then
        __last_duration="${elapsed}s"
    else
        __last_duration=""
    fi
}
trap '__timer_start' DEBUG

# ── Smart Directory ───────────────────────────────────────────
__smart_dir() {
    case "$AURORA_DIR_STYLE" in
        truncate)
            local dir="${PWD/#$HOME/\~}"
            if [[ "$dir" == "~" ]]; then
                echo "~"
            else
                local parent
                parent=$(dirname "$dir" | sed 's|\([^/]\)[^/]*/|\1/|g')
                echo "${parent}/$(basename "$dir")"
            fi
            ;;
        basename)
            basename "$PWD"
            ;;
        *)
            local dir="${PWD/#$HOME/\~}"
            echo "$dir"
            ;;
    esac
}

# ── Git Info ──────────────────────────────────────────────────
__git_fancy() {
    [[ "$AURORA_SHOW_GIT" != true ]] && return
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [ -z "$branch" ] && return

    local flags=""
    ! git diff --quiet 2>/dev/null && flags+=" ${AURORA_SYM_DIRTY}"
    ! git diff --cached --quiet 2>/dev/null && flags+=" ${AURORA_SYM_STAGED}"
    [ -n "$(git ls-files --others --exclude-standard 2>/dev/null | head -1)" ] && flags+=" ${AURORA_SYM_UNTRACKED}"

    if [[ "$AURORA_SHOW_GIT_UPSTREAM" == true ]];
    then
        local ab
        ab=$(git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
        if [ -n "$ab" ];
        then
            local ahead behind
            ahead=$(echo "$ab" | cut -f1)
            behind=$(echo "$ab" | cut -f2)
            (( ahead > 0 ))  && flags+=" ${AURORA_SYM_AHEAD}${ahead}"
            (( behind > 0 )) && flags+=" ${AURORA_SYM_BEHIND}${behind}"
        fi
    fi

    if [[ "$AURORA_SHOW_GIT_STASH" == true ]]; then
        local stash_count
        stash_count=$(git stash list 2>/dev/null | wc -l)
        (( stash_count > 0 )) && flags+=" ${AURORA_SYM_STASH}${stash_count}"
    fi

    # MODIFIED LINE: Applies faint color to " on ", then switches to main Git color
    echo -e "\001\e[38;5;${_C_FAINT}m\002 on \001\e[38;5;${_C_GIT}m\002${AURORA_SYM_GIT} ${branch}${flags}"
}

# ── Prompt Arrow ──────────────────────────────────────────────
__prompt_arrow() {
    local a1="\[\e[38;5;${_C_ARR1}m\]"
    local a2="\[\e[1;38;5;${_C_ARR2}m\]"
    local a3="\[\e[1;38;5;${_C_ARR3}m\]"
    case "$AURORA_ARROW_STYLE" in
        chevron)  echo "${a1}❯${a2}❯${a3}❯" ;;
        arrow)    echo "${a2}➜" ;;
        lambda)   echo "${a2}λ" ;;
        dollar)   echo "${a2}\$" ;;
        rocket)   echo "${a2}🚀" ;;
        minimal)  echo "${a2}▸" ;;
    esac
}

# ── Connectors ────────────────────────────────────────────────
__connectors() {
    local F="\[\e[38;5;${_C_FAINT}m\]"
    case "$AURORA_CONNECTOR_STYLE" in
        rounded) _CON_TOP="${F}╭─"; _CON_BOT="${F}╰─" ;;
        sharp)   _CON_TOP="${F}┌─"; _CON_BOT="${F}└─" ;;
        dots)    _CON_TOP="${F}┊ "; _CON_BOT="${F}┊ " ;;
        dashes)  _CON_TOP="${F}──"; _CON_BOT="${F}──" ;;
        none)    _CON_TOP="";       _CON_BOT="" ;;
    esac
}

# ── Main Prompt Builder ──────────────────────────────────────
__build_prompt() {
    local EXIT_CODE=$?
    __timer_stop
    __aurora_load_theme
    __connectors

    local R='\[\e[0m\]'
    local B='\[\e[1m\]'
    local F="\[\e[38;5;${_C_FAINT}m\]"

    # ── Exit indicator ──
    local exit_seg=""
    if [ "$EXIT_CODE" -eq 0 ]; then
        exit_seg="\[\e[38;5;${_C_OK}m\]${B}${AURORA_SYM_SUCCESS}${R}"
    else
        if [[ "$AURORA_SHOW_EXIT_CODE" == true ]]; then
            exit_seg="\[\e[38;5;${_C_ERR}m\]${B}${AURORA_SYM_FAIL} ${EXIT_CODE}${R}"
        else
            exit_seg="\[\e[38;5;${_C_ERR}m\]${B}${AURORA_SYM_FAIL}${R}"
        fi
    fi

    # ── Timer ──
    local timer_seg=""
    if [[ "$AURORA_SHOW_TIMER" == true && -n "$__last_duration" ]]; then
        timer_seg=" \[\e[38;5;${_C_GOLD}m\]${AURORA_SYM_TIMER} ${__last_duration}${R}"
    fi

    # ── User@Host ──
    local uh_seg=""
    if [[ "$AURORA_SHOW_SSH" == true ]] && [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
        uh_seg="\[\e[1;38;5;${_C_SSH}m\]${AURORA_SYM_SSH} ssh${R} "
        [[ "$AURORA_SHOW_USER" == true ]] && uh_seg+="\[\e[1;38;5;${_C_SSH}m\]\u${R}"
        if [[ "$AURORA_SHOW_HOST" == true ]]; then
            [[ "$AURORA_SHOW_USER" == true ]] && uh_seg+="\[\e[1;38;5;${_C_FAINT}m\]@${R}"
            uh_seg+="\[\e[38;5;${_C_SSH}m\]\h${R}"
        fi
    else
        [[ "$AURORA_SHOW_USER" == true ]] && uh_seg+="\[\e[1;38;5;${_C_USER}m\]\u${R}"
        if [[ "$AURORA_SHOW_HOST" == true ]]; then
            [[ "$AURORA_SHOW_USER" == true ]] && uh_seg+="\[\e[1;38;5;${_C_FAINT}m\]@${R}"
            uh_seg+="\[\e[38;5;${_C_HOST}m\]\h${R}"
        fi
    fi

    # ── Directory ──
    local dir_seg="\[\e[1;38;5;${_C_DIR}m\]${AURORA_SYM_FOLDER} \$(__smart_dir)${R}"

    # ── Git ──
    local git_seg="\$(__git_fancy)"

    # ── Venv ──
    local venv_seg=""
    if [[ "$AURORA_SHOW_VENV" == true ]]; then
        if [ -n "$VIRTUAL_ENV" ]; then
            venv_seg=" \[\e[38;5;${_C_VENV}m\]${AURORA_SYM_VENV} $(basename "$VIRTUAL_ENV")${R}"
        elif [ -n "$CONDA_DEFAULT_ENV" ] && [ "$CONDA_DEFAULT_ENV" != "base" ]; then
            venv_seg=" \[\e[38;5;${_C_VENV}m\]${AURORA_SYM_VENV} ${CONDA_DEFAULT_ENV}${R}"
        fi
    fi

    # ── Jobs ──
    local jobs_seg=""
    if [[ "$AURORA_SHOW_JOBS" == true ]]; then
        local jc
        jc=$(jobs -p 2>/dev/null | wc -l)
        (( jc > 0 )) && jobs_seg=" \[\e[38;5;${_C_JOBS}m\]${AURORA_SYM_JOBS} ${jc}${R}"
    fi

    # ── Time ──
    local time_seg=""
    if [[ "$AURORA_SHOW_TIME" == true ]]; then
        local tfmt
        [[ "$AURORA_TIME_FORMAT" == "12h" ]] && tfmt="\@" || tfmt="\A"
        time_seg=" ${F}${tfmt}${R}"
    fi

    # ── Arrow ──
    local arrow
    arrow=$(__prompt_arrow)

    # ── Command Input Styling ──
    local input_style=""
    if [[ "$AURORA_BOLD_INPUT" == true || -n "$AURORA_INPUT_COLOR" ]]; then
        local style_code=""
        if [[ "$AURORA_BOLD_INPUT" == true ]]; then
            style_code="1"
        fi
        if [[ -n "$AURORA_INPUT_COLOR" ]]; then
            [[ -n "$style_code" ]] && style_code+=";"
            style_code+="38;5;${AURORA_INPUT_COLOR}"
        fi
        input_style="\[\e[${style_code}m\]"
    fi

    # ── Assemble ──────────────────────────────────────
    PS1="\n"
    PS1+="${_CON_TOP}${R} "
    PS1+="${exit_seg}"
    PS1+="${timer_seg}"
    [[ -n "$uh_seg" ]] && PS1+=" ${F}───${R} ${uh_seg}"
    PS1+=" ${F}in${R} ${dir_seg}"
    PS1+="${git_seg}"
    PS1+="${venv_seg}"
    PS1+="${jobs_seg}"
    PS1+="${time_seg}"
    PS1+="\n"
    PS1+="${_CON_BOT}${R}${arrow}${R} ${input_style}"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
PROMPT_COMMAND='__build_prompt'
export PS0="\[\e[0m\]"