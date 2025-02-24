#
# Visual Studio Code specific scripts and aliases
#

# Check if VSC Insiders is installed
if command -v code-insiders >/dev/null 2>&1; then

    # Add an alternate alias to open the stable version of VSC
    if command -v code >/dev/null 2>&1; then
        _add_alias codes $(command -v code) 'Open Visual Studio Code (Stable)'
    fi

    # Switch the default alias to point to the Insiders version
    _add_alias code $(command -v code-insiders) 'Open Visual Studio Code (Insiders)'

fi
