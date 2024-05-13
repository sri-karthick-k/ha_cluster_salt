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

```
# /srv/salt/update_repos.sls

update_repos:
  pkg.refresh_db

```

