#
# Initialize custom variables and functions for use in other scripts in this directory.
#
# NOTE: Private functions and variables in
#       the global scope should be prefixed
#       with __myzsh_ to avoid conflicts with
#       other scripts.
#

typeset -A __myzsh_aliases_info_cmd
typeset -A __myzsh_aliases_info_desc
typeset -A __myzsh_functions_info_desc

typeset -a __myzsh_aliases
typeset -a __myzsh_functions

add_alias() {
    local name=$1
    local cmd=$2
    local description=$3
    alias $name=$cmd
    __myzsh_aliases+=($name)
    __myzsh_aliases_info_cmd[$name]=$cmd
    __myzsh_aliases_info_desc[$name]=$description
}

alias_info() {
    local name="$1"
    if [[ -z "$name" || "$name" == "-h" || "$name" == "--help" ]]; then
        print "Usage: alias_info <name>"
        print "Available Aliases: ${#__myzsh_aliases}"
        print -C 10 ${(o)__myzsh_aliases}
        return 0
    elif [[ "$name" == "-a" || "$name" == "--all" ]]; then
        print "[ Custom Aliases: ${#__myzsh_aliases} ]\n"
        for alias in ${__myzsh_aliases[*]}; do
            print "Alias: \033[1m${alias}\033[0m"
            print "Command: \033[38;5;159m${__myzsh_aliases_info_cmd[$alias]}\033[0m"
            print "Description: \033[38;5;156m${__myzsh_aliases_info_desc[$alias]}\033[0m"
            print ""
        done
    elif [[ -n "${__myzsh_aliases[(r)$name]}" ]]; then
        print "Alias: \033[1m${name}\033[0m"
        print "Command: \033[38;5;159m${__myzsh_aliases_info_cmd[$name]}\033[0m"
        print "Description: \033[38;5;156m${__myzsh_aliases_info_desc[$name]}\033[0m"
    else
        print "Alias not found: \033[1m${name}\033[0m"
        print "For a list of available aliases, run: alias_info -h"
        return 1
    fi
}

add_function() {
    local name=$1
    local description=$2
    __myzsh_functions+=($name)
    __myzsh_functions_info_desc[$name]=$description
}

function_info() {
    local name="$1"
    if [[ -z "$name" || "$name" == "-h" || "$name" == "--help" ]]; then
        print "Usage: function_info <function_name>"
        print "Available Functions: ${#__myzsh_functions}"
        print -C 10 ${(o)__myzsh_functions}
        return 0
    elif [[ "$name" == "-a" || "$name" == "--all" ]]; then
        print "[ Custom Functions: ${#__myzsh_functions} ]\n"
        for function in ${__myzsh_functions[*]}; do
            print "Function: \033[1m${function}\033[0m"
            print "Description: \033[38;5;156m${__myzsh_functions_info_desc[$function]}\033[0m"
            print ""
        done
    elif [[ -n "${__myzsh_functions[(r)$name]}" ]]; then
        print "Function: \033[1m${name}\033[0m"
        print "Description: \033[38;5;156m${__myzsh_functions_info_desc[$name]}\033[0m"
    else
        print "Function not found: \033[1m${name}\033[0m"
        print "For a list of available functions, run: function_info -h"
        return 1
    fi
}
