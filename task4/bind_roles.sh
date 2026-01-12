#!/bin/bash
# Скрипт создаёт RoleBinding и ClusterRoleBinding

NAMESPACE=app

# Developer → developer
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-binding
  namespace: $NAMESPACE
subjects:
- kind: ServiceAccount
  name: dev-sa
  namespace: $NAMESPACE
roleRef:
  kind: Role
  name: developer
  apiGroup: rbac.authorization.k8s.io
EOF

# Functional → functional-readonly
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: functional-binding
  namespace: $NAMESPACE
subjects:
- kind: ServiceAccount
  name: functional-sa
  namespace: $NAMESPACE
roleRef:
  kind: Role
  name: functional-readonly
  apiGroup: rbac.authorization.k8s.io
EOF

# Operations → operations
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: operations-binding
  namespace: $NAMESPACE
subjects:
- kind: ServiceAccount
  name: ops-sa
  namespace: $NAMESPACE
roleRef:
  kind: Role
  name: operations
  apiGroup: rbac.authorization.k8s.io
EOF

# Security specialist → security-specialist (ClusterRoleBinding)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: security-binding
subjects:
- kind: ServiceAccount
  name: security-sa
  namespace: $NAMESPACE
roleRef:
  kind: ClusterRole
  name: security-specialist
  apiGroup: rbac.authorization.k8s.io
EOF

# Admin → admin (ClusterRoleBinding)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-binding
subjects:
- kind: ServiceAccount
  name: admin-sa
  namespace: $NAMESPACE
roleRef:
  kind: ClusterRole
  name: admin
  apiGroup: rbac.authorization.k8s.io
EOF

echo "Пользователи привязаны к ролям."
