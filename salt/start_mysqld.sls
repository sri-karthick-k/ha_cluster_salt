start_mysqld:
  service.running:
    - name: mysqld
    - enable: True
    - reload: True
