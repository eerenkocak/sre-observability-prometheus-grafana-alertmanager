#!/usr/bin/env bash
set -euo pipefail

echo "Verifying SRE Observability Stack configurations..."

for file in prometheus/prometheus.yml prometheus/alert_rules.yml alertmanager/alertmanager.yml docker-compose.yml; do
  [[ -f "$file" ]] || { echo "[ERROR] Missing $file"; exit 1; }
  echo "[PASS] Found $file"
done

python3 -c 'import json; json.load(open("grafana/provisioning/dashboards/sre-dashboard.json"))'
echo "[PASS] Grafana dashboard JSON syntax is valid."
echo "All SRE stack configurations verified successfully!"
