docker stop AssetExpress
docker rm AssetExpress
#docker run -d -p 80:8089 -p 9092:9092 --name AssetExpress -v $PWD/../logs:/home/AssetExpress/src/AssetExpress/logs -v $PWD/../htdocs:/home/AssetExpress/src/AssetExpress/cdn   122.11.58.163:5000/assetexpress:v1
#docker run -d  --name AssetExpress --net=host -v $PWD/../logs:/home/AssetExpress/src/AssetExpress/logs -v $PWD/../htdocs:/home/AssetExpress/src/AssetExpress/cdn  -v $PWD/../conf:/home/AssetExpress/src/AssetExpress/conf  122.11.58.163:5000/assetexpress:v1
docker run -d -p 8089:8089 -p 9092:9092 --name AssetExpress -v $PWD/../logs:/home/AssetExpress/src/AssetExpress/logs -v $PWD/../htdocs:/home/AssetExpress/src/AssetExpress/cdn -v $PWD/../conf:/home/AssetExpress/src/AssetExpress/conf  211.159.201.45:5000/assetexpress:v1
