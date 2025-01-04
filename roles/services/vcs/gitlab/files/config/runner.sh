#!/bin/sh

# add packages
apk add curl jq

# generate a unique runner name
RUNNER_NAME="${TASK_NAME}"

# register the runner with GitLab and retrieve the runner token
RUNNER_TOKEN=$(curl --silent --request POST \
  --url "https://gitlab.com/api/v4/user/runners" \
  --data "runner_type=group_type" \
  --data "group_id=$GROUP_ID" \
  --data "description=auto registered gitlab runner: $RUNNER_NAME" \
  --header "PRIVATE-TOKEN: $ACCESS_TOKEN" | jq -r '.token')

# register the runner with the retrieved token
gitlab-runner register --non-interactive \
  --name="$RUNNER_NAME" \
  --url="https://gitlab.com" \
  --token="$RUNNER_TOKEN" \
  --executor="docker" \
  --docker-image="alpine:latest"

# unset the ACCESS_TOKEN to remove it from the environment
unset ACCESS_TOKEN

# keep the service running
gitlab-runner run --user=gitlab-runner --working-directory=/home/gitlab-runner
