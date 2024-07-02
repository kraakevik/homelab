# Homelab automation
Complete automation suite for the provisioning of my homelab/server/nas based on Proxmox.


### Example provision of PVE node
1. Add a `venv` with `python3 -m venv venv`
2. Install requirements `pip3 install -r requirements.txt`
3. Ensure `BWS_ACCESS_TOKEN` is present in environment for Bitwarden Secrets Manager.
4. Run `pve.yaml` playbook with `ansible-playbook -i hosts.yml pve.yaml`