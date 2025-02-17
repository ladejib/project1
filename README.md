# Build the simple app 
docker build -t  saifb/color-app .
docker run -p 5000:5000 -v $(pwd)/logs:/app/logs saifb/color-app

# Additional mapping for app
- job_name: applogs
  static_configs:
  - targets:
      - localhost
    labels:
      job: color_app_logs
      __path__: /home/ubuntu/logs/app.log

# The mount point is wrong cp your own configure files

docker run --name loki -d -v $(pwd)/loki:/mnt/config -p 3100:3100 grafana/loki:3.4.1 -config.file=/mnt/config/loki-config.yaml

