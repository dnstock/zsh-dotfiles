#
# Scripts for the realty project (September 2024)
#
# This file is loaded AFTER zz_end.zsh because it
# should be deprecated once the project is complete
#

alias cdrealty='cd ~/code/realty'
alias cdbackend='cd ~/code/realty/backend'
alias cdfrontend='cd ~/code/realty/frontend'

alias rr='cdrealty'
alias bb='cdbackend'
alias ff='cdfrontend'

alias coderr='cdrealty && code .'
alias codebb='cdbackend && code .'
alias codeff='cdfrontend && code .'

typeset __myzsh_project_aliases=(cdrealty/rr cdbackend/bb cdfrontend/ff coderr codebb codeff)

print "\033[1;33mRealty Project Aliases:\033[0m"
print -C 10 ${(o)${__myzsh_project_aliases[*]/%/"\033[0m"}/#/"\033[38;5;159m"}
print
