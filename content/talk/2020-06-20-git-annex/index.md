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
- Provide a plethora of resources for future investigation

### Background on the Author

[Joey Hess][] really likes git.

- [etckeeper][] is a collection of tools to keep track of /etc/ in Git.
- [Ikiwiki][] is a wiki compiler that stores pages and history in Git.
- [git-annex][] manages files with git, without checking contents into git.

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

## git-annex can be used in many different ways

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
- [automatically adding metadata][git_annex_automatically_adding_metadata]

Using metadata with views:

- [metadata driven views][git_annex_metadata_driven_views]
- [views demo video](https://git-annex.branchable.com/videos/git-annex_views_demo/)

### Find annex files

- [powerful file matching][git_annex_powerful_file_matching]
- [location tracking](https://git-annex.branchable.com/location_tracking/)
can be utilized with `--in`
- Use `-(` and `-)` to group expressions
- Use `--and`, `--or`, and `--not` to alter logic

```shell
# Find mp3 files in either of two repositories that have less than 3 copies:
git annex find \
    --not --exclude '*.mp3' --and \
    -\( --in usbdrive --or --in archive -\) --and \
    --not --copies 3
```

## git-annex automates git operations and file transfers

### git-annex can automate the movement of files

- Can be used with files in "annex" or in "git"
- git-annex can `--auto` get/drop/copy/move files based on rules
- git-annex sync choose an action (get/drop/copy/move) based on rules for files
- [assistant][git_annex_assistant] is a daemon that can automate operations between remotes
- [webapp][git_annex_webapp] allows everything to be configured via a GUI

### preferred content - Configure which files should move and where

- [preferred_content](https://git-annex.branchable.com/preferred_content/)
  - [git-annex-preferred-content](https://git-annex.branchable.com/git-annex-preferred-content/)
  - [standard_groups](https://git-annex.branchable.com/preferred_content/standard_groups/)
  - content expressions (recommend starting with and tweaking a standard group)
- get/drop/copy/move can use via `--auto` flag

These commands can be used to help identify what would happen with the next
`annex sync --content`:

```shell
annex find --in . --want-drop
annex find --not --in . --want-get
```

### preferred content - Practical example

Consider the path of files from a camera to a website in a small company.

Remotes:

- `(A)` camera is "source" of photos
- `(B)` laptop connected to camera is "client"
- `(C)` external hard-drive is "archive"
- `(D)` web server is "public"

Flow of files

- `(A)->(B)`: Always
- `(B)->(C)`: if file is placed in "archive/" directory
- `(B)->(D)`: if file is placed in "public/" directory

## Sharing files from git-annex with git

### via git on computer in your network

via SSH

- [simple git server][git_annex_on_your_own_server]
- [webapp setup][git_annex_remote_webapp_setup]
- [Restricting git-annex-shell to a specific repository](https://git-annex.branchable.com/forum/Restricting_git-annex-shell_to_a_specific_repository/)

via HTTP

- A web server configured to host a git repository can also be used
- http git remote is read-only
- [setup a public repository on a web site][git_annex_setup_a_public_repository_on_a_web_site]

### via Gogs, a git-annex compatible git server

- Gogs on your server or computer [wiki][gin_wiki_in_house] and [gin@home on github][gh_gin_at_home].
- Gogs provided by [gin.g-node.org][]
- Gogs on an embedded device with [Balena][]
  - My fork of has a minimal example (branch:
  [balena/ginathome][gh_gin_balena_at_home],
  [commit](https://github.com/NGenetzky/gogs/commit/55732c46e525f4c13c437cb63be785d7cb453988))

## Sharing files from git-annex with Special Remotes

- Can only be used with files in "annex", **not** those in "git".
- [Special Remotes][git_annex_special_remotes] allows files to be annexed in a
large variety of ways.
- Almost all special remotes support
[encryption](https://git-annex.branchable.com/encryption/).

### Special Remotes - Cloud services

- [git-lfs][gasr_gitlfs] (also see [storing_data_in_git-lfs][]).
- [rclone][gasr_rclone] has support for a lot of services.
- [S3][gasr_S3] interface is broadly implemented.

### Special Remotes - local usage

File-system based remotes are great for local servers or USB drives

- [directory][gasr_directory] for local use
- [rsync][gasr_rsync] for use over a network
- [adb][gasr_adb] for use with android device
- The directory and rsync special remotes intentionally use the same layout.
So the same directory could be set up as both types of special remotes.
([comment by Joey H][gasr_directory_comment])
- The main reason to use this rather than a bare git repo is that it supports
encryption. ([comment by Joey H][gasr_directory_comment])

### Special Remotes - Bring your Own

Powerful [external special remotes][gasr_external]

- Write in Python with [AnnexRemote][gh_annex_remote].
- Write in shell script based on [example.sh][gasr_external_example].

Simple [hook][gasr_hook] commands

- Very simple to write, but less robust than external special remotes

## Other tools that work with git-annex

### Datalad handles publication and reproduction at scale

- Can be used with files in "annex" or in "git"
- [IPython Notebook demonstrating git-annex and datalad][ReproduciblePython datalad ipynb]
- [DataLad super-dataset][]
- [handbook for datalad](http://handbook.datalad.org/en/latest/)
- [datalad features](https://www.datalad.org/features.html)
- [Datalad YODA][] Best practices for data analyses in a dataset


[DataLad vs Git/Git-annex for modular data management](https://www.youtube.com/watch?v=Yrg6DgOcbPE):

> This talks demos how DataLad, utilizing these tools, aids workflows
involving nested repositories (git submodules), and argues that such
workflows are highly suitable for data management needs in science.

### git-annex metadata GUI

[git-annex-metadata-gui][] provides a graphical interface to the metadata
functionality of git-annex.

### git-annex-adapter - use from python

[git-annex-adapter] lets you interact with git-annex from within Python.

> Necessary commands are executed using subprocess and use their batch
versions whenever possible.

### recastex - manage podcasts

[recastex][] can take files and podcasts captured by git-annex and re-podcast them.

> With recastex (RECAST annEX) you can now re-podcast the shows you have
locally (to, say, your phone). This reduces network usage (brilliant for
traveling when network costs are expensive) and improves privacy.
>
> Recasting isn't limited to podcasts. recastex casts all locally available
media.

### albumin - manage photos

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

### AnnexRemote

[AnnexRemote][gh_annex_remote] is a helper module to easily develop special
remotes for git annex.

> AnnexRemote handles all the protocol stuff for you, so you can focus on the
remote itself. It implements the complete external special remote protocol
and fulfils all specifications regarding whitespaces etc. This is ensured by
an excessive test suite. Extensions to the protocol are normally added within
hours after they've been published.

### Firefox plugin FlashGot - download manager

- [Using Git-annex as a web browsing assistant](https://git-annex.branchable.com/tips/Using_Git-annex_as_a_web_browsing_assistant/)
- [FlashGot](https://flashgot.net/)

## Conclusion

### References

From [git-annex][] branchable

- [local caching of annexed files][git_annex_local_caching_of_annexed_files]

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

[Balena]: https://www.balena.io/
[DataLad super-dataset]: http://datasets.datalad.org/
[Datalad YODA]: http://handbook.datalad.org/en/latest/basics/101-127-yoda.html
[Ikiwiki]: https://ikiwiki.info/
[Joey Hess]: https://joeyh.name/
[PenguinsUnbound]: /tags/penguins-unbound/
[ReproduciblePython datalad ipynb]: https://github.com/trallard/ReproduciblePython/blob/46c70d06ba6044a44e231fb76009078b3c4c43e0/Datalad.ipynb
[albumin]: https://github.com/alpernebbi/albumin
[datalad]: https://www.datalad.org/
[downloads.kitenet.net]: https://downloads.kitenet.net/
[etckeeper]: https://etckeeper.branchable.com/
[gasr_S3]: http://git-annex.branchable.com/special_remotes/S3
[gasr_adb]: http://git-annex.branchable.com/special_remotes/adb
[gasr_directory]: http://git-annex.branchable.com/special_remotes/directory
[gasr_directory_comment]: http://git-annex.branchable.com/special_remotes/directory/#comment-93de27e6987c72bc222dbdae2a076f79
[gasr_external]: http://git-annex.branchable.com/special_remotes/directory
[gasr_external_example]: https://git-annex.branchable.com/special_remotes/external/example.sh/
[gasr_gitlfs]: http://git-annex.branchable.com/special_remotes/git-lfs
[gasr_hook]: http://git-annex.branchable.com/special_remotes/hook
[gasr_rclone]: http://git-annex.branchable.com/special_remotes/rclone
[gasr_rsync]: http://git-annex.branchable.com/special_remotes/rsync
[gh_annex_remote]: https://github.com/Lykos153/AnnexRemote
[gh_gin_at_home]: https://github.com/G-Node/gogs/tree/gin%40home
[gh_gin_balena_at_home]: https://github.com/NGenetzky/gogs/tree/balena/ginathome
[gh_gitattributes]: https://github.com/alexkaratarakis/gitattributes
[gin.g-node.org]: https://gin.g-node.org/
[gin_in_house]: https://gin.g-node.org/G-Node/Info/wiki/In+House
[git annex config]: https://git-annex.branchable.com/git-annex-config/
[git config]: https://git-scm.com/docs/git-config
[git-annex-adapter]: https://github.com/alpernebbi/git-annex-adapter
[git-annex-metadata-gui]: https://github.com/alpernebbi/git-annex-metadata-gui
[git-annex]: https://git-annex.branchable.com/
[git]: https://git-scm.com/
[git_annex_assistant]: https://git-annex.branchable.com/assistant/
[git_annex_automatically_adding_metadata]: https://git-annex.branchable.com/tips/automatically_adding_metadata/
[git_annex_backend]: https://git-annex.branchable.com/backends/
[git_annex_fileext_in_key]: https://git-annex.branchable.com/bugs/Wrong_backend_extension_in_files_with_multiple_dots/
[git_annex_local_caching_of_annexed_files]: https://git-annex.branchable.com/tips/local_caching_of_annexed_files/
[git_annex_metadata_driven_views]: https://git-annex.branchable.com/tips/metadata_driven_views/
[git_annex_on_your_own_server]: https://git-annex.branchable.com/tips/centralized_git_repository_tutorial/on_your_own_server/
[git_annex_powerful_file_matching]: https://git-annex.branchable.com/tips/powerful_file_matching/
[git_annex_remote_webapp_setup]: https://git-annex.branchable.com/tips/remote_webapp_setup/
[git_annex_setup_a_public_repository_on_a_web_site]: https://git-annex.branchable.com/tips/setup_a_public_repository_on_a_web_site/
[git_annex_special_remotes]: https://git-annex.branchable.com/special_remotes/
[git_annex_watch]: https://git-annex.branchable.com/git-annex-watch/
[git_annex_webapp]: https://git-annex.branchable.com/git-annex-webapp/
[gitattributes]: https://git-scm.com/docs/gitattributes
[gitignore whitelist]: https://jasonstitt.com/gitignore-whitelisting-patterns
[gitignore.io]: https://gitignore.io
[gitignore]: https://git-scm.com/docs/gitignore
[publicrepos]: https://git-annex.branchable.com/publicrepos/
[recastex]: https://github.com/stewart123579/recastex
[storing_data_in_git-lfs]: https://git-annex.branchable.com/tips/storing_data_in_git-lfs/
[vsc-home]: https://lists.madduck.net/listinfo/vcs-home
