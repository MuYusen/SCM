# docker info 警告"WARNING: No swap limit support"

```
vim/etc/default/grub

找到 GRUB_CMDLINE_LINUX=""

在双引号里面输入cgroup_enable=memory swapaccount=1

然后执行： sudo update-grub
reboot 搞定。
```