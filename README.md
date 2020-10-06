# projectile-rsync

This is a package used to rsync a local projectile project to remote directory.
To rsync a local project, the ~rsync-remote-base-dir~ should be set. If current
local project is not a vc project, ~rsync-local-project-dir~ must be set.


This was originally based off of [Xingchen Ma's
project-rsync](https://github.com/maxc01/project-rsync), though the package is
slightly slimmed down in both size and functionality and now depends on
projectile

## Usage

The package provides a single command, `rsync-project`. Running it will rsync
the current projectile project to the remote directory defined by
`rsync-remote-base-dir`

The best way to define `rsync-remote-base-dir`is probably in the
`.dir-locals.el` at your local project's root. For example

``` emacs-lisp
;; ~/home/code/my-project
((nil .  ((rsync-remote-base-dir . "user@55.55.55.55:/home/remote-user/my-project"))))
```

Customize `rsync-command-base` to change the flags passed to `rsync` if you want.
The default is `rsync -CavP`, which should be reasonable enough.
