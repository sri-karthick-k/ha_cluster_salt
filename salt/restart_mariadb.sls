restart_mariadb:
  service.running:
    - name: mysqld
    - reload: True
