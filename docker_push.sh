./docker_build.sh
docker tag assetexpress:v1 122.11.58.163:5000/assetexpress:v1
docker push 122.11.58.163:5000/assetexpress:v1
cd mysql
./build.sh
./push.sh
#如果数据库方面的东西没修改，这个镜像其实无需每次都传
#docker tag centos/mysql-57-centos7_assetexpress  122.11.58.163:5000/centos/mysql-57-centos7_assetexpress
#docker push 122.11.58.163:5000/centos/mysql-57-centos7_assetexpress
