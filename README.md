Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

Update the path with the name of your diagram](Images/diagram_Week 13 Network Diagram.png)


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _yml____ file may be used to install only certain pieces of it, such as Filebeat.

  - _TODO: Enter the playbook file._

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

--
- name: my first playbook
  hosts: webservers
  become: true
  tasks:

  - name: install docker
    apt:
      update_cache: yes
      name: docker.io
      state: present

  - name: install pip3
    apt:
      name: python3-pip
      state: present

  - name: install docker pip
    pip:
      name: docker
      state: present

  - name: install dvwa container
    docker_container:
      name: dvwa
      image: cyberxsecurity/dvwa
      state: started
      restart_policy: always
      published_ports: 80:80

  - name: enable docker service
    systemd:
      name: docker
      enabled: yes



---
  - name: Config Elkserver with Docker
    hosts: elkservers
    become: true
    tasks:
      - name: docker.io
        apt:
          update_cache: yes
          name: docker.io
          state: present

      - name: Install python3_pip
        apt:
          force_apt_get: yes
          name: python3-pip
          state: present

      - name: Install Docker python module
        pip:
          name: docker
          state: present

      - name: Enable docker service
        systemd:
          name: docker
          enabled: yes

      - name: Use more memory
        sysctl:
          name: vm.max_map_count
          value: '262144'
          state: present
          reload: yes

      - name: download and launch a docker elk container
        docker_container:
          name: elk
          image: sebp/elk:761
          state: started
          restart_policy: always

          published_ports:
            -  5601:5601
            -  9200:9200
            -  5044:5044

Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly __efficient___, in addition to restricting __access___ to the network.
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?_
Load Balancers protect against DDoS (distributed denial-of-service).
Jump boxes distribute the network traffic so the webservers do not become overcrowded.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the _data____ and system ___logs__.
- _TODO: What does Filebeat watch for?_monitors logs files, collects logs events and frowrds to Logstash for indexing.
- _TODO: What does Metricbeat record?_collects metrics from the server.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.


| Name                	| Function               	| IP Address   	| Operating System 	|
|---------------------	|------------------------	|--------------	|------------------	|
| JumpBox Provisioner 	| Gateway                	| 13.91.88.204 	| Linux            	|
| Web-1 DVWA          	| Web server             	| 10.0.0.5     	| Linux            	|
| Web-2 DVWA          	| Web server             	| 10.0.0.6     	| Linux            	|
| Web-3 DVWA          	| Web server             	| 10.0.0.8     	| Linux            	|
| Elk Server          	| log files and metrics  	| 10.1.0.4  	| Linux            	|



### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the _load balancer____ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _TODO: Add whitelisted IP addresses_24.171.91.145

Machines within the network can only be accessed by load balancer_____.
- _TODO: Which machine did you allow to access your ELK VM? Local machine. What was its IP address?_24.171.91.145

A summary of the access policies in place can be found in the table below.


| Name       | Publicly Accessible | Allowed IP Addresses       |
|------------|---------------------|----------------------------|
| Jump Box   | Yes                 | 10.0.0.5 10.0.0.6 10.0.0.8 |
| Web-1 DVWA | No                  |                            |
| Web-s DVWA | No                  |                            |
| Web-3 DVWA | No                  |                            |
| Elk Server | No                  | 24.171.91.145              |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?_To automate and disperse updates and patches and scripts
The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- ...install docker io
- ...install python
- ...install docker python module
- ...Enable docker service
- ...Increase memory
- ...Download and launch elk container on port 5601


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)
/Network-1-Project/docker ps output_screenshot.docx

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_
10.0.0.5
10.0.0.6
10.0.0.8

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_filebeat & metricbeat

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml_____ file to _/etc/filebeat/filebeat.yml____.
- Update the __hosts___ file to include...IP Address of Elk server
- Run the playbook, and navigate to _40.211.29.10:5601/app/kibana___ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_filebeat-playbook.yml and copy to /etc/filebeat/filebeat.yml
- _Which file do you update to make Ansible run the playbook on a specific machine? My-playbook.yml on jumpbox with ansible. How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running? http://40.211.29.10:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

