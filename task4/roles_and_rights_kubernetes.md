| Роль      | Права роли        | Группы пользователей            |
| --------- | ----------------- | ------------------------------- |
| `developer` (Role, namespace `app`) | Управление workload-ресурсами: `pods`, `deployments`, `services`, `replicasets`, просмотр логов pod’ов (`pods/log`), действия: `get`, `list`, `watch`, `create`, `update`, `delete` | Разработчики (Developers)       |
| `functional-readonly` (Role, namespace `app`) | Только просмотр ресурсов: `pods`, `deployments`, `services`, `configmaps`, действия: `get`, `list`, `watch` | Product Owner, Business Analyst |
| `operations` (Role, namespace `app`) | Чтение ресурсов: `pods`, `services`, просмотр логов pod’ов (`pods/log`), действия: `get`, `list`, `watch`    | Операционная команда, Менеджеры |
| `security-specialist` (ClusterRole) | Чтение всех ресурсов кластера (`get`, `list`, `watch`), управление RBAC (`roles`, `rolebindings`, `clusterroles`, `clusterrolebindings`), управление `NetworkPolicies`, действия: `create`, `update`, `delete` | Специалист по безопасности      |
| `admin` / `devops` (ClusterRole) | Полный доступ ко всем ресурсам кластера, управление кластерами и namespace’ами, действия: `*`     | DevOps-инженеры                 |
