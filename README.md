bootstrap
=========
Quickly bootstrap a project using skeleton.

Installation
------------
No install script for now - sorry.

Put bootstrap.zsh in some safe place, preferably in $PATH.

For efficient use, put following snippet in your interactive shell config (~/.bashrc for Bash, ~/.zshrc for Zsh):
```bash
bs () { eval $(bootstrap.zsh "$@"); }
```
This allows the script to change current directory to that of newly created project.
(If directory with `bootstrap.zsh` is not in $PATH, you'll have to use full path to it in above snippet).

Usage
-----
```bash
bs <project_name> <skeleton> [<project_parent_dir>]
```

Skeletons setup
---------------
Skeletons are [sets of] files that are copied to newly created project directory.
They are to be placed in `~/.config/bootstrap/` directory.

If skeleton is a single file named `<foo>`, it will be copied to project directory with name `<project_name>.<foo>`.

If it's directory, it's content will be recursively copied to project dir.

`skeletons` directory in this repo contains example content of `~/.config/bootstrap/`.
Pull requests with your favourite language/framework project skeletons are welcome!

Dependencies
------------
zsh (Bash port is a TODO)

Copyright&License
-----------------
Copyright (C) 2014 Aleksander Nitecki
MIT License (see LICENSE file)
