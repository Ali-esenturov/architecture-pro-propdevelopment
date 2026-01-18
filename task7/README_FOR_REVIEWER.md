# Task7 — Проверка безопасности Kubernetes pod’ов с Gatekeeper

## Инструкция по проверке

1. Запуск Minikube:

```bash
minikube start
```

2. Создать namespace:

```bash
kubectl apply -f 01-create-namespace.yaml
```

3. Установить Gatekeeper и применить ConstraintTemplate + Constraint:

```bash
kubectl apply -f gatekeeper/constraint-templates/
kubectl apply -f gatekeeper/constraints/
```

4. Применяем secure pod’ы:

```bash
bash ./verify/validate-security.sh
```

5. Проверяем блокировку insecure pod’ов:

```bash
bash ./verify/verify-admission.sh
```

Примечания:
- Gatekeeper теперь основной механизм проверки, встроенный PodSecurity модуль не используется
- Для проверки root-подов используется правило runAsNonRoot с проверкой pod-level и container-level runAsUser
- Все pod’ы secure используют readOnlyRootFilesystem: true и non-root пользователя

