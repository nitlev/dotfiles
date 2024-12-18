# aliases
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -l --icons=always --group-directories-first'

alias jn='jupyter notebook'

alias gs='git status'
alias gl='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias gft='git fetch --tags'


alias please='sudo $(fc -ln -1)'


# helpers
function cdl {
  cd $1
  ls
}

function mcd {
  mkdir $1
  cd $1
}

# `gc` is a prompt for a clean bigblue-style branch creation and commit.
unalias gc
function gc() {
	if [ -z "$(git diff --name-only --cached)" ]
	then
		echo "No staged changes!"
		return
	fi

	TYPE=$(echo -e "fix\nfeature\ndocs\nstyle\ntest\nchore\nrevert\ndevops" | gum filter)

	SUMMARY=$(gum input --width=120 --prompt "$TYPE/ " --placeholder "Title of this change")
	DESCRIPTION=$(gum write --width=120 --placeholder "Details of this change")

	# Turn into kebab-case.
	KEBABSUMMARY=$(echo "$SUMMARY" | perl -pe 'chop;s/([a-z]+)/lc($1)/ige' | perl -lpe 's/[^a-z0-9]+/-/ig')
	BRANCH="$TYPE/$KEBABSUMMARY"

	# Commit these changes if user confirms
	gum confirm "Create branch "$BRANCH" and commit changes?" && git checkout -b "$BRANCH" && git commit -m "$BRANCH" -m "$DESCRIPTION" && git push --set-upstream origin "$BRANCH"
}


# vim stuff
alias nv='nvim'
alias vrc='nvim ~/.config/nvim/'
alias vdot='nvim ~/.dotfiles/'
