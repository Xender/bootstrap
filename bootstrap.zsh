#!/bin/zsh

# You can use this script in your interactive shell config like that:
# bs() { eval $(/path/to/bootstrap.sh "$@"); }

errxit () { # Pun for "ERRor eXIT"
	EXIT_CODE="$1"
	shift

	echo >&2 "$@"
	exit "$EXIT_CODE"
}

###

usage () {
	echo >&2 "Usage: bootstrap.zsh <project_name> <skeleton> [<project_parent_dir>]

<project_parent_dir> defaults to ~/coding"
}

### main

case $# in
	3) PROJ_PARENT=$3;;
	2) PROJ_PARENT="$HOME/coding";;
	*) usage; exit 1;;
esac

PROJ_DIR="$PROJ_PARENT/$1"
SKEL="$HOME/.config/bootstrap/$2"

if ! mkdir "$PROJ_DIR"; then
	[[ -d "$PROJ_DIR" ]] && echo "cd ${(qq)PROJ_DIR}"
	exit 1
fi

cd "$PROJ_DIR" || errxit 2 "Eh? Cannot cd into just created dir? This shouldn't happen..."

if [[ -d "$SKEL" ]]; then
	cp "$SKEL"/* .
elif [[ -f "$SKEL" ]]; then
	cp "$SKEL" ./"$1.$2"
else

fi

echo "cd ${(qq)PROJ_DIR}"
