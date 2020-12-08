#!/bin/sh
# This script is somewhat fragile, so no set -e
# With set -e, it halts on l17, presumably when jq returns a nonzero exit code
read -p "What is your GH username? " UNAME
ORG="qiime2"
export ORG
INSTALL_DIR="$HOME/src"
export INSTALL_DIR
# appends 'org' to prevent directory duplication in cases where ORG and REPO have same name
ORGDIR="$HOME/src/${ORG}org"
export ORGDIR

if [[ ! -f ~/src/${ORGDIR} ]]; then
	mkdir ${ORGDIR}
fi

cd $INSTALL_DIR
USER_JSON=$(curl -s "https://${GHTKN}:@api.github.com/users/${UNAME}/repos?per_page=200")
SSH_URLS=$(echo $USER_JSON | jq .[].ssh_url || true; echo "Success" )
echo $SSH_URLS | xargs -n 1 git clone

printf "\nClone completed\n"

ORG_JSON=$(curl -s "https://${GHTKN}:@api.github.com/orgs/${ORG}/repos?per_page=200")
ORG_REPO_NAMES=$(echo $ORG_JSON | jq .[].name)

echo $ORG_REPO_NAMES
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
	fi
	cd ${INSTALL_DIR}
}
export -f add_upstream_remote

printf "\nFunctions defined/exported\n"
# NOTE: This currently segregates and adds upstream remotes ONLY for $ORG repos (qiime2 in this case).
# TODO: Add upstream remotes for all user repos (where upstream repos exist)
# Consider API calls to individual repos
# (e.g. https://stackoverflow.com/questions/18580913/github-api-for-a-forked-repository-object-how-to-get-what-repository-its-fork)
cd $INSTALL_DIR
echo $ORG_REPO_NAMES | xargs -n 1 bash -c 'move_repos "$@"' _
printf "\nRepos moved\n"
echo $ORG_REPO_NAMES | xargs -n 1 bash -c 'add_upstream_remote "$@"' _
printf "\nRemotes added\n"

# Rename aliased org_dir to original org name
mv ${ORGDIR} $HOME/src/${ORG}

# Return to jiggety directory
cd ${INSTALL_DIR}/jiggety 


# The following function and invocation are unused here, but are a good backup in case of emergency
del_upstream_remote () {
	if [ -d "$1" ]; then 
		cd $1
		git remote remove qiime2
		git remote -v
	fi
	cd ${INSTALL_DIR}
}

# echo $ORG_REPO_NAMES | xargs -n 1 bash -c 'del_upstream_remote "$@"' _

