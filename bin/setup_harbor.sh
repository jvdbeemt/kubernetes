#!/usr/bin/env bash
function apiCall {
  curl --insecure \
    -u admin:IbwvebaSuhhN5J5vCKqeJAj85eufb3 \
    -X POST \
    ${1} \
    -H "accept: application/json" \
    -H "Content-Type: application/json" \
    -d "${2}"
}

url=https://harbor.k8s-local.io/api
user_payload='{
  "username": "demo",
  "comment": "demo",
  "password": "Demodemo0",
  "realname": "Demo",
  "email": "demo@example.com"
}'

project_payload='{
  "project_name": "demo",
  "metadata": {
    "enable_content_trust": "false",
    "auto_scan": "true",
    "public": "true"
  }
}'

project_member='{
  "role_id": 2,
  "member_user": {
    "username": "demo"
  }
}'

apiCall "${url}/users" "${user_payload}"
apiCall "${url}/projects" "${project_payload}"
apiCall "${url}/projects/2/members" "${project_member}"
