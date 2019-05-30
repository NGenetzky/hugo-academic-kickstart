+++
title = "Show and Tell Linux on the Desktop"
date = 2019-05-29T23:30:51-05:00
draft = false
authors = [
  "Nathan Genetzky",
]
tags = [
  "command-line",
  "linux",
  "linux-desktop",
  "linux-tools",
  "meetup",
]
categories = [
  "Linux-Desktop-User-Group",  
]
+++


## Event Details

[Show & Tell Linux on the Desktop](https://www.meetup.com/Linux-Desktop-User-Group/events/261459884/)

- Hosted by Spencer Krum
- From Minnesota Linux Desktop User Group

Our first meetup in a while! 2019 Year of Linux on the Desktop!

We'll do show-and-tell style 'what can you do with Linux' as well as tips and
tricks for Linux on the Desktop. I'm working on locking in a more formal
presentation but haven't confirmed it yet!

## Event Notes

### Linux Tools

- Xtralock - Lock screen from input.
[[1]](https://www.faqforge.com/linux/lock-ubuntu-without-disabling-blanking-screen/)
[[manpage]](http://manpages.ubuntu.com/manpages/xenial/man1/xtrlock.1x.html)

- Yakuake - drop-down terminal emulator.
[[1]](https://kde.org/applications/system/yakuake/)
[[github]](https://github.com/KDE/yakuake)

- fwupd - daemon allows session software to update device firmware on the
local machine.
[[website]](https://fwupd.org/)
[[github]](https://github.com/hughsie/fwupd)

- GNU Recutils - GNU Recutils is a set of tools and libraries to access
human-editable, plain text databases called recfiles.
[[website]](https://www.gnu.org/software/recutils/)
[[video]](https://fscons.org/videos/2011/gnu-recutils-changed-title-and-subject.webm)

- termux - Terminal emulator and Linux environment for Android.
[[1]](https://opensource.com/article/18/5/termux)
[[website]](https://termux.com/)
[[play store]](https://play.google.com/store/apps/details?id=com.termux&hl=en_US)
[[github]](https://github.com/termux/termux-app)
[[wiki]](https://wiki.termux.com/wiki/Main_Page)

- screen - full-screen window manager that multiplexes a physical terminal
between several processes (typically interactive shells).
[[man]](https://linux.die.net/man/1/screen)
[[gnu]](https://www.gnu.org/software/screen/)

- Zsh - extended Bourne shell with a large number of improvements, including
some features of Bash, ksh, and tcsh.
[[website]](https://www.zsh.org/)
[[wiki]](https://en.wikipedia.org/wiki/Z_shell)
[[Oh-My-Zsh]](https://ohmyz.sh/)

- fc - process the command history list.
[[1]](https://www.geeksforgeeks.org/fc-command-linux-examples/)
[[man]](https://www.systutorials.com/docs/linux/man/1p-fc/)
[[wiki]](https://en.wikipedia.org/wiki/Fc_(Unix))

- git-sh-prompt - bash/zsh git prompt support
[[github]](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh)

- ShellCheck - open source static anaylsis tool that automatically finds bugs
in your shell scripts.
[[website]](https://www.shellcheck.net/)
[[github]](https://github.com/koalaman/shellcheck)

### Linux Tricks

We talked about a number of tricks, but not all were recorded

```bash
# Disable shell history from being saved
unset HISTFILE

# Problem 1: Remove execute capability from file which removes most obvious way
# to change execute bit on file.
sudo chmod -x "$(which chmod)"

# Solution 1: Use 'install' to set mode properties
sudo install -m 755 -T '/bin/chmod' '/tmp/chmod'
sudo /tmp/chmod +x '/bin/chmod'
```

### Zsh features

- interactive multiline history
- RPrompt - prompt on right hand side
- Live colorization - actively updates text colors based on text patterns
- zmodlod - loads plugins
