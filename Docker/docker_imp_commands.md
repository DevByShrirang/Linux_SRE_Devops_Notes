docker build -t my-app:1.2 .
docker images
docker tag my-app:1.2 shrirang451/my-app:1.2
docker push shrirang451/my-app:1.2 

docker run -d -p 8080:8080 --name my-app shrirang451/my-app:1.2
