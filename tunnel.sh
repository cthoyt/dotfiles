#!/usr/bin/env bash
### TODO: make this into a jupyter notebook

# Setup

## Preparing Proxy

# step 1: navigate to fastssh.com
# step 2: click "Select in Europe"
# step 3: click "Create SSH Account France"
# step 4a: record Dropbear Port, OpenSSH Port
# step 4b: fill in Username, Password, and CAPTCHA
# step 4c: click "Create Account"
# step 4d: record Username SSH, Password SSH, Host IP Addr

## Running Proxy

# step 5: run
USERNAME="fastssh.com-UNAME"
ssh -NqD 2001 $USERNAME@fr.serverip.co -p 443

# step 6: type yes, then enter, then password, then enter
### TODO: make ssh non-interactive (use password prompt and automatically background)

# step 7 suspend this process with (CTRL-Z or the inspector). Check with the following command:
bg 1

# step 8: set system preferences > network > advanced > proxies > SOCKS to Host=localhost and Port=2001

# step 9: run this command
TARGETSITE=cthoyt_cthoyt@ssh.phx.nearlyfreespeech.net
ssh -o ProxyCommand='nc -x localhost:2001 %h %p' $TARGETSITE

# step 10: do what comes natural. logout before starting teardown

## Teardown

# check what's running with jobs
jobs

# step 11: bring this job back to foreground with fg, then kill it w/ CTRL-C
fg 1

jobs # should show nothing now
killall ssh # just in case

# step 12: go back into system preferences and turn off SOCKS proxy

# Last login: Wed Jul  8 15:42:48 on ttys000
# 
# [501][cthoyt@dhcp-892bcf3d:~]$ ssh -NqD 2001 fastssh.com-nucd4@fr.serverip.co -p 443
# 
# The authenticity of host '[fr.serverip.co]:443 ([195.154.7.110]:443)' can't be established.
# RSA key fingerprint is ab:0f:cd:fb:0a:29:42:49:89:56:0f:d3:2a:e0:5c:bc.
# Are you sure you want to continue connecting (yes/no)? yes
# fastssh.com-nucd4@fr.serverip.co's password: 
# *****

# [1]+  Stopped                 ssh -NqD 2001 fastssh.com-nucd4@fr.serverip.co -p 443
# [502][cthoyt@dhcp-892bcf3d:~]$ bg 1
# [1]+ ssh -NqD 2001 fastssh.com-nucd4@fr.serverip.co -p 443 &
# 
# Now, go to system settings. SOCKS proxy. localhost and port 2001
# 
# [503][cthoyt@dhcp-892bcf3d:~]$ ssh -o ProxyCommand='nc -x localhost:2001 %h %p' cthoyt_cthoyt@ssh.phx.nearlyfreespeech.net
# cthoyt_cthoyt@ssh.phx.nearlyfreespeech.net's password: 
# *******
# 
# [cthoyt /home/public]$ ls
# img		index.html	pinwheel.html
# [cthoyt /home/public]$ ^C
# [cthoyt /home/public]$ jobs
# [cthoyt /home/public]$ exit
# logout
# Connection to ssh.phx.nearlyfreespeech.net closed.
# [504][cthoyt@dhcp-892bcf3d:~]$ jobs
# [1]+  Running                 ssh -NqD 2001 fastssh.com-nucd4@fr.serverip.co -p 443 &
# [505][cthoyt@dhcp-892bcf3d:~]$ fg 1
# ssh -NqD 2001 fastssh.com-nucd4@fr.serverip.co -p 443
# ^C[506][cthoyt@dhcp-892bcf3d:~]$ jobs
# [507][cthoyt@dhcp-892bcf3d:~]$ killall ssh
# No matching processes belonging to you were found
# [508][cthoyt@dhcp-892bcf3d:~]$ ls
# Applications/ Documents/    Dropbox/      Library/      Music/        Public/
# Desktop/      Downloads/    Google Drive/ Movies/       Pictures/     dev/
# [509][cthoyt@dhcp-892bcf3d:~]$ lsa
# -bash: lsa: command not found
# [510][cthoyt@dhcp-892bcf3d:~]$ 



