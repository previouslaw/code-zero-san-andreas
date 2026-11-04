#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: bash scripts/install-codezero.sh /path/to/txData/<profile>" >&2
    exit 2
fi

repo_root="$(cd -- "$(dirname -- "$0")/.." && pwd)"
server_root="$(cd -- "$1" && pwd)"
config="$server_root/server.cfg"
qb_core="$server_root/resources/[qb]/qb-core"
source_resources="$repo_root/resources/[codezero]"
target_resources="$server_root/resources/[codezero]"
source_icon="$repo_root/assets/server-icon.png"
target_icon="$server_root/server-icon.png"

if [[ ! -f "$config" ]]; then
    echo "No server.cfg found at '$config'. Pass the txAdmin profile folder containing server.cfg and resources." >&2
    exit 1
fi
if [[ ! -d "$qb_core" ]]; then
    echo "QBCore was not found at '$qb_core'. Deploy the QBCore txAdmin recipe first." >&2
    exit 1
fi
if [[ ! -d "$source_resources" || ! -f "$source_icon" ]]; then
    echo "This checkout is missing the Code Zero resources or supplied-logo icon." >&2
    exit 1
fi

mkdir -p "$target_resources"
cp -R "$source_resources/." "$target_resources/"
cp -f "$source_icon" "$target_icon"

if ! grep -Eq '^[[:space:]]*ensure[[:space:]]+\[codezero\][[:space:]]*$' "$config"; then
    printf '\nensure [codezero]\n' >> "$config"
fi

if grep -Eq '^[[:space:]]*load_server_icon[[:space:]]+' "$config"; then
    sed -i -E 's|^[[:space:]]*load_server_icon[[:space:]]+.*$|load_server_icon "server-icon.png"|' "$config"
else
    printf '\nload_server_icon "server-icon.png"\n' >> "$config"
fi

echo "Code Zero resources and logo installed."
echo "Server profile: $server_root"
echo "Start the server from txAdmin when ready."
