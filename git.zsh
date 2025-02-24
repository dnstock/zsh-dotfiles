#
# Git specific scripts and aliases (aside from oh-my-zsh git plugin)
#

# Aliases to add to the .gitconfig file (e.g. 'git co' => 'git checkout')
git config --global alias.co checkout
git config --global alias.sw switch
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.df diff
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.unstage "reset HEAD --"
git config --global alias.last "log -1 HEAD"
git config --global alias.uncommit "reset --soft HEAD~1"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.fpush "push --force-with-lease"
git config --global alias.fixup "commit --fixup"
git config --global alias.recent "for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads"
git config --global alias.recent-branches "for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads"
git config --global alias.recent-tags "for-each-ref --sort=-committerdate --format='%(refname:short)' refs/tags"
git config --global alias.recent-remotes "for-each-ref --sort=-committerdate --format='%(refname:short)' refs/remotes"
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
git config --global alias.hist-graph "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
git config --global alias.type "cat-file -t"
git config --global alias.dump "cat-file -p"
