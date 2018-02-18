Welcome to the ansible-kubernetes-cloudformation wiki!

# Installation:
## Pre-Requirements for OSX
* Xcode CLI tools - [Instructions](https://github.com/cloudvox/ansible-kubernetes-cloudformation/wiki/Install-xcode-cli-tools)
* Homebrew - [Instructions] (https://github.com/cloudvox/ansible-kubernetes-cloudformation/wiki/Install-Homebrew)
* Ansible - [Instructions] (https://github.com/cloudvox/ansible-kubernetes-cloudformation/wiki/Install-ansible)

Step 1:
Install aws-cli and boto (boto is required by ansible cloud modules to communicate with the variable aws api's)
```
ansible-playbook bootstrap_osx.yml -K
```