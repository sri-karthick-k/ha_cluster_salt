prometheus:
  user.present:
    - fullname: prometheus
    - shell: /sbin/nologin

# Create directories for Prometheus
prometheus_directories:
  file.directory:
    - name: /etc/prometheus
    - user: prometheus
    - group: prometheus
    - mode: '0755'

# Download and extract Prometheus
prometheus_download:
  cmd.run:
    - name: |
        wget https://github.com/prometheus/prometheus/releases/download/v2.52.0-rc.1/prometheus-2.52.0-rc.1.linux-arm64.tar.gz
        sudo mkdir -p /tmp/prometheus
        sudo mkdir -p /etc/prometheus
        sudo mkdir -p /var/lib/prometheus
        tar -C /tmp/prometheus -zxvf prometheus*.tar.gz
        cd /tmp/prometheus/prometheus*
        sudo mv prometheus /usr/local/bin
        sudo mv promtool /usr/local/bin
        sudo mv consoles /etc/prometheus
        sudo mv console_libraries /etc/prometheus
        sudo mv prometheus.yml /etc/prometheus

prometheus_ownership:
  cmd.run:
    - name: |
        sudo chown prometheus:prometheus /usr/local/bin/prometheus
        sudo chown prometheus:prometheus /usr/local/bin/promtool
        sudo chown prometheus:prometheus /etc/prometheus
        sudo chown -R prometheus:prometheus /etc/prometheus/consoles
        sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
        sudo chown -R prometheus:prometheus /var/lib/prometheus

/etc/systemd/system/prometheus.service:
  file.managed:
    - source: salt://prometheus/prometheus.service
    - template: jinja

daemon_reload:
  cmd.run:
    - name: systemctl daemon-reload
    - watch:
      - file: /etc/systemd/system/prometheus.service

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://prometheus/prometheus.yml
    - template: jinja  

prometheus_service:
  service.running:
    - name: prometheus
    - enable: True
    - reload: True
    - watch:
      - file: /etc/prometheus/prometheus.yml
