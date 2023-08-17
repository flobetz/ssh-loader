#!/bin/bash

SSH_ENV="${HOME}/.ssh/environment"

KEYS_TO_LOAD=$(cat <<EOF
${HOME}/.ssh/id_rsa_1
${HOME}/.ssh/id_rsa_2
${HOME}/.ssh/id_rsa_3
EOF
)

# function which starts the ssh-agent process
function start_agent {
    echo "Initializing new ssh-agent.."
    /usr/bin/ssh-agent > "${SSH_ENV}"
    echo "ssh-agent started"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    echo "ssh-agent pid ${SSH_AGENT_PID}"
}

# function which loads every defined key
function load_keys {
  echo "Loading ssh keys.."
  while IFS= read -r key; do
    /usr/bin/ssh-add --apple-use-keychain "${key}"
  done <<< "${KEYS_TO_LOAD}"
  echo "Done!"
}

# Source SSH settings, if applicable
echo "Looking for a running ssh-agent process"
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps "${SSH_AGENT_PID}" > /dev/null || {
      echo "No ssh-agent process running. Starting new ssh-agent process"
      rm -rf "${SSH_ENV}"
      start_agent;
    }
else
    echo "No ssh-agent process running. Starting new ssh-agent process"
    start_agent;
fi

load_keys;
