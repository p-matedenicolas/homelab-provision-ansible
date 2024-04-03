# Ansible homelab provision

## Commands

Ping inventory
```
ansible -i inventories/development -m ping server_nodes
```

Run playbook
```
ansible-playbook -i inventories/development play_server.yaml
```
