#!/bin/bash

NAMESPACE=app

# Developer Role (namespace)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer
  namespace: $NAMESPACE
rules:
- apiGroups: ["", "apps"]
  resources: ["pods", "services", "deployments", "replicasets"]
  verbs: ["get","list","watch","create","update","delete"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get"]
EOF

# Functional read-only Role (namespace)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: functional-readonly
  namespace: $NAMESPACE
rules:
- apiGroups: ["", "apps"]
  resources: ["pods","services","deployments","configmaps"]
  verbs: ["get","list","watch"]
EOF

# Operational Role (namespace)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: operations
  namespace: $NAMESPACE
rules:
- apiGroups: [""]
  resources: ["pods","services"]
  verbs: ["get","list","watch"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get"]
EOF

# Security Specialist ClusterRole
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: security-specialist
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["get","list","watch"]
- apiGroups: ["rbac.authorization.k8s.io"]
  resources: ["roles","rolebindings","clusterroles","clusterrolebindings"]
  verbs: ["create","update","delete"]
- apiGroups: ["networking.k8s.io"]
  resources: ["networkpolicies"]
  verbs: ["*"]
EOF

# Admin / DevOps ClusterRole
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: admin
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
EOF

echo "Роли и ClusterRoles созданы."
