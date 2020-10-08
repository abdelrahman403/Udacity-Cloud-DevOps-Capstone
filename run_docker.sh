# Build app image
docker build -t app .

# Run app container
docker run -d -p 8000:80 --name app app