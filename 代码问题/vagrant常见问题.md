## 问题描述

```bash

There was an error when attempting to rsync a synced folder.
Please inspect the error message below for more info.

Host path: /cygdrive/d/app/HashiCorp/VagrantFile/kafka/
Guest path: /vagrant
Command: "rsync" "--verbose" "--archive" "--delete" "-z" "--copy-links" "--chmod=ugo=rwX" "--no-perms" "--no-owner" "--no-group" "--rsync-path" "sudo rsync" "-e" "ssh -p 2222 -o LogLevel=FATAL    -o IdentitiesOnly=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i 'D:/app/HashiCorp/VagrantFile/kafka/.vagrant/machines/kafka-manager/virtualbox/private_key'" "--exclude" ".vagrant/" "/cygdrive/d/app/HashiCorp/VagrantFile/kafka/" "vagrant@127.0.0.1:/vagrant"
Error: vagrant@127.0.0.1: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
rsync: connection unexpectedly closed (0 bytes received so far) [sender]
rsync error: error in rsync protocol data stream (code 12) at io.c(231) [sender=3.2.7]

```

## 参考文档

- https://github.com/hashicorp/vagrant/issues/9831