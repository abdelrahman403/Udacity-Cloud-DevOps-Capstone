# Build app image
docker build -t capstone .

# Run app container
docker run -d -p 8000:80 --name app capstone