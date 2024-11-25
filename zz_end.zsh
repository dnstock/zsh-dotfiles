#
# Unset and clean up any temporary variable, files, directories, etc. that were created during the execution of scripts in this directory.
#
# Print any closing messages or reminders to the console.
#

unset -f add_alias
unset -f add_function

print "\n\033[1;33mCustom Aliases: ${#__myzsh_aliases}\033[0m"
print -C 10 ${(o)${__myzsh_aliases[*]/%/"\033[0m"}/#/"\033[38;5;159m"}

print "\n\033[1;33mCustom Functions: ${#__myzsh_functions}\033[0m"
print -C 10 ${(o)${__myzsh_functions[*]/%/"\033[0m"}/#/"\033[38;5;159m"}

print "\nFor more info run:\n\033[1malias_info\033[0m <alias_name> | \033[1mfunction_info\033[0m <function_name>"

print ""
