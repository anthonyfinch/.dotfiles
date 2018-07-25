export PYENV_ROOT="$HOME/.pyenv"

LOCAL_BIN=$HOME/.local/bin
NIMBLE_BIN_DIR=$HOME/.nimble/bin
export PATH="$LOCAL_BIN:$NIMBLE_BIN_DIR:$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

. ~/.bashrc
