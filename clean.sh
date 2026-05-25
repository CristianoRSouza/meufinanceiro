#!/bin/bash
cd "$(dirname "$0")"
docker compose down -v
echo "Volumes removidos com sucesso."
