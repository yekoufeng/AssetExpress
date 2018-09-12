docker stop AssetExpress
docker rm AssetExpress
docker run -d -p 8089:8089 -p 9092:9092 --name AssetExpress -v $PWD/src/AssetExpress/logs:/home/AssetExpress/src/AssetExpress/logs   assetexpress:v1
