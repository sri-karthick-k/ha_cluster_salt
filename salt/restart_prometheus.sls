daemon_reload:
  cmd.run:
    - name: systemctl daemon-reload
    - reload: True

restart_prometheus:
  service.running:
    - name: prometheus
    - enable: True
    - reload: True
