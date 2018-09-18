#./docker_build.sh
./docker_run_mysql.sh
#docker run --name mysql -d -p 3307:3306 -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=assetexpress -v /var/lib/mysql_docker:/var/lib/mysql  mysql:asset_express
sleep 30s
#-v /mnt/cdn:/go/src/AssetExpress/cdn
#docker run -d -p 8089:8089 -p 9092:9092 --name AssetExpress -v $PWD/src/AssetExpress/logs:/go/src/AssetExpress/logs  assetexpress:v1
#docker run -d -p 8089:8089 -p 9092:9092 --name AssetExpress -v $PWD/src/AssetExpress/logs:/home/AssetExpress/src/AssetExpress/logs   assetexpress:v1
./docker_run_assetexpress.sh
