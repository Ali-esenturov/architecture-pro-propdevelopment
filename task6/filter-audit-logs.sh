#!/bin/bash

LOG="${1:-audit.log}"

jq '
select(.stage=="ResponseComplete") |
select(.user.username | startswith("system:") | not) |
select(
(.verb=="get" and .objectRef.resource=="secrets") or
(.verb=="create" and .objectRef.resource=="pods") or
(.verb=="create" and .objectRef.resource=="rolebindings") or
(.verb=="create" and .objectRef.subresource=="exec") or
(.verb=="delete" and (.requestURI|contains("audit")))
) |
{
timestamp: .requestReceivedTimestamp,
user: .user.username,
impersonated: (.impersonatedUser.username // null),
verb: .verb,
namespace: (.objectRef.namespace // "cluster"),
resource: .objectRef.resource,
subresource: (.objectRef.subresource // null),
status: .responseStatus.code
}
' "$LOG"
