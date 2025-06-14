#!/bin/bash

# # for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# #DockerLinuxDebian=https://download.docker.com/linux/debian
DockerLinuxDebian=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian
# #DockerLinuxDebian=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu

 #osVersion=$(. /etc/os-release && echo "$VERSION_CODENAME")
 #IS_DEBIAN=$(if [ -f /etc/debian_version ]; then echo "true"; else echo "false"; fi)
 #if [ ! IS_DEBIAN  ]; then
 # # 只能是debian 的版本号
osVersion=bookworm
 #fi 

 # Add Docker's official GPG key:
 sudo apt-get update
 sudo apt-get install ca-certificates curl
 sudo install -m 0755 -d /etc/apt/keyrings
 sudo curl -fsSL $DockerLinuxDebian/gpg -o /etc/apt/keyrings/docker.asc
 sudo chmod a+r /etc/apt/keyrings/docker.asc

 # Add the repository to Apt sources:
 echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] $DockerLinuxDebian \
   $osVersion stable" | \
   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 sudo apt-get update

cat << EOF > /etc/docker/daemon.json
{
    "registry-mirrors": [
        "https://docker.m.daocloud.io",
        "https://dockerproxy.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://docker.nju.edu.cn"
    ]
}
EOF

sudo systemctl restart docker

exit 0
sleep 30s
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin



sleep 30s
sudo docker run hello-world

