mysql_port_3306:
  iptables.append:
    - table: filter
    - chain: INPUT
    - protocol: tcp
    - dport: 3306
    - jump: ACCEPT

