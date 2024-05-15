apache2_package:
  pkg.installed:
    - name: apache2

apache2_service:
  service.running:
    - name: apache2
    - enable: True
    - watch:
      - pkg: apache2_package

haproxy:
  pkg.installed:
    - name: haproxy

php_repository:
  pkg.installed:
    - names:
      - software-properties-common
      - python3-software-properties

add_php_repository:
  cmd.run:
    - name: sudo add-apt-repository ppa:ondrej/php

#php_packages:
#  pkg.installed:
#    - names:
#      - php8.0
#      - php8.0-common
#      - php8.0-mysql
#      - php8.0-gmp
#      - php8.0-curl
#      - php8.0-intl
#      - php8.0-mbstring
#      - php8.0-xmlrpc
#      - php8.0-gd
#      - php8.0-xml
#      - php8.0-cli
#      - php8.0-zip


php82_packages:
  pkg.installed:
    - names:
        - php8.2
        - php8.2-common
        - php8.2-mysql
        - php8.2-gmp
        - php8.2-curl
        - php8.2-intl
        - php8.2-mbstring
        - php8.2-xmlrpc
        - php8.2-gd
        - php8.2-xml
        - php8.2-cli
        - php8.2-zip


phpmyadmin:
  pkg.installed:
    - name: phpmyadmin
    - require:
      - pkg: php82_packages


apache_phpmyadmin_conf:
  file.managed:
    - name: /etc/apache2/conf-available/phpmyadmin.conf
    - source: salt://phpmyadmin.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: phpmyadmin
      - pkg: apache2_package

enable_phpmyadmin_conf:
  cmd.run:
    - name: sudo a2enconf phpmyadmin
    - require:
      - file: apache_phpmyadmin_conf

restart_apache:
  service.running:
    - name: apache2
    - watch:
      - cmd: enable_phpmyadmin_conf

