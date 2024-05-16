# Install required packages
grafana_packages:
  pkg.installed:
    - pkgs:
      - adduser
      - libfontconfig1
      - musl

# Download and install Grafana Enterprise
grafana_install:
  cmd.run:
    - name: wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.4.2_arm64.deb -O /tmp/grafana.deb && sudo dpkg -i /tmp/grafana.deb
    - unless: dpkg -l | grep grafana-enterprise

# Reload systemd daemon
grafana_daemon_reload:
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - cmd: grafana_install

# Enable and start Grafana service
grafana_service:
  service.running:
    - name: grafana-server
    - enable: True
    - watch:
      - cmd: grafana_daemon_reload
    - require:
      - cmd: grafana_install

