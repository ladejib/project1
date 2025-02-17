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

- job_name: system
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*log


