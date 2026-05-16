#!/bin/bash

ENV_FILE="/root/.pbs-docker-backup.env"

if [[ -f "${ENV_FILE}" ]]; then
    set -a
    source "${ENV_FILE}"
    set +a
else
    echo "Error: Environment file not found at ${ENV_FILE}" >&2
    exit 1
fi

VOLUME_DIR="/var/lib/docker/volumes"

for vol_path in "$VOLUME_DIR"/*; do
    if [ -d "$vol_path" ]; then

        vol_name=$(basename "$vol_path")

        echo "Backing up volume: $vol_name..."

        # Proxmox Backup Server Command
	proxmox-backup-client backup root.pxar:${vol_path} --backup-id "${vol_name}"
    fi
done
