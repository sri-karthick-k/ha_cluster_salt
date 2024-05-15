base:
  'node1-prod':
    - galera
    - galera_nodes
  'node2-prod':
    - galera
    - galera_nodes
  'node3-prod':
    - galera
    - galera_nodes
#  'load-balancer*':
#    - phpmyadmin 
pillar_opts: True
