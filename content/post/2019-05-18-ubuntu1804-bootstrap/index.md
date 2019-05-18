+++
title = "Ubuntu18.04 Bootstrap"
date = 2019-05-18
draft = false

tags = []
categories = []
+++

## Minimal Basic bootstrap

#### Barebone packages

```bash
sudo apt install \ 
    ssh \
    curl \
    # end apt install
```

#### Get public keys

- [ssh_copy_id_from_github.bash](https://raw.githubusercontent.com/NGenetzky/shlib/master/commands/ssh_copy_id_from_github.bash)
- [github.com/ngenetzky.keys](https://github.com/ngenetzky.keys)


## Ansible bootstrap

#### bootstrap

- [robertdebock/ansible-role-bootstrap](https://github.com/robertdebock/ansible-role-bootstrap)


```yaml
---
# playbook/bootstrap.yml
- name: Bootstrap
  hosts: all
  become: yes
  gather_facts: no
  roles:
    - robertdebock.bootstrap
```

#### Ansible provisioning

Now I can use my regular ansible playbooks.

