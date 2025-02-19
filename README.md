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

# Gremlin Installation verification
# REF: https://www.gremlin.com/docs/reliability-management-quick-start-guide
gremlin check auth

# Replace localhost with the IP address of app (Prometheus.yaml)

sed -i 's/localhost/<IP_Address>/g' /tmp/prometheus/prometheus.yaml