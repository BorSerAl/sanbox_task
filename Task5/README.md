### Task 5: Ansible for beginners
  1.	Deploy three virtual machines in the Cloud. Install Ansible on one of them (control_plane).
  2.	Ping pong - execute the built-in ansible ping command. Ping the other two machines.
  3.	My First Playbook: write a playbook for installing Docker on two machines and run it.

#### Tasks:
####  1. Deploy three virtual machines in the Cloud :heavy_check_mark:
#####      install ansible:
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install ansible
  
###  2. Ping pong - execute the built-in ansible ping command. Ping the other two machines. :heavy_check_mark:
#### Hosts file
    [Ubuntu_servers]
    Ubuntu_server_1 ansible_host=3.110.54.21
    Ubuntu_server_2 ansible_host=13.234.29.127
#### ansible.cfg
    [defaults]
    host_key_checking = false
    inventory          = ./hosts.txt

#### group_vars
    ---
    ansible_user                 : ubuntu
    ansible_ssh_private_key_file : /home/ubuntu/.ssh/key.pem
    owner                        : Serbor

#### ping command
    ansible all -m ping
#### Result:
      Ubuntu-sever_1 | SUCCESS => {
          "ansible_facts": {
              "discovered_interpreter_python": "/usr/bin/python3"
          },
          "changed": false,
          "ping": "pong"
      }
      Ubuntu-sever_2 | SUCCESS => {
          "ansible_facts": {
              "discovered_interpreter_python": "/usr/bin/python3"
          },
          "changed": false,
          "ping": "pong"
      }
      
###  3. My First Playbook :heavy_check_mark:
    ---
    - name: Install Docker
      hosts: all
      become: yes

      tasks:
        - name: Install aptitude using apt
          apt: name=aptitude state=latest update_cache=yes force_apt_get=yes

        - name: Install the required system packages
          apt: name={{ item }} state=latest update_cache=yes
          loop: [ 'apt-transport-https', 'ca-certificates', 'curl', 'software-properties-common', 'python3-pip', 'virtualenv', 'python3-setuptools']

        - name: Install the Docker GPG APT key
          apt_key:
            url: https://download.docker.com/linux/ubuntu/gpg

        - name: Add Docker Repository
          apt_repository:
            repo: deb https://download.docker.com/linux/ubuntu focal stable

        - name: Install Docker
          apt: update_cache=yes name=docker-ce state=latest

        - name: Install the Python Docker module
          pip:
            name: docker

        - name: Pull Docker image
          docker_image:
            name: hello-world
            source: pull

        - name: Create container
          docker_container:
            name: hello-world
            image: hello-world
            state: started

####    Run ansible-playbook Docker_playbook.yml
####    Result:
    TASK [Run Docker image] ********************************************************************************************
    changed: [Ubuntu-sever_1]
    changed: [Ubuntu-sever_2]

    TASK [Create container] ********************************************************************************************
    changed: [Ubuntu-sever_1]
    changed: [Ubuntu-sever_2]

    PLAY RECAP *********************************************************************************************************
    Ubuntu-sever_1             : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    Ubuntu-sever_2             : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 



