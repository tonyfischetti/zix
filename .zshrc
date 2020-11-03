#############################################
##                                         ##
##    Tony Fischetti's zsh config file!    ##
##                                         ##
#############################################


# path to zsh config folder
ZSH=$HOME/.zsh


# --------------------------------------------------------------- #
# ZSH THINGS

# get completions working
fpath=($ZSH/completions $fpath)
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

# prompt concerns
autoload -U colors && colors
# PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg[red]%}%~ %{$reset_color%}♥ "
# also a nice prompt
# PS1="%F{#79FBD2}%m %F{#FDA879}%~%{$reset_color%} ♥ "
# PS1="%F{#79FBD2}▇▇ %~ ▇▇ %{$reset_color%}"
# PS1="%F{#79FBD2}▇▇▇▇ %~ ▇▇ %{$reset_color%}"
# PS1="%F{#fda878}▇▇▇▇▇▇ %~ ▇▇▇ %{$reset_color%}"
# PS1="%F{#fda878}▇▇▇▇▇▇ %~ ▇ %{$reset_color%}"
PS1="%F{#fda878}▇▇▇▇▇▇ %~ ▇ %{$reset_color%}"
# --------------------------------------------------------------- #



# --------------------------------------------------------------- #
# ENVIRONMENT VARIABLES

export EDITOR="vim"
export GIT_EDITOR="vim"
export BLOCKSIZE=si
export BLOCK_SIZE=si
export ZUNAME=`uname`
export R_HISTFILE=~/.Rhistory
export R_HISTSIZE=1000000
export R_DATATABLE_NUM_PROCS_PERCENT="100"
export R_DATATABLE_NUM_THREADS=4
export R_LIBS=~/local/R_libs/
export R_LIBS_USER=~/local/R_libs/
export RSTUDIO_WHICH_R=/usr/local/bin/R
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

# pretty ls colors
eval $(dircolors)


export PATH="/usr/local/super/bin:$HOME/.zsh/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin/:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

export ZOS=`uname -o`
export ZHOSTNAME=`hostname`

if [[ `whoami` = 'u0_a216' ]]
then
    export ZOS="Android"
fi

# android
if [[ $ZOS = "Android" ]]
then
    export PATH="$HOME/.zsh/override-bin/android:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/bin:/data/data/com.termux/files/sbin:/system/bin:$PATH"
fi

if [[ `hostname` = 'tony-macbook' ]]
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
elif [[ `hostname` = 'betazed' ]]
then
    export FIREFOXPROFILE="~/.mozilla/firefox/b4nptbgd.default-esr"
    export HISTFILE="$HOME/Dropbox/histories/zsh_history-betazed"
    export R_DATATABLE_NUM_THREADS=8
elif [[ `hostname` = 'vertiform-city' ]]
then
    export HISTFILE="$HOME/Dropbox/histories/zsh_history-vertiform-city"
fi

# --------------------------------------------------------------- #



# --------------------------------------------------------------- #
# ALIASES

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
alias fd="fdfind"
alias phav="rsync -Phav"
alias blake="openssl dgst -blake2b512 -hex"
# alias youtube-dl="youtube-dl -f best --add-metadata --write-all-thumbnails --embed-thumbnail --write-info-json --embed-subs --all-subs"
# alias base64="base64 -w 0"

# OS Specific directives
if [[ `uname` = 'Darwin' ]]
then
    # mac specifics
    alias vi="mvim -v"
    alias vim="mvim -v"
    alias vimdiff="mvim -v -d"
    alias macvim="mvim"
    alias awk="gawk"
    alias sed="gsed"
    alias find="gfind"
    alias date="gdate"
    alias shred="gshred"
    alias grep="ggrep -P"
    alias diff="diff --color=always"
    alias pupdate="sudo port selfupdate"
    alias poutdated="port outdated"
    alias pupgrade="sudo port upgrade outdated"
    alias psearch="port search"
    alias pinfo="port info"
    alias pinstall="sudo port install"
    alias puninstall="sudo port uninstall --follow-dependents"
    alias plist="port installed requested"
    alias pclean="sudo port clean --all installed"
    alias psummary="port select --summary"
    alias pnoinactive="sudo port uninstall inactive"
    alias python2='/opt/local/bin/python2.7'
    alias say="say -v Samantha"
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    alias realrm="/bin/rm"
    # alias rm="$HOME/.zsh/bin/rm.sh"
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk12/Contents/Home
fi
if [[ `uname` = 'Linux' ]]
then
    # linux specifics
    alias open="exo-open"
    alias xclip="xclip -selection clipboard"
    alias vi="vim"
    alias python="python3"
    alias pip="pip3"
    alias android-sync="~/.zsh/more-scripts/sync-with-android/sync.lisp"
    alias vtkeys="sudo loadkeys ~/.dix/vt-caps-to-control.kmap"
    alias sgc="sudo grub-customizer"
    alias journal="journalctl"
    alias pupdate="sudo apt update && apt list --upgradable"
    alias pindexupdate="sudo update-apt-xapian-index"
    alias poutdated="apt list --upgradable"
    alias pupgrade="sudo apt upgrade"
    alias psearch="axi-cache search"
    alias pinfo="pinfodebhelper"
    alias pinstall="sudo apt install"
    alias puninstall="sudo apt-get remove"
    alias plist="apt list --installed"
    alias pclean="sudo apt-get clean && sudo apt-get autoclean"
    alias psummary="update-alternatives --get-selections"
    alias pnoinactive="sudo apt-get --purge autoremove"
fi
# --------------------------------------------------------------- #

# --------------------------------------------------------------- #
# DIRECTORY SHORTCUTS
hash -d music="$HOME/Dropbox/music/"
hash -d carlos="$HOME/Dropbox/Carlos IV/"
hash -d backup="$HOME/Dropbox/Carlos IV/Backups/"
hash -d debian="$HOME/Dropbox/Carlos IV/Backups/OS/Debian/"
hash -d zbin="$HOME/.zsh/bin/"
hash -d mscripts="$HOME/.zsh/more-scripts/"
hash -d pictures="$HOME/Dropbox/Carlos IV/Backups/Pictures/"
hash -d os="$HOME/Dropbox/Carlos IV/Backups/OS/"

# if [[ $ZOS = 'Android' ]]
# then
#     hash -d whatever="something"
# fi
# --------------------------------------------------------------- #


# --------------------------------------------------------------- #
# CUSTOM FUNCTIONS

sep(){
    clear;
    clear;
    clear;
    echo "################################################";
    echo "################################################";
    clear;
}

toutf8(){
    iconv -f $1 -t UTF-8 $2 > zzztemp;
    mv zzztemp $2;
}

m4atomp3(){
    ffmpeg -i ${1}.m4a -codec:a libmp3lame -q:a 2 ${1}.mp3;
}

allm4astomp3s(){
    find ${1} -type f | ack '\.m4a$' | parallel --bar -j1 ffmpeg -i {} -codec:a libmp3lame -q:a 2 {.}.mp3;
}

trimmp4(){
    ffmpeg -i ${1} -ss ${2} -to ${3} -c copy ${1}-trimmed.mp4
}

recentcontexts(){
    cat "$1" | awk -F: '{ print $6 }' | tac | eweniq | tac | ack -v '^\s+$'
}

contextsondate(){
    recentcontexts <(fm -m -P -d $1)
}

mcd(){
    mkdir -p "$1"; cd "$1"
}

pinfodebhelper(){
    apt-cache show "$1" | grep -v "^Depends" | grep -v "^Recommends" | grep -v "Suggests" | grep -v "^Breaks" | grep -v "^Conflicts" &&
      echo "" && apt-cache policy "$1" && echo "" && apt-cache depends "$1";
}

# --------------------------------------------------------------- #



# --------------------------------------------------------------- #
# ALIASES TO `exit`

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
alias exot="exit"
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
# --------------------------------------------------------------- #


# this corrects the behavior of debian defaults
[[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
[[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
[[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history
[[ "$terminfo[kcuu1]" == "O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
[[ "$terminfo[kcud1]" == "O"* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history

if [[ $ZOS != 'Android' ]]
then
    [[ "$COLORTERM" == (24bit|truecolor) || "${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
