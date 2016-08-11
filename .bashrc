set horizontal-scroll-mode on

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export NDKROOT="$HOME/android-ndk-r10e"

### Add usr/local/bin to PATH so this works with emacs
export PATH="/usr/local/bin:$PATH"

export PS1="\W > "

### Confused why I ever added this gp
alias gp='grep -irlf /dev/stdin . <<<'
alias grepm='grep --include=*.m -irlf /dev/stdin . <<<'

alias gclone='git clone'
alias gis='git status'
alias gif='git fetch'
alias gic='git commit -m'
alias gico='git checkout'
alias gil='git log -n 10'
alias gid='git diff'
alias gia='git add'
alias gib='git branch'
alias gir='git rebase -i'
alias gip='git push origin'
alias gistash='git stash apply'
alias gitapply='git apply --ignore-space-change --ignore-whitespace'
alias gmess='git log --format=%B -n 1'
alias sshoos='ssh hoosbetter-prod.cloudapp.net'

alias figw='rlwrap lein figwheel'
alias ring='lein ring server-headless'

alias mvnskip='mvn -DskipTests -Djacoco.skip=True install'

# To get this working, make sure to install js-beautify
alias beautify='js-beautify /dev/stdin <<<'

# Navigational aliases
alias ..='cd ..'
alias ...='cd ../..'

alias mcflush='echo 'flush_all' | nc localhost 11211'

# Adds color
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
alias ls='ls -Gp'
alias l='ls'

alias mk='mkdir'
alias opengp='vim $(find . -name /dev/stdin <<<)'

# Open ios simulator
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/iOS\ Simulator.app/'

# bundle aliax
alias capdeploy='bundle exec cap deploy'

# Docker alias
alias dc='docker-compose'

# Go alias
alias gor='go run'
alias gob='go build'
alias got='go test'
alias gog='go get'
alias gk='ginkgo'

# Rails aliases
alias rr='rvm reload'
alias ber='bundle exec rake'
alias rs='rails s'
alias spec='bundle exec rspec'
alias zs='zeus rspec'

# Source
alias sbp='source ~/.bash_profile'

export GREP_OPTIONS='--exclude-dir=".git"'

# Elm stuff
alias er='elm reactor'

# Jekyll
alias js='jekyll serve'
