#
# This file is sourced at the end of the shell startup process.
#

# Print a summary of functions and aliases to the console
print "\n\033[1;33mCustom Aliases: ${#__myzsh_aliases}\033[0m $_lsd_note"
print -C 10 ${(o)${__myzsh_aliases[*]/%/"\033[0m"}/#/"\033[38;5;159m"}

print "\n\033[1;33mCustom Functions: ${#__myzsh_functions}\033[0m"
print -C 10 ${(o)${__myzsh_functions[*]/%/"\033[0m"}/#/"\033[38;5;159m"}

print "\nFor more info run:\n\033[1malias_info\033[0m <alias_name> | \033[1mfunction_info\033[0m <function_name>"
print ""

# Clean up global namespace
unset _lsd_note
unset -f _function_exists
unset -f _file_exists
unset -f _add_alias
unset -f _add_function
