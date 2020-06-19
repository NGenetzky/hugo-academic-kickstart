---
title: "Git-Annex"
authors: [ "nathan-genetzky" ]

event: "Penguins Unbound: June 2020 Meeting"
event_url: "https://www.meetup.com/PenguinsUnbound/events/268428406/"
location: "Jitsi"
# summary: # TODO
# abstract:# TODO
date: 2020-06-20T10:00:00
date_end: 2020-06-20T12:00:00
publishDate: "2020-06-14"

featured: true
# draft: true # TODO: Fix local display of drafts.

tags:
- "bash"
- "git"
- "git-annex"
- "meetup"
- "penguins-unbound"
- "python"
- "sh"
- "shell"

links:
# - name: slides
#   url: "slides/2020-06-20" # TODO
#   icon_pack: fas
#   icon: chalkboard
- name: git-annex
  url: "https://git-annex.branchable.com/"
- name: git-annex-adapter
  url: "https://github.com/NGenetzky/git-annex-adapter/"
---

## Introduction

Nathan will talk about Datalad and Git Annex to members of [PenguinsUnbound][].

### Goal

- Provide a high level introduction of what git-annex is.
- Compare and contrast the different ways git-annex can be used.
- Convince 25% of audience try using git-annex

### From the Author

Introduction to [git-annex][] by the author, [Joey Hess][].

> git-annex allows managing files with git, without checking the file
contents into git. While that may seem paradoxical, it is useful when dealing
with files larger than git can currently easily handle, whether due to
limitations in memory, time, or disk space.
>
> git-annex is designed for git users who love the command line. For everyone
else, the git-annex assistant turns git-annex into an easy to use folder
synchroniser.

### A La Carte

git-annex is primarily known for "managing files with git without checking
the file contents into git". If this particular capability is not desired it
would still be possible to benefit from git-annex or Datalad.

- Datalad is able to be used on git repositories that contain no "annex"
- Many of the auto commit/sync features of git-annex can be used even if the
files are just checked into git.

## git-annex quick start

### Install

- https://git-annex.branchable.com/install/
- https://git-annex.branchable.com/Android/

### Try online

- TODO: Make a "binder" configuration so readers can easily try things out
- https://github.com/trallard/ReproduciblePython
- https://github.com/jupyterlab/jupyterlab-demo/blob/master/binder/postBuild

### Walk-through

- https://git-annex.branchable.com/walkthrough/
- https://git-annex.branchable.com/tips/centralized_git_repository_tutorial/

## git-annex can be used at many different levels

- https://git-annex.branchable.com/workflow/
- Completely automated with git-annex web-app and assistant
- Very manual with direct control on command line via [git][] and [git-annex][] sub-commands

## git-annex configuration

### git config vs git annex config

- Configuration for git-annex will feel natural for those familiar with
configuration for git.
- git-annex can be configured with [git config][] (and the associated
configuration files).
- [git annex config][] has the same syntax as [git config][], but stores
configuration stored within the git repository itself (in the `git-annex`
branch).
- [git config][] overrides configuration set via [git annex config][].

### gitignore

- Most git user's should be relatively familiar the purpose of this file.
- Consider using existing templates (such as with [gitignore.io][]).
- Consider using [gitignore whitelist][] with git-annex repositories.

The following snippet shows the general format for a [gitignore whitelist][]:

```shell
# Ignore everything
*
# But descend into directories
!*/
# Recursively allow files under subtree
!/subtree/**
```

### gitattributes

- Fewer projects utilize [gitattributes][], but many **should** be.
- Consider using existing templates (such as from [gh_gitattributes][]).

The following snippet shows trivial usage for two common file types in C.

```shell
# C Source Code
*.c     text diff=c
# Compiled Dynamic libraries (binary is a macro for -text -diff)
*.so    binary
```

## git-annex handles large files and metadata

### Configure which files go into annex

- https://git-annex.branchable.com/git-annex-matching-expression/
- https://git-annex.branchable.com/tips/largefiles/

### backends - simple

Simple Recommendation: Default to MD5E

- [datalad][] defaults to MD5E backend
- MD5E backend provides content integrity with lowest computation cost.
- MD5E has file extension included in "hash key" avoids subtle issues

How important is Security vs Performance?

- Use "SHA256E" or "SHA512E" to improve security at the cost of performance.

### backends - file ext in hash

How to choose whether to use [backend][git_annex_backend] that includes file ext?

1. Will the same file contents possibly have multiple different file extensions?
2. Do programs rely on the file extension of file (not the symlink to file)?

- File ext. in key causes multiple copies of identical files with different ext.
- File ext. in key results in file at end of symlink having that extension as well.
- See [this bug report][git_annex_fileext_in_key] for more information.

The following steps  demonstrate how unique "hash
keys" are created by SHA256E for 4 files with identical contents:

```shell
$ touch a a.b a.b.c a.b.c.d
$ git-annex add .
add a ok
add a.b ok
add a.b.c ok
add a.b.c.d ok
$ git-annex lookupkey *
SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.b
SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.b.c
SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.c.d
```

### Metadata

- Can only be used with files in "annex", **not** those in "git".
- https://git-annex.branchable.com/metadata/
- https://git-annex.branchable.com/tips/automatically_adding_metadata/

### Using Metadata

- [metadata driven views][git_annex_metadata_driven_views]
- [powerful file matching][git_annex_powerful_file_matching]
- [views demo video](https://git-annex.branchable.com/videos/git-annex_views_demo/)

## git-annex handles git operations and file transfers

### git-annex assistant reduces learning curve

- Can be used with files in "annex" or in "git"
- https://git-annex.branchable.com/assistant/
- https://git-annex.branchable.com/git-annex-webapp/

### Configure which files should move and where

- https://git-annex.branchable.com/preferred_content/
- https://git-annex.branchable.com/preferred_content/standard_groups/
- https://git-annex.branchable.com/location_tracking/

## Datalad handles publication and reproduction at scale

- Can be used with files in "annex" or in "git"
- [IPython Notebook demonstrating git-annex and datalad][ReproduciblePython datalad ipynb]
- [DataLad super-dataset][]
- http://handbook.datalad.org/en/latest/
- https://www.datalad.org/features.html
- [Datalad YODA][]

## Sharing files from git-annex

- https://git-annex.branchable.com/tips/centralized_git_repository_tutorial/

### via SSH on your server or computer

- https://git-annex.branchable.com/tips/remote_webapp_setup/
- https://git-annex.branchable.com/forum/Restricting_git-annex-shell_to_a_specific_repository/

### via HTTP on your server or computer

- TODO

### via Gogs, a git-annex compatible git server

- Gogs on your server or computer
- Gogs on an embedded device
- Gogs provided by [gin.g-node.org][]

### Special Remotes

## Other tools that work with git-annex

### git-annex metadata GUI

- https://git-annex.branchable.com/tips/a_gui_for_metadata_operations/
- https://github.com/alpernebbi/git-annex-metadata-gui
- https://github.com/alpernebbi/git-annex-adapter

### git-annex-adapter

[git-annex-adapter] lets you interact with git-annex from within Python.

> Necessary commands are executed using subprocess and use their batch
versions whenever possible.

### recastex

[recastex][] can take files and podcasts captured by git-annex and re-podcast them.

> With recastex (RECAST annEX) you can now re-podcast the shows you have
locally (to, say, your phone). This reduces network usage (brilliant for
traveling when network costs are expensive) and improves privacy.

> Recasing isn't limited to podcasts. recastex casts all locally available
media.

### albumin

[albumin][] is a script to semi-automatically manage a photograph collection.

> A script to semi-automatically manage a photograph collection using a
git-annex repository. It analyzes the files for their dates and times,
compares them and their identification method to existing data in the
repository, and decides which information to keep.

### pre-commit-annex for extract and exiftool

- https://git-annex.branchable.com/tips/automatically_adding_metadata/
- https://git-annex.branchable.com/tips/automatically_adding_metadata/pre-commit-annex
- http://www.gnu.org/software/libextractor/
- https://exiftool.org/

## Conclusion

### References

From [git-annex][] branchable

- [local_caching_of_annexed_files](https://git-annex.branchable.com/tips/local_caching_of_annexed_files/)

[public git-annex repositories][publicrepos]

- [downloads.kitenet.net][]
- [DataLad super-dataset][]

From [git][] documentation

- [git config][]
- [gitignore][]
- [gitattributes][]

Specific Works

- [ReproduciblePython datalad ipynb][]
- [Effective .gitignore whitelisting patterns][gitignore whitelist] 4 March 2015 By Jason Stitt

Others

- [Joey Hess][]
- [vsc-home][]

[DataLad super-dataset]: http://datasets.datalad.org/
[Datalad YODA]: http://handbook.datalad.org/en/latest/basics/101-127-yoda.html
[Joey Hess]: https://joeyh.name/
[PenguinsUnbound]: /tags/penguins-unbound/
[ReproduciblePython datalad ipynb]: https://github.com/trallard/ReproduciblePython/blob/46c70d06ba6044a44e231fb76009078b3c4c43e0/Datalad.ipynb
[albumin]: https://github.com/alpernebbi/albumin
[datalad]: https://www.datalad.org/
[downloads.kitenet.net]: https://downloads.kitenet.net/
[gh_gitattributes]: https://github.com/alexkaratarakis/gitattributes
[gin.g-node.org]: https://gin.g-node.org/
[git annex config]: https://git-annex.branchable.com/git-annex-config/
[git config]: https://git-scm.com/docs/git-config
[git-annex-adapter]: https://github.com/alpernebbi/git-annex-adapter
[git-annex]: https://git-annex.branchable.com/
[git]: https://git-scm.com/
[git_annex_backend]: https://git-annex.branchable.com/backends/
[git_annex_fileext_in_key]: https://git-annex.branchable.com/bugs/Wrong_backend_extension_in_files_with_multiple_dots/
[git_annex_metadata_driven_views]: https://git-annex.branchable.com/tips/metadata_driven_views/
[git_annex_powerful_file_matching]: https://git-annex.branchable.com/tips/powerful_file_matching/
[gitattributes]: https://git-scm.com/docs/gitattributes
[gitignore whitelist]: https://jasonstitt.com/gitignore-whitelisting-patterns
[gitignore.io]: https://gitignore.io
[gitignore]: https://git-scm.com/docs/gitignore
[publicrepos]: https://git-annex.branchable.com/publicrepos/
[recastex]: https://github.com/stewart123579/recastex
[vsc-home]: https://lists.madduck.net/listinfo/vcs-home
