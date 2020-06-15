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

TODO

### From the Author

Introduction to git-annex by the author, [Joey Hess][], from the [git-annex][].

> git-annex allows managing files with git, without checking the file
contents into git. While that may seem paradoxical, it is useful when dealing
with files larger than git can currently easily handle, whether due to
limitations in memory, time, or disk space.
>
> git-annex is designed for git users who love the command line. For everyone
else, the git-annex assistant turns git-annex into an easy to use folder
synchroniser.

## git-annex quick start

### Install

- https://git-annex.branchable.com/install/
- https://git-annex.branchable.com/Android/

### Try online

- TODO: Make a "binder" configuration so readers can easily try things out
- https://github.com/trallard/ReproduciblePython
- https://github.com/jupyterlab/jupyterlab-demo/blob/master/binder/postBuild

### Walkthrough

- https://git-annex.branchable.com/walkthrough/
- https://git-annex.branchable.com/tips/centralized_git_repository_tutorial/

## git-annex can be used at many different levels

- https://git-annex.branchable.com/workflow/
- Completely automated with git-annex webapp and assistant
- Very manual with direct control on command line via [git][] and [git-annex][] subcommands

## git-annex handles large files and metadata

### configuration

- https://git-annex.branchable.com/git-annex-config/
- https://git-annex.branchable.com/tips/local_caching_of_annexed_files/

### Configure which files go into annex

- https://git-annex.branchable.com/git-annex-matching-expression/
- https://git-annex.branchable.com/tips/largefiles/

### Configure which files should move and where

- https://git-annex.branchable.com/preferred_content/
- https://git-annex.branchable.com/preferred_content/standard_groups/
- https://git-annex.branchable.com/location_tracking/

### backends

- How to choose
- https://git-annex.branchable.com/backends/
- https://git-annex.branchable.com/bugs/Wrong_backend_extension_in_files_with_multiple_dots/

### Metadata

- Can be used with files in "annex" or **not** those in "git"
- https://git-annex.branchable.com/metadata/
- https://git-annex.branchable.com/tips/automatically_adding_metadata/

### misc

- https://git-annex.branchable.com/tips/powerful_file_matching/

## git-annex assistant handles automatic git operations

- Can be used with files in "annex" or in "git"
- https://git-annex.branchable.com/assistant/
- https://git-annex.branchable.com/git-annex-webapp/

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

- https://github.com/alpernebbi/git-annex-adapter

### recastex

- Announcing recastex - (re)podcast from your annex
- https://git-annex.branchable.com/tips/Announcing_recastex_-___40__re__41__podcast__from_your_annex/
- https://github.com/stewart123579/recastex

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

- [DataLad super-dataset][]
- [Joey Hess][]
- [PenguinsUnbound][]
- [ReproduciblePython datalad ipynb][]
- [downloads.kitenet.net][]
- [git-annex][]
- [git][]
- [publicrepos][]
- [vsc-home][]

[DataLad super-dataset]: http://datasets.datalad.org/
[Datalad YODA]: http://handbook.datalad.org/en/latest/basics/101-127-yoda.html
[Joey Hess]: https://joeyh.name/
[PenguinsUnbound]: /tags/penguins-unbound/
[ReproduciblePython datalad ipynb]: https://github.com/trallard/ReproduciblePython/blob/46c70d06ba6044a44e231fb76009078b3c4c43e0/Datalad.ipynb
[albumin]: https://github.com/alpernebbi/albumin
[downloads.kitenet.net]: https://downloads.kitenet.net/
[gin.g-node.org]: https://gin.g-node.org/
[git-annex]: https://git-annex.branchable.com/
[git]: https://git-scm.com/
[publicrepos]: https://git-annex.branchable.com/publicrepos/
[vsc-home]: https://lists.madduck.net/listinfo/vcs-home
