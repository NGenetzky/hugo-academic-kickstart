

## Linux with WSL

I use and enjoy [WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/about).

### Tricks

#### WSL as vscode integrated shell

The following setting in vscode (`setting.json`):

```json
    "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\wsl.exe",
```

Reference:

- [how-do-i-use-bash-on-ubuntu-on-windows-wsl-for-my-vs-code-terminal](https://stackoverflow.com/questions/44450218/how-do-i-use-bash-on-ubuntu-on-windows-wsl-for-my-vs-code-terminal)

#### Login as root and change your password.

```
# cmd.exe
# Login as root without password
ubuntu config --default-user root

# root@yourhost
# Delete password for user by deleting hash in "/etc/shadow"
user1:$jsdjksadgfhsdf.saflsdf.sadf.safd:17299:0:99999:7:::
user1::17299:0:99999:7:::

# cmd.exe
# Switch user back
ubuntu config --default-user user1
```

References:

- [reset-the-password-in-ubuntu-linux-bash-in-windows-0](https://askubuntu.com/a/808425)
- [reset-the-password-in-ubuntu-linux-bash-in-windows-1](https://askubuntu.com/a/914832)

### Performance Issues

IO preformance is pretty terrible in WSL. This has quite the negative impact
for Git. It may also impact your terminal if you include git information in
your prompt.

Two ways you can decrease the impact:

1. Disable git information in your terminal prompt.
2. Add Exclusion to your Anti Virus for WSL root directory.

References:

- [Speeding up WSL I/O up than 5x fast + saving a lot of battery life & CPU usage]( https://leandrw.com.br/speedup-wsl-by-disabling-windows-real-time-protection/)

## Git

Git is a must have for any developer. Even if you have it within WSL you may
want to install it for Windows as well. There are a number of Git GUI
clients, but I choose Tortoise Git because that is what they use at work and
it would be good if I got more familiar with it.

- [Git SCM](https://git-scm.com)
- [Git GUI clients](https://www.thewindowsclub.com/git-gui-clients-for-windows)
- [Tortoise Git](https://tortoisegit.org)
