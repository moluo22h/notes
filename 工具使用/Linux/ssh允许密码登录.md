# ssh运行密码登录

1. 编辑/etc/ssh/sshd_config

   ```bash
   vi /etc/ssh/sshd_config
   ```

2. 将文件中的PasswordAuthentication no改为PasswordAuthentication yes

   ```bash
   PasswordAuthentication yes
   ```

3. 保存退出/etc/ssh/sshd_config后，重启sshd服务

   ```bash
   systemctl restart sshd.service
   ```

SSH免密登录

```bash
ssh-keygen -t rsa
ssh-copy-id -i /home/deploy/.ssh/id_rsa.pub root@192.168.61.64	
```

