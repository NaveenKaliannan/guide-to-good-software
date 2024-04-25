# Ansible

Ansible is a automation tool. It is designed to automate configuration management, application deployment, orchestration, and other IT processes across different environments and platforms.

### Installation 
**Ansible configuration files** when ansible is installed, **ansible.cfg** is created at **/etc/ansible/ansible.cfg** The configuration file has different sections, each containing different parameters to control Ansible's behavior. Here's a brief explanation of the main sections:
* **defaults** This section contains general default values for Ansible, such as the location of the inventory file, remote connection settings, and module paths.
* **privilege_escalation** This section defines settings related to privilege escalation, such as the method (sudo or su) and parameters for running operations with elevated privileges.
* **paramiko_connection** This section configures settings for the Paramiko SSH connection plugin, such as the SSH key file and connection timeout.
* **ssh_connection** This section controls settings for the OpenSSH-based connection plugin, like SSH arguments and control path.
* **persistent_connection** This section manages settings for persistent connections, which can improve performance by reusing existing connections.
* **accelerate** This section configures the accelerated mode, which allows Ansible to connect to remote nodes using a temporary socket file for improved performance.
* **selinux** This section defines settings related to SELinux on managed nodes.
* **colors** This section controls the use of colors in Ansible's output.
* **diff** This section manages settings for displaying file diffs when changes are made.
* **callback** This section configures callback plugins, which can modify how Ansible displays output.
