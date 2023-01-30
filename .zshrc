# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# If you come from bash you might have to change your $PATH.
export PATH=/home/sammyshear/anaconda3/condabin:/home/sammyshear/.nvm/versions/node/v17.0.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/sammyshear/.yarn/bin:/home/sammyshear/.vim:/home/sammyshear/.local/bin:/home/sammyshear/.cargo/bin:/home/sammyshear/.dotnet/tools:/home/sammyshear/bin:/home/sammyshear/.gem/ruby/1.9.1/bin:/home/sammyshear/.dotnet:/home/sammyshear/.vcpkg/vcpkg:/home/sammyshear/.gvm/gos/go1.18/bin:/home/sammyshear/.local/bin/eww:/home/sammyshear/una
export EDITOR=nvim

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# Can manage everything e.g., other person's zshrc
zplug "tcnksm/docker-alias", use:zshrc

# Disable updates using the "frozen" tag
zplug "k4rthik/git-cal", as:command, frozen:1

# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag

# Supports oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh

# Also prezto
zplug "modules/prompt", from:prezto

# Run a command after a plugin is installed/updated
# Provided, it requires to set the variable like the following:
# ZPLUG_SUDO_PASSWORD="********"
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    hook-build:"make && sudo make install"

# Supports checking out a specific branch/tag/commit
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# Can manage gist file just like other packages
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# Support bitbucket
zplug "b4b4r07/hello_bitbucket", \
    from:bitbucket, \
    as:command, \
    use:"*.sh"

# Rename a command with the string captured with `use` tag
zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'

# Note: To specify the order in which packages should be loaded, use the defer
#       tag described in the next section

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2

# Can manage local plugins
zplug "~/.zsh", from:local

# Load theme file
# zplug romkatv/powerlevel10k, as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias lc="colorls"
alias vim="nvim"
#alias ls="lc"
alias ls="ls --color=auto"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[[ -s "/home/sammyshear/.gvm/scripts/gvm" ]] && source "/home/sammyshear/.gvm/scripts/gvm"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sammyshear/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sammyshear/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sammyshear/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sammyshear/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#eval "$(starship init zsh)"
# (( ! ${+functions[p10k]} )) || p10k finalize

export DENO_INSTALL="/home/sammyshear/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH=/home/sammyshear/.nimble/bin:$PATH
export JAVA_HOME=/opt/jdk-18
export VCPKG_ROOT="/home/sammyshear/.vcpkg/vcpkg"
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/home/sammyshear/.emacs.d/bin

export CLICOLOR=1
export LS_COLORS="$(vivid generate nord)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select

source $(dirname $(gem which colorls))/tab_complete.sh
autoload -U compinit; compinit
eval "$(starship init zsh)"
nerdfetch