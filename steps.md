sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/ubuntu/22.04/arm64/SALT-PROJECT-GPG-PUBKEY-2023.gpg

echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=arm64] https://repo.saltproject.io/salt/py3/ubuntu/22.04/arm64/3007 jammy main" | sudo tee /etc/apt/sources.list.d/salt.list

sudo apt-get update

-------
-- minion
sudo apt-get install -y salt-minion

sudo systemctl enable salt-minion && sudo systemctl start salt-minion

sudo wget 192.168.29.145:8080/minion_config.conf -O /etc/salt/minion
----
--master
sudo apt-get install -y salt-master

sudo systemctl enable salt-master && sudo systemctl start salt-master

sudo wget 192.168.29.145:8080/master_config.conf -O /etc/salt/master
----


master node:
```
sudo mkdir -p /srv/salt
```

base:
  'node1-prod':
    - install_mariadb
    - galera_config_1
    - copy_secure_install_file
    - execute_secure_install
    - stop_mysql
    - start_mysql

  'node2-prod':
    - install_mariadb
    - galera_config_2
    - stop_mysql
    - start_mysql
  'node3-prod':
    - install_mariadb
    - galera_config_3
    - stop_mysql
    - start_mysql


```
  sudo salt '*' state.apply 
```

```
  sudo salt 'node1-prod' state.apply copy_secure_install_file
  sudo salt 'node1-prod' state.apply execute_secure_install
  sudo salt 'node1-prod' cmd.run sudo galera_new_cluster
