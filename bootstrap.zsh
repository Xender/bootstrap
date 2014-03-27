#!/bin/zsh

# You can use this script in your interactive shell config like that:
# bs() { eval $(/path/to/bootstrap.sh "$@"); }

usage () {
	cat >&2 <<EOF
Usage: bootstrap.zsh <project_name> <skeleton> [<project_parent_dir>]

<project_parent_dir> defaults to ~/coding
EOF
}

###

errxit () { # Pun for "ERRor eXIT"
	EXIT_CODE="$1"
	shift

	echo >&2 "$@"
	exit "$EXIT_CODE"
}

### main

exec 3>&1 1>&2 # Redirect stdout to stderr, leaving original stdout at fd 3
# This is to ensure that only things that are explicitely written to &3 will be executed by eval.
case $# in
	3) PROJ_PARENT=$3;;
	2) PROJ_PARENT="$HOME/coding";;
	*) usage; exit 1;;
esac

PROJECT_NAME=$1
SKELETON_NAME=$2

PROJ_DIR="$PROJ_PARENT/$PROJECT_NAME"
SKEL="$HOME/.config/bootstrap/$SKELETON_NAME" #TODO maybe use XDG config dir (which defaults to ~/.config/)?

if ! mkdir "$PROJ_DIR"; then
	[[ -d "$PROJ_DIR" ]] && echo >&3 "cd ${(qq)PROJ_DIR}"
	exit 1
fi

cd "$PROJ_DIR" || errxit 2 "Eh? Cannot cd into just created dir? This shouldn't happen..."

echo >&3 "cd ${(qq)PROJ_DIR}"

if   [[ -d "$SKEL" ]]; then cp -R "$SKEL"/* .                                # "$SKEL" is a directory. Copy it's content recursively.
elif [[ -f "$SKEL" ]]; then cp    "$SKEL"   ./"$PROJECT_NAME.$SKELETON_NAME" # "$SKEL" is a file. Copy it with name <project_name>.<skeleton>
else                        errxit 3 "${(qq)SKEL} - no such skeleton."
fi
