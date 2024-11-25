#
# Homebrew specific scripts and aliases
#

export PATH="/usr/local/sbin:$PATH"

add_alias brewup "brew update; brew cleanup; echo '==> Outdated brews:'; brew outdated --verbose; echo '==> Outdated casks:'; brew outdated --cask --verbose" "Update homebrew and list outdated packages"
add_alias brewupd "brewup; echo '==> Doctor Brew:'; brew doctor" "Update homebrew, list outdated packages, and run brew doctor"
# fix cask: brew uninstall --force brew-cask; brew update

add_alias brewserv "brew services" "Manage homebrew services"

cdbrew() {
    # For formulae
    DIR=$(brew --prefix $1) 2>/dev/null
    # For casks
    if [ $? -ne 0 ]; then
        DIR=$(brew --prefix)/Caskroom/$1
    fi
    echo "cd $DIR"
    cd $DIR
}
add_function cdbrew "Change to install dir of any Homebrew package (ex: cd_brew mysql = cd /usr/local/opt/mysql)"
