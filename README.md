SignagePi
=================================

Simple Picture Player based on systemd and mvp

# Services
- signagePi_show.service
- signagePi_sync.timer
    - signagePi_sync.service
        - mnt-sambaShare.mount

# Configuration
- add samba settings in `hosts.ini` file

# Installation
via ansible playbook
```bash
ansible-playbook -i hosts.ini installPROD.yml -v
```
