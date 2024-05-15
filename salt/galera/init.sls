{% set node_data = salt['pillar.get']('galera_nodes') %}

install_mariadb_server:
  pkg.installed:
    - name: mariadb-server
    - refresh: True

{% if node_data is not none and node_data is mapping %}
{% for node, data in node_data.items() %}

{% set current_minion_id = grains['id'] %}

{% if current_minion_id == data['node_name'] %}
configure_galera_{{ data['node_name'] }}:
  file.managed:
    - name: /etc/mysql/conf.d/galera.cnf
    - source: salt://galera/galera.cnf.jinja
    - template: jinja
    - context:
        node_name: {{ data['node_name'] }}
        node_address: {{ data['node_address'] }}

echo_command_{{ data['node_name'] }}:
  cmd.run:
    - name: echo "{{ data['node_name'] }} {{ data['node_address'] }} {{ current_minion_id }}"
{% endif %}

{% if current_minion_id == 'node1-prod' %}
copy_secure_installation_file_{{ data['node_name'] }}:
  file.managed:
    - name: /srv/secure_installation.sql
    - source: salt://secure_installation.sql
    - template: jinja


#galera_new_cluster:
#  cmd.run:
#    - name: "sudo galera_new_cluster"


initialize_database_{{ data['node_name'] }}:
  cmd.run:
    - name: "sudo mysql < /srv/secure_installation.sql"
    - target: 'node1-prod'

{% endif %}
{% endfor %}
{% endif %}

#stop_mysqld:
#  service.dead:
#    - name: mysqld
#    - enable: True

/etc/mysql/mariadb.conf.d/60-galera.cnf:
  file.managed:
    - source: salt://galera/60-galera.cnf
    - template: jinja

#start_mysqld:
#  service.running:
#    - name: mysqld
#    - enable: True
#    - reload: True

