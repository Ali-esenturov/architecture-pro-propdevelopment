# Task7 — Проверка безопасности Kubernetes pod’ов с Gatekeeper

## Структура
Task7/
├── 01-create-namespace.yaml
├── insecure-manifests/
│ ├── 01-privileged-pod.yaml
│ ├── 02-hostpath-pod.yaml
│ └── 03-root-user-pod.yaml
├── secure-manifests/
│ ├── 01-secure.yaml
│ ├── 02-secure.yaml
│ └── 03-secure.yaml
├── gatekeeper/
│ ├── constraint-templates/
│ │ ├── privileged.yaml
│ │ ├── hostpath.yaml
│ │ └── runasnonroot.yaml
│ └── constraints/
│ ├── privileged.yaml
│ ├── hostpath.yaml
│ └── runasnonroot.yaml
├── verify/
│ ├── verify-admission.sh
│ └── validate-security.sh
└── README_FOR_REVIEWER.md


## Инструкция по проверке

1. Запуск Minikube:

```bash
minikube start

2. Создать namespace:

kubectl apply -f 01-create-namespace.yaml

3. Установить Gatekeeper и применить ConstraintTemplate + Constraint:

kubectl apply -f gatekeeper/constraint-templates/
kubectl apply -f gatekeeper/constraints/

4. Применяем secure pod’ы:

```bash
bash ./verify/validate-security.sh

5. Проверяем блокировку insecure pod’ов:

```bash
bash ./verify/verify-admission.sh

Примечания
- Gatekeeper теперь основной механизм проверки, встроенный PodSecurity модуль не используется
- Для проверки root-подов используется правило runAsNonRoot с проверкой pod-level и container-level runAsUser
- Все pod’ы secure используют readOnlyRootFilesystem: true и non-root пользователя

