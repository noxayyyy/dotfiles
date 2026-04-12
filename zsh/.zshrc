export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="refined"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

local cmd_alias=""

# Reveal Executed Alias
alias_for() {
  [[ $1 =~ '[[:punct:]]' ]] && return
  local search=${1}
  local found="$( alias $search )"
  if [[ -n $found ]]; then
    found=${found//\\//} # Replace backslash with slash
    found=${found%\'} # Remove end single quote
    found=${found#"$search="} # Remove alias name
    found=${found#"'"} # Remove first single quote
    echo "${found} ${2}" | xargs # Return found value (with parameters)
  else
    echo ""
  fi
}

expand_command_line() {
  first=$(echo "$1" | awk '{print $1;}')
  rest=$(echo ${${1}/"${first}"/})

  if [[ -n "${first//-//}" ]]; then # is not hypen
    cmd_alias="$(alias_for "${first}" "${rest:1}")" # Check if there's an alias for the command
    if [[ -n $cmd_alias ]] && [[ "${cmd_alias:0:1}" != "." ]]; then # If there was and not start with dot
      echo "${T_GREEN}❯ ${T_YELLOW}${cmd_alias}${F_RESET}" # Print it
    fi
  fi
}

pre_validation() {
  [[ $# -eq 0 ]] && return                    # If there's no input, return. Else...
  expand_command_line "$@"
}

# yazi change pwd
y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# user added aliases

# user added lines
# export PATH="$PATH:$HOME/gaomon/gaomontablet/:$HOME/.config/rofi/scripts"
# eval "$(starship init zsh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source <(fzf --zsh)


# aliases
alias dnf="dnf5"
alias ls="eza --color=always --tree --level=1 --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias bt="bluetoothctl"

# alias prevalidation check
alias addPreValHook="add-zsh-hook preexec pre_validation"
alias delPreValHook="add-zsh-hook -d preexec pre_validation"

# dpms
alias displayAlwaysOn="xset s off -dpms"

# cmatrix
alias cmatrix="cmatrix -B -u 7 -C cyan"

# save screenshot > $FILE
alias savess="xclip -selection clipboard -t image/png -o"

export PATH=/home/mfareed/.local/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/mfareed/.dotnet/tools:/home/mfareed/.cargo/bin

[ -f "/home/mfareed/.ghcup/env" ] && . "/home/mfareed/.ghcup/env" # ghcup-env
