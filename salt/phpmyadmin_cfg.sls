/etc/phpmyadmin/config.inc.php:
  file.managed:
    - source: salt://templates/config.inc.php.j2
    - template: jinja
    - context:
        virtual_ip: {{ salt['pillar.get']('virtual_ip') }}
    - watch_in:
      - service: restart_apache_after_file_changes

restart_apache_after_file_changes:
  service.running:
    - name: apache2
    - reload: True
    - watch:
      - file: /etc/phpmyadmin/config.inc.php

