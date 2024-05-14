base:
  'node1-prod':
    - install_mariadb
    - galera_config_1
    - stop_mysql

  'node2-prod':
    - install_mariadb
    - galera_config_2
    - stop_mysql

  'node3-prod':
    - install_mariadb
    - galera_config_3
    - stop_mysql
