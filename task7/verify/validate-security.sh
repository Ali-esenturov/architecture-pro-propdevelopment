#!/bin/bash
# verify/validate-security.sh
set -e

NAMESPACE="audit-zone"

echo "Проверяем secure pod'ы в namespace $NAMESPACE..."

for pod_file in ./secure-manifests/*.yaml; do
  echo "Применяем $pod_file..."
  kubectl apply -f "$pod_file" -n $NAMESPACE
done

echo "Все secure pod'ы применены без ошибок Gatekeeper!"
