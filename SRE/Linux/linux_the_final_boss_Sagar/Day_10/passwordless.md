Generate ssh-keygen on server-A

ubuntu@ip-10-20-0-205:~$ ls -l ~/.ssh/
total 20
-rw------- 1 ubuntu ubuntu 400 Oct 10 18:48 authorized_keys
-rw------- 1 ubuntu ubuntu 411 Oct 10 18:51 id_ed25519
-rw-r--r-- 1 ubuntu ubuntu 103 Oct 10 18:51 id_ed25519.pub
-rw------- 1 ubuntu ubuntu 978 Oct 10 18:58 known_hosts
-rw-r--r-- 1 ubuntu ubuntu 142 Oct 10 18:58 known_hosts.old
ubuntu@ip-10-20-0-205:~$ sudo cat ~/.ssh/id_ed25519
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBX67yu2ry2Y1RxE6c7wudn7aqvYchzNvWRRTqqrvNYEQAAAJhIUu1qSFLt
agAAAAtzc2gtZWQyNTUxOQAAACBX67yu2ry2Y1RxE6c7wudn7aqvYchzNvWRRTqqrvNYEQ
AAAEAVK/qD32HPt9WPkRfMMiqN8IlOflGH6xqbve+onv+OFFfrvK7avLZjVHETpzvC52ft
qq9hyHM29ZFFOqqu81gRAAAAFXVidW50dUBpcC0xMC0yMC0wLTIwNQ==
-----END OPENSSH PRIVATE KEY-----
ubuntu@ip-10-20-0-205:~$ sudo cat ~/.ssh/id_ed25519.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFfrvK7avLZjVHETpzvC52ftqq9hyHM29ZFFOqqu81gR ubuntu@ip-10-20-0-205

on Server-B

mkdir -p ~/.ssh
echo "paste_the_public_key_here" >> ~/.ssh/authorized_keys    <--- PASTE public key of server-A here.
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

