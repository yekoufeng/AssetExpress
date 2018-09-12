yum install -y nfs-utils

systemctl enable rpcbind.service
systemctl start rpcbind.service

mkdir /mnt/cdn

mount -t nfs 10.240.79.10:/data/cdn /mnt/cdn