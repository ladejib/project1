# Build the simple app 
docker build -t  saifb/color-app .
docker run -p 5000:5000 -v $(pwd)/logs:/app/logs saifb/color-app
