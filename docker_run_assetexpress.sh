docker stop AssetExpress
docker rm AssetExpress
docker run -d -p 8089:8089 -p 9092:9092 --name AssetExpress -v $PWD/../logs:/home/AssetExpress/src/AssetExpress/logs -v $PWD/../cdn:/home/AssetExpress/src/AssetExpress/cdn   122.11.58.163:5000/assetexpress:v1
