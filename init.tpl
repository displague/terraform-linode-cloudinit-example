#cloud-config
users:
  - name: ${gh_username}
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']

bootcmd:
 - [ mkdir, /home/${gh_username}/.ssh/ ]
 - [ chown, ${gh_username}:${gh_username}, /home/${gh_username}/.ssh/ ]
 - [ chmod, 0770, /home/${gh_username}/.ssh/ ]
 - [ wget, "https://github.com${gh_username}.keys", -O, /home/${gh_username}/.ssh/authorized_keys ]
 - [ chown, ${gh_username}:${gh_username}, /home/${gh_username}/.ssh/authorized_keys ]

