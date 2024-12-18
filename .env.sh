export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# NVM (see https://github.com/nvm-sh/nvm#install--update-script)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Python
## Brew
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"

## Pyenv activation
export PYENV_ROOT=$HOME/.pyenv
eval "$(pyenv init -)"

## Poetry
export PATH="/Users/veltindupont/.local/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin # allows your shell to find go binaries
export CGO_ENABLED=1 # required by go to build C based libraries
export CC=/usr/bin/gcc # gcc installation is required for FDB
export CGO_LDFLAGS='-Wl,-rpath,/usr/local/lib' # required for FDB
export GOPRIVATE=github.com/bigbluedisco # Required for private dependancies

# Mysql client
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Rust
source "$HOME/.cargo/env"
