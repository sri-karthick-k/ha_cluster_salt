install_mariadb_server:
  pkg.installed:
    - name: mariadb-server

{% set node_data = salt['pillar.get']('galera_nodes') %}
{% for node, data in node_data.items() %}
configure_galera_{{ node }}:
  file.managed:
    - name: /etc/mysql/conf.d/galera.cnf
    - source: salt://galera/galera.cnf.jinja
    - template: jinja
    - context:
        node_name: {{ data['node_name'] }}
        node_address: {{ data['node_address'] }}
{% endfor %}


initialize_database:
  cmd.run:
    - name: "sudo mysql < /srv/salt/secure_installation.sql"
    - target: 'node1-prod'
    - onchanges:
        - file: configure_galera_node1


stop_mysqld:
  service.stopped:
    - name: mysqld
    - enable: False

galera_new_cluster:
  cmd.run:
    - name: "sudo galera_new_cluster"
    - onchanges:
        - service: stop_mysqld

start_mysqld:
  service.running:
    - name: mysqld
    - enable: True
    - onchanges:
        - cmd: galera_new_cluster