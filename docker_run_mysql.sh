./docker_stop_mysql.sh
docker run --name mysql -d -p 3307:3306 -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=assetexpress -v /var/lib/mysql_docker:/var/lib/mysql  211.159.201.45:5000/mysql:asset_express
