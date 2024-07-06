# Homelab automation
Complete automation suite for the provisioning of my homelab/server/nas based on Proxmox.

### Machine setup

Add the following environment variables

```
TAILSCALE_OAUTH_CLIENT_SECRET=<oauth_tailscale_secret_token>
BWS_ACCESS_TOKEN=<token_to_bitwarden_secrets_manager>
```

### Example provision of PVE node
1. Add a `venv` with `python3 -m venv venv`
2. Install requirements `pip3 install -r requirements.txt`
3. Ensure `BWS_ACCESS_TOKEN` is present in environment for Bitwarden Secrets Manager.
4. Run `pve.yaml` playbook with `ansible-playbook -i hosts.yml pve.yaml`

### Example setup Docker node with iGPU passtrough and *arr stack
1. 1-3 as above..
4. Run `docker.yaml` playbook with `ansible-playbook -i hosts.yml docker.yaml`
