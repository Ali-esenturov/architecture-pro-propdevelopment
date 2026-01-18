#!/bin/bash
# verify/verify-admission.sh
set -e

NAMESPACE="audit-zone"

echo "Проверяем блокировку insecure pod'ов..."

for pod_file in ./insecure-manifests/*.yaml; do
  echo "Пробуем применить $pod_file..."
  if kubectl apply -f "$pod_file" -n $NAMESPACE 2>&1 | grep -q "denied"; then
    echo "✅ $pod_file заблокирован Gatekeeper"
  else
    echo "❌ $pod_file прошел проверку (не должно быть!)"
  fi
done
