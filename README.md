# MLOps Project

A local AI stack deployed via a Jenkins pipeline on a Rocky Linux 9 VM.

## Stack
- **VM**: Rocky Linux 9.8 (aarch64) running on UTM
- **Container runtime**: Podman
- **CI/CD**: Jenkins
- **LLM server**: Ollama serving Qwen2.5 0.5B Instruct
- **Frontend**: Open WebUI

## Structure
- `ansible/` - Ansible playbook to configure the VM (installs Java, Podman, Jenkins)
- `automation/` - Jenkins pipeline that deploys the AI stack
- `terraform/` - Infrastructure as code for VM provisioning

## How to run
1. Run the Ansible playbook to configure the VM
2. Open Jenkins at http://192.168.64.2:8080
3. Create a pipeline job and paste the Jenkinsfile from `automation/`
4. Click Build Now

## Notes on Terraform
The `terraform/` folder contains the original VM provisioning config written for 
Windows + VirtualBox. On Apple Silicon (M4) this was replaced by manual VM creation 
via UTM, since no Terraform provider exists for UTM. The Ansible playbook then 
handles all configuration automatically regardless of platform.
