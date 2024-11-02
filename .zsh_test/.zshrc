# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

####=== SHELL & ENV VARIABLES ==================================================
export EDITOR=micro                           # Set default editor
# Default WORDCHARS: '*?_-.[]~=/&;!#$%^(){}<>' ; Tilix: '-,./?%&#:_'
export WORDCHARS=''       # Only alphanums (fine-grain, readline/bash style)
# Add user completions to fpath
[[ -d "$HOME/.local/share/zsh/site-functions" ]] && fpath=("$HOME/.local/share/zsh/site-functions" $fpath)
# fzf Catppuccin theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi \
--bind 'ctrl-y:execute-silent(echo {+} | xclip -se c)',ctrl-h:backward-kill-word"
# For Micro editor theming
export "MICRO_TRUECOLOR=1"

####=== MISCELLANEOUS ==========================================================
autoload -U zrecompile        # Make zrecompile available to re-compile .zshrc
# Adjust highlight of paste from the default bright colors
zle_highlight=('paste:fg=#f5e0dc,bg=#45475a')

####=== PROMPT =================================================================
# autoload -U promptinit; promptinit
# setopt promptsubst

####=== DIRECTORIES ============================================================
# OPTIONS
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.alias -g ...='../..'
setopt MULTIOS              # Write to multiple descriptors.alias -g ....='../../..'
setopt EXTENDED_GLOB        # Use extended globbing syntax.alias -g .....='../../../..'
unsetopt CLOBBER            # Do not overwrite existing files with > and >>.alias -g ......='../../../../..'
                            # Use >! and >>! to bypass.
setopt AUTO_NAME_DIRS       # Automatically register parameters below as named dirs ( ~dir )
# NAMED DIRECTORIES
data="/mnt/Data"          docs="$HOME/Documents"   downs="$HOME/Downloads"
music="/mnt/music/Music"  pics="$HOME/Pictures"     ref="$HOME/Reference"
seanas="/mnt/SeaNAS"      vids="/mnt/SeaNAS/Videos" build="/mnt/Data/Build"

####=== PAGER ==================================================================
export PAGER=less                   # Set default pager
# LESSOPEN syntax highlighting for FZF-TAB - SEE lib/{'completion','lessfilter'}.zsh
# export LESSOPEN='|~/.zsh/lib/lessfilter %s'
export LESS="--ignore-case --status-column --RAW-CONTROL-CHARS --incsearch"     # Set default option: Raw Control Chars
# export LESSHISTFILE="/dev/null"     # Prevent the less hist file from being made
# export LESS_TERMCAP_mb=$'\e[6m'     # begin blinking
# export LESS_TERMCAP_md=$'\e[34m'    # begin bold (primary color): fg:blueish
# export LESS_TERMCAP_us=$'\e[4;32m'  # begin underline: ul,fg:greenish
# export LESS_TERMCAP_so=$'\e[30;44m' # begin standout-mode (info box): b,fg:blackish,bg:blueish
# export LESS_TERMCAP_me=$'\e[m'      # end mode (turn off bold, blink, underline)
# export LESS_TERMCAP_ue=$'\e[m'      # end underline
# export LESS_TERMCAP_se=$'\e[m'      # end standout-mode
export GROFF_NO_SGR=1               # for konsole and gnome-terminal
# export MANPAGER="batman"
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"
# Bat default style & theme
export BAT_STYLE="numbers,changes,grid,header"
export BAT_THEME="Catppuccin Mocha"
# export BAT_THEME="Visual Studio Dark+"

####=== RUN-HELP ===============================================================
# ENABLE HELP in Zsh & RUN-HELP ASSISTANT FUNCTIONS; 'run-help` will invoke man
# for external commands. Default KB shortcut is `Alt+h` or `Esc+h`
unalias run-help 2>/dev/null
autoload -Uz run-help

local cmd
for cmd in git ip openssl p4 sudo svk svn; do
  if (( ${+commands[${cmd}]} )) autoload -Uz run-help-${cmd}
done
unset cmd

####=== PLUGINS ================================================================
# ZIMFW DEFAULTS
zstyle ':zim:zmodule' use 'degit'
ZIM_HOME="${ZDOTDIR}/zim"
# Download ZIMFW plugin manager if missing.
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
  curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing ZIMFW modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZDOTDIR:-${HOME}}/.zimrc" ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize ZIMFW modules.
source "${ZIM_HOME}/init.zsh"

####=== ZSH AUTOSUGGESTIONS OPTIONS (zsh-users/zsh-autosuggestions) ============
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
ZSH_AUTOSUGGEST_MANUAL_REBIND=1        # Disable automatic widget rebinding for performance
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+="forward-blank"

####=== CONFIG P10K PROMPT, IF NOT CONFIG'D YET ================================
# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
