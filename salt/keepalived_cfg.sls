keepalived_install:
  pkg.installed:
    - name: keepalived


/etc/keepalived/keepalived.conf:
  file.managed:
    - source: salt://templates/keepalived.conf.j2
    - template: jinja
    - context:
        password: {{ salt['pillar.get']('secrets:vrrp_password') }}
        virtual_ip: {{ salt['pillar.get']('virtual_ip') }}
        node_data: {{ salt['pillar.get']('load_nodes') }}
    - required:
      - pkg:
        - keepalived

restart_keepalived:
  service.running:
    - name: keepalived
    - reload: True
    - watch:
      - file: /etc/keepalived/keepalived.conf
