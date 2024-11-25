#
# Node specific scripts and aliases
#

# Automatically load a node version when it finds a .nvmrc file
NVM_AUTOLOAD=1

add_alias nodev "NODE_ENV=dev node" "Start node in DEV environment"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Output a list of aliases and functions that have been loaded from this file
# echo "[loaded:node] nodev"
