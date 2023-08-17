# ssh-loader
script which automatically starts an ssh-agent and loads provided keys

## Usage
1. Place the script 'startAgent.sh' into your `$HOME/.ssh` directory
2. Replace the paths to the dummy keys in L6 - L8 with your ssh keys
3. call it with `source $HOME/.ssh/startAgent.sh` from your `$HOME/.bash_profile`, `$HOME/.bashrc`, `$HOME/.zprofile`, ... file

The provided ssh keys will get loaded automatically whenever you open a terminal session.
