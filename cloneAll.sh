#!/bin/sh
set -e

# TODO: segregate q2 repos into separate subdir
printf "What is your GH username?"
read UNAME
ORG="qiime2"
export ORG
INSTALL_DIR="$HOME/src"
export INSTALL_DIR
# appends 'org' to prevent directory duplication in cases where ORG and REPO have same name
ORGDIR="$HOME/src/${ORG}org"
export ORGDIR

if [[ ! -f ~/src/${ORGDIR} ]]; then
	mkdir ~/src/${ORGDIR}
fi

# TODO: can this line be deleted?
cd $INSTALL_DIR
USER_JSON=$(curl -s "https://${GHTKN}:@api.github.com/users/${UNAME}/repos?per_page=200")
SSH_URLS=$(echo $USER_JSON | jq .[].ssh_url)
echo $SSH_URLS | xargs -n 1 git clone
# TODO: can this line be deleted?
cd ${INSTALL_DIR}/jiggety

ORG_JSON=$(curl -s "https://${GHTKN}:@api.github.com/orgs/${ORG}/repos?per_page=200")
ORG_REPO_NAMES=$(echo $ORG_JSON | jq .[].name)

# TODO: can this line be deleted?
cd $INSTALL_DIR

# Takes a list of repo names from an org ( or maybe a user ) and segregates them into an org folder
# Must be called from within the directory containing listed repositories
move_repos () {
        if [ -d "$1" ]; then
                mv $1 ${ORGDIR}
        fi
}
export -f move_repos

# Takes a list of repo names from an org (or maybe a user?) and adds an upstream remote
# Must be called from within the directory containing listed repositories
add_upstream_remote () {
	cd ${ORGDIR}
	if [ -d "$1" ]; then 
		cd $1
		git remote add qiime2 "https://github.com/${ORG}/$1"
		git remote -v
		cd ${INSTALL_DIR}
	fi
}
export -f add_upstream_remote

# NOTE: This currently segregates and adds upstream remotes ONLY for $ORG repos (qiime2 in this case).
# TODO: Refactor to add upstream remotes for all user repos (where upstream repos exist)
# Consider API calls to individual repos
# (e.g. https://stackoverflow.com/questions/18580913/github-api-for-a-forked-repository-object-how-to-get-what-repository-its-fork)
echo $ORG_REPO_NAMES | xargs -n 1 bash -c 'move_repos "$@"' _
echo $ORG_REPO_NAMES | xargs -n 1 bash -c 'add_upstream_remote "$@"' _

# Rename aliased org_dir to original org name
mv ${ORGDIR} $HOME/src/${ORG}
ORGDIR="$HOME/src/${ORG}org"
echo ORGDIR

cd ${INSTALL_DIR}/jiggety 


# The following function and invocation are unused here, but are a good backup in case of emergency
del_upstream_remote () {
	if [ -d "$1" ]; then 
		cd $1
		git remote remove qiime2
		git remote -v
		cd ${INSTALL_DIR}
	fi
}

# echo $ORG_REPO_NAMES | xargs -n 1 bash -c 'del_upstream_remote "$@"' _

