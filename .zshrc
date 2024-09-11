
#     ╔══════════════════════════════════════════════════════════╗
#     ║                                                          ║
#     ║            Tony Fischetti's zsh config file!             ║
#     ║                                                          ║
#     ╚══════════════════════════════════════════════════════════╝


# path to zsh config folder
ZSH=$HOME/.zsh


# ╭──────────────────────────────────────────────────────────╮
# │                     STARTING OPTIONS                     │
# ╰──────────────────────────────────────────────────────────╯

# get completions working
fpath=($ZSH/site-functions $fpath)
source $ZSH/completion.zsh
ZSH_COMPDUMP="$HOME/.zcompdump"
autoload -U compinit
compinit -i -d "${ZSH_COMPDUMP}"

# history things
HISTFILE=$HOME/.zsh_history   # will get overwritten
HISTSIZE=10000000000000
SAVEHIST=10000000000000
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# vim key bindings
bindkey -v

# vim like history movements
bindkey '^k' up-history
bindkey '^j' down-history

# I make mistakes
#   but not that many!
#setopt CORRECT_ALL

# ╭──────────────────────────────────────────────────────────╮
# │                   SETTING PS1 / PROMPT                   │
# ╰──────────────────────────────────────────────────────────╯

autoload -U colors && colors
# PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg[red]%}%~ %{$reset_color%}♥ "
# also a nice prompt
# PS1="%F{#79FBD2}%m %F{#FDA879}%~%{$reset_color%} ♥ "
PS1="%F{#fda878}▇▇▇▇▇▇ %~ █ %{$reset_color%}"

# for containers, etc...
if [[ `whoami` = 'marvin' ]]
then
    PS1="%F{#989acc}▇▇▇▇▇▇ %~ █ %{$reset_color%}"
fi


# ╭──────────────────────────────────────────────────────────╮
# │                  ENVIRONMENT VARIABLES                   │
# ╰──────────────────────────────────────────────────────────╯

export EDITOR="nvim"
export GIT_EDITOR="nvim"
export VISUAL="nvim"
export BLOCKSIZE=human
export BLOCK_SIZE=human
export ZUNAME=`uname`
export R_HISTFILE=~/.Rhistory
export R_HISTSIZE=1000000
export R_DATATABLE_NUM_PROCS_PERCENT="100"
export R_DATATABLE_NUM_THREADS=4
export PERL5LIB="$HOME/perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="$HOME/perl5"
export PERL_MB_OPT="--install_base \"~/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
export CMUS_HOME="$HOME/cmus"
export XDG_CONFIG_HOME="$HOME/.config"
export XZ_OPT="-9e --threads=0"
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export SYSTEMD_COLORS=1
export SYSTEMD_PAGER=""
export TIMEFMT="User-mode: %U	Kernel-mode: %S	Wall: %E	Perc: %P"
export PASSWORD_STORE_ENABLE_EXTENSIONS="true"
export DENO_INSTALL="$HOME/.deno"
export NODE_PATH="$HOME/.local/lib/node_modules"
export DOCKER_BUILDKIT=1
export CODEX_ROOT="$HOME/.config/nvim/codex"
export BUN_INSTALL="$HOME/.bun"

export ZOS=`uname -o`
export ZHOSTNAME=`hostname`
export ZME=`whoami`

# pretty ls colors
eval $(dircolors)


# ╭──────────────────────────────────────────────────────────╮
# │                   SETTING INITIAL PATH                   │
# ╰──────────────────────────────────────────────────────────╯

export PATH="$HOME/.cargo/bin:$DENO_INSTALL/bin:$HOME/.zsh/bin:$HOME/bin:$HOME/.local/bin:$BUN_INSTALL/bin:/opt/nvim/bin:/usr/local/bin/:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"


# ╭──────────────────────────────────────────────────────────╮
# │                   OS-SPECIFIC EXPORTS                    │
# ╰──────────────────────────────────────────────────────────╯

if [[ $ZME = 'u0_a468' ]] || [[ $ZME = 'u0_a216' ]] || [[ $ZME = 'u0_a280' ]] || [[ $ZME = 'u0_a225' ]] || [[ $ZME = 'u0a366' ]]
then
    export ZOS="Android"
fi

if [[ $ZOS = "GNU/Linux" ]]
then
    export R_LIBS=~/local/R_libs/
    export R_LIBS_USER=~/local/R_libs/
    export RSTUDIO_WHICH_R=/usr/local/bin/R
elif [[ $ZOS = "Android" ]]
then
    export PATH="$HOME/.zsh/override-bin/android:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/bin:/data/data/com.termux/files/sbin:/system/bin:$PATH"
elif [[ $ZOS = "Darwin" ]]
then
    export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/sqlite/bin:$PATH"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="/usr/local/bin:$PATH"
    export HOMEBREW_NO_ENV_HINTS=1
fi

if [[ `hostname` = 'vulcan' ]]
then
    export FIREFOXPROFILE="~/.mozilla/firefox/q3yebf9y.default-esr"
    export HISTFILE="$HOME/Dropbox/histories/zsh_history-vulcan"
    export R_DATATABLE_NUM_THREADS=6
elif [[ `hostname` = 'nivar' ]]
then
    export FIREFOXPROFILE="~/.mozilla/firefox/bn9pljkw.default-esr"
    export HISTFILE="$HOME/Dropbox/histories/zsh_history-betazed"
    export R_DATATABLE_NUM_THREADS=7
elif [[ `hostname` = 'betazed' ]]
then
    export FIREFOXPROFILE="~/.mozilla/firefox/b4nptbgd.default-esr"
    export HISTFILE="$HOME/Dropbox/histories/zsh_history-betazed"
    export R_DATATABLE_NUM_THREADS=10
elif [[ `hostname` = 'tony-macbook' ]]
then
    export FIREFOXPROFILE="~/Library/ApplicationSupport/Firefox/Profiles/woc2aij6.default"
    export HISTFILE="$HOME/Dropbox/histories/zsh_history-tony-macbook"
elif [[ `hostname` = 'qonos' ]]
then
    export FIREFOXPROFILE="~/.mozilla/firefox/923qfkrp.default-esr"
    export HISTFILE="$HOME/Dropbox/histories/zsh_history-qonos"
elif [[ `hostname` = 'lcars' ]]
then
    export FIREFOXPROFILE="~/Library/ApplicationSupport/Firefox/Profiles/la7bnduf.default-release"
elif [[ `hostname` = 'vertiform-city' ]]
then
    export HISTFILE="$HOME/Dropbox/histories/zsh_history-vertiform-city"
fi


# ╭──────────────────────────────────────────────────────────╮
# │                         ALIASES                          │
# ╰──────────────────────────────────────────────────────────╯

alias tmux="tmux -2"
alias ntmux="sh $HOME/.zsh/bin/start-session.sh "
alias atmux="tmux attach -t "
alias ltmux="tmux list-sessions"
alias ktmux="tmux kill-session -t "
alias tlp="tmux list-panes"
alias gitlog='git log --graph --date-order -C -M --pretty=format:"%C(yellow)%h%C(reset) - %C(bold green)%ad%C(reset) - %C(dim yellow)%an%C(reset) %C(bold red)>%C(reset) %C(white)%s%C(reset) %C(bold red)%d%C(reset) " --abbrev-commit --date=short'
alias Rworkshop="~/.tmux/goodies/Rworkshop"
alias RR="~/.rix/RR"
alias csi="rlwrap csi"
alias hlint="~/.cabal/bin/hlint"
alias srm="srm -D"
alias ncdu="ncdu --color dark"
alias fm="fmthist -m"
alias realrm="/bin/rm"
alias xz="xz --verbose"
alias nl="nl -n ln -s '	' -w 1"
alias split="split -d --additional-suffix='.split'"
alias cut="cut --only-delimited"
alias ls="ls -t --color=auto --quoting-style=literal --time-style=long-iso"
alias dd="dd status=progress"
alias ctop="top -F -R -o cpu"
alias mtop="top -F -R -o rsize"
alias youtube-dl="youtube-dl -f best --add-metadata --embed-subs --all-subs"
alias phav="rsync -Phav"
alias phan="rsync -Phav --no-perms --no-owner --no-group"
alias info="info --vi-keys"
alias blake="openssl dgst -blake2b512 -hex"
alias weather='curl "wttr.in/~Washington+Heights?m&p"'
alias weather2='curl "wttr.in/~Washington+Heights?m&p&format=v2"'
# alias youtube-dl="youtube-dl -f best --add-metadata --write-all-thumbnails --embed-thumbnail --write-info-json --embed-subs --all-subs"
# alias base64="base64 -w 0"


# ╭──────────────────────────────────────────────────────────╮
# │                   OS-SPECIFIC ALIASES                    │
# ╰──────────────────────────────────────────────────────────╯

if [[ `uname` = 'Linux' ]]
then
    # linux specifics
    alias open="exo-open"
    alias xclip="xclip -selection clipboard"
    alias vi="nvim"
    alias vim="nvim"
    alias vimdiff="nvim -d"
    alias pip="pip3"
    alias android-sync="~/.zsh/more-scripts/sync-with-android/sync.lisp"
    alias vtkeys="sudo loadkeys ~/.dix/vt-caps-to-control.kmap"
    alias sgc="sudo grub-customizer"
    alias journal="journalctl -b -ef | ccze -A"
    alias pupdate="sudo nala update && nala list --upgradable"
    alias pindexupdate="sudo update-apt-xapian-index"
    alias poutdated="nala list --upgradable"
    alias pupgrade="sudo nala upgrade"
    alias psearch="axi-cache search"
    alias pinfo="pinfodebhelper"
    alias pinstall="sudo nala install"
    alias puninstall="sudo nala remove"
    alias plist="apt list --installed"
    alias pclean="sudo nala clean && sudo nala autoclean"
    alias psummary="update-alternatives --get-selections"
    alias pnoinactive="sudo apt-get --purge autoremove"
    alias trash=trash-put
    ##### kernel compilation aliases for skeeter
    # alias mrproper='make mrproper'
    # alias kmake='date && make -j12 bindeb-pkg > /dev/null && date'
fi
if [[ $ZOS = "Android" ]]
then
    alias psearch="apt search"
    alias pupdate="sudo apt update && apt list --upgradable"
    alias poutdated="apt list --upgradable"
    alias pupgrade="sudo apt upgrade"
    alias pinstall="sudo apt install"
    alias puninstall="sudo apt remove"
    alias plist="apt list --installed"
    alias pclean="sudo apt clean && sudo apt autoclean"
fi
if [[ `uname` = 'Darwin' ]]
then
    # mac specifics
    alias vi="nvim"
    alias vim="nvim"
    alias vimdiff="nvim -d"
    alias tar="gtar"
    alias pupdate="brew update"
    alias poutdated="brew outdated"
    alias pupgrade="brew upgrade"
    alias psearch="brew search"
    alias pinfo="brew info"
    alias pinstall="brew install"
    alias puninstall="brew uninstall"
    alias plist="brew list"
    alias pclean="brew clean"
    # alias pupdate="sudo port selfupdate"
    # alias poutdated="port outdated"
    # alias pupgrade="sudo port upgrade outdated"
    # alias psearch="port search"
    # alias pinfo="port info"
    # alias pinstall="sudo port install"
    # alias puninstall="sudo port uninstall --follow-dependents"
    # alias plist="port installed requested"
    # alias pclean="sudo port clean --all installed"
    # alias psummary="port select --summary"
    # alias pnoinactive="sudo port uninstall inactive"
fi


# ╭──────────────────────────────────────────────────────────╮
# │                   DIRECTORY SHORTCUTS                    │
# ╰──────────────────────────────────────────────────────────╯

hash -d music="$HOME/Dropbox/music/"
hash -d carlos="$HOME/Dropbox/Carlos IV/"
hash -d backup="$HOME/Dropbox/Carlos IV/Backups/"
hash -d debian="$HOME/Dropbox/Carlos IV/Backups/OS/Debian/"
hash -d zbin="$HOME/.zsh/bin/"
hash -d mscripts="$HOME/.zsh/more-scripts/"
hash -d pictures="$HOME/Dropbox/Carlos IV/Backups/Pictures/"
hash -d os="$HOME/Dropbox/Carlos IV/Backups/OS/"
hash -d vim="$HOME/.config/nvim/"
hash -d obsidian="$HOME/Dropbox/Carlos IV/Obsidian/"

# if [[ $ZOS = 'Android' ]]
# then
#     hash -d whatever="something"
# fi


# ╭──────────────────────────────────────────────────────────╮
# │                     CUSTOM FUNCTIONS                     │
# ╰──────────────────────────────────────────────────────────╯

sep() {
    clear;
    clear;
    clear;
    echo "################################################";
    echo "################################################";
    clear;
}

#  TODO: use tempororary files
toutf8() {
    iconv -f $1 -t UTF-8 $2 > zzztemp;
    mv zzztemp $2;
}

m4atomp3() {
    ffmpeg -i ${1}.m4a -codec:a libmp3lame -q:a 2 ${1}.mp3;
}

allm4astomp3s() {
    find ${1} -type f | ack '\.m4a$' | parallel --bar -j1 ffmpeg -i {} -codec:a libmp3lame -q:a 2 {.}.mp3;
}

mcd() {
    mkdir -p "$1"; cd "$1"
}

mpfour-codec() {
    ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$1"
}

pinfodebhelper() {
    apt-cache show "$1" | grep -v "^Depends" | grep -v "^Recommends" | grep -v "Suggests" | grep -v "^Breaks" | grep -v "^Conflicts" &&
      echo "" && apt-cache policy "$1" && echo "" && apt-cache depends "$1";
}

notejournal() {
    echo "$1" | systemd-cat -t tony-note -p info
}

ducker() {
    local rpath=`realpath $1`
    local spiti=`echo $HOME`
    docker run -v $rpath:/home/tony/host -v $spiti/Desktop:/home/tony/Desktop -it risa
}

cdx() {
    SOME_PATH="$CODEX_ROOT/$($CODEX_ROOT/codex.js $1)" && echo $SOME_PATH && vi "$SOME_PATH"
}


# ╭──────────────────────────────────────────────────────────╮
# │                    ALIASES TO `exit`                     │
# │                  and other corrections                   │
# ╰──────────────────────────────────────────────────────────╯

alias exist="exit"
alias exsiut="exit"
alias exiut="exit"
alias exut="exit"
alias exuit="exit"
alias exot="exit"
alias exirt="exit"
alias exi="exit"
alias exidt="exit"
alias exiot="exit"
alias exsit="exit"
alias exdit="exit"
alias ex9it="exit"
alias exti="exit"
alias ext="exit"
alias exust="exit"
alias exait="exit"
alias exi6t="exit"
alias exidy="exit"
alias exiy="exit"
alias euxt="exit"
alias exity="exit"
alias eixt="exit"
alias e4xist="exit"
alias exis5t="exit"
alias exsiot="exit"
alias exikt="exit"
alias exiust="exit"
alias exitr="exit"
alias eixst="exit"
alias esit="exit"
alias existi="exit"
alias exiuzt="exit"
alias exsi="exit"
alias e4xit="exit"
alias ecxit="exit"
alias eioxat="exit"
alias eixa="exit"
alias eixat="exit"
alias eixdt="exit"
alias eixit="exit"
alias erxiot="exit"
alias erxit="exit"
alias esxit="exit"
alias exaist="exit"
alias existd="exit"
alias existg="exit"
alias exitg="exit"
alias exzist="exit"
alias eist="exit"
alias exiost="exit"
alias exits="exit"
alias eoxt="exit"
alias exoit="exit"
alias eixr="exit"
alias exiit="exit"
alias eexit="exit"
alias exizt="exit"
alias exir="exit"
alias rciy="exit"
alias erixt="exit"
alias ecit="exit"
alias exiast="exit"

alias acl="ack"

alias lsa="ls"
alias lsd="ls"


# ╭──────────────────────────────────────────────────────────╮
# │      this corrects the behavior of debian defaults       │
# ╰──────────────────────────────────────────────────────────╯

[[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
[[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
[[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history
[[ "$terminfo[kcuu1]" == "O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
[[ "$terminfo[kcud1]" == "O"* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history


# ╭──────────────────────────────────────────────────────────╮
# │        HACKS TO GET SSH AND GPG WORKING CORRECTLY        │
# ╰──────────────────────────────────────────────────────────╯

if [[ $ZOS = 'GNU/Linux' ]]
then
    export SSH_AUTH_SOCK="$(find /tmp/ssh* | grep ssh | grep agent 2> /dev/null)"
    export SSH_AGENT_PID="$(ps aux | ack 'ssh-agent$' | awk '{print $2}')"
fi

export GPG_TTY=$(tty)


# ╭──────────────────────────────────────────────────────────╮
# │                   SOURCING EXTENSIONS                    │
# ╰──────────────────────────────────────────────────────────╯

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# iterm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# FZF
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh --cmd cd)"


# ╭──────────────────────────────────────────────────────────╮
# │                           MISC                           │
# ╰──────────────────────────────────────────────────────────╯

if [[ $ZOS != 'Android' ]]
then
    [[ "$COLORTERM" == (24bit|truecolor) || "${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor
fi

