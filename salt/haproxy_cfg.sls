/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://templates/haproxy.cfg.j2
    - template: jinja

restart_haproxy:
  service.running:
    - name: haproxy
    - reload: True
    - watch:
      - file: /etc/haproxy/haproxy.cfg

