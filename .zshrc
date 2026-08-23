USER_NAME_JP="${MIKU_USER_NAME_JP:-イブラヒム}"
USER_NAME_EN="${MIKU_USER_NAME_EN:-Ibrahim}"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Anime Terminal Banner
echo "ദ്ദി(˵ •̀ ᴗ - ˵ ) ✧ Code Session Active" | lolcat

# --- Hatsune Miku Terminal Banner ---
MIKU_CYAN='\033[38;2;57;197;187m'
MIKU_BLUE='\033[38;2;0;190;255m'
MIKU_PINK='\033[38;2;255;93;158m'
TEXT_GLOW='\033[38;2;165;242;243m'
RESET='\033[0m'

echo -e "${MIKU_CYAN}"
cat ~/.config/miku_combined.txt
echo -e "${RESET}"

echo -e "${MIKU_PINK}「 こんにちは！おかえりなさい、${USER_NAME_JP}様！ 」${RESET}"
echo -e "${TEXT_GLOW}(Konnichiwa! Okaerinasai, ${USER_NAME_EN}-san!)${RESET}"
echo -e "${MIKU_BLUE}⚡ [ VOCALOID-01 ACTIVE ] :: Ready to code something legendary. ⚡${RESET}"
echo ""

export PATH="$PATH:$HOME/.local/bin"

[ -f ~/.miku_terminal.sh ] && source ~/.miku_terminal.sh

takeshi() {
    local proj_dir="$HOME/Music/TakeshiProject"

    if [ ! -d "$proj_dir/ascii_frames" ]; then
        echo "Error: ascii_frames not found in $proj_dir"
        return 1
    fi

    (cd "$proj_dir" && python3 play.py)
}

alias scream='cd ~/Music/AiScreamProject && source venv/bin/activate && python main.py'

badapple() {
    local proj_dir="$HOME/Music/BadAppleProject"

    if [ ! -d "$proj_dir/ascii_frames" ]; then
        echo "Error: ASCII frames not found in $proj_dir/ascii_frames"
        return 1
    fi

    tput civis
    clear

    ffplay -nodisp -autoexit -loglevel quiet "$proj_dir/audio.opus" &
    local audio_pid=$!

    trap "kill $audio_pid 2>/dev/null; tput cnorm; clear; return" INT TERM

    for f in $(ls -1 "$proj_dir/ascii_frames/"*.txt | sort -V); do
        printf "\033[H"
        cat "$f"
        sleep 0.0333
    done

    tput cnorm
}

alias play-game="cd ~/miku_adventure && python3 game.py && cd - >/dev/null"

takeshi() {
    local proj_dir="$HOME/Music/TakeshiProject"

    if [ ! -d "$proj_dir/ascii_frames" ]; then
        echo "Error: ascii_frames not found in $proj_dir"
        return 1
    fi

    python3 "$proj_dir/play.py" --dir "$proj_dir" --audio audio.mp3 --fps 15
}

badapple() {
    local proj_dir="$HOME/Music/BadAppleProject"

    if [ ! -d "$proj_dir/ascii_frames" ]; then
        echo "Error: ascii_frames not found in $proj_dir"
        return 1
    fi

    python3 "$HOME/Music/TakeshiProject/play.py" --dir "$proj_dir" --audio audio.opus --fps 30
}
