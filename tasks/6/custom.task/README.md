# Task notes for CentOS 6

## Node Metadata

- 'timezone' (optional) - This is the string corresponding to the timezone for
  the node.
  - Default: America/Los_Angeles
  
[root@razor-server ~]# **cp -r /vagrant/tasks/6 /opt/puppet/share/razor-server/tasks/centos/**
[root@razor-server ~]# razor create-broker --name pe --broker-type puppet-pe --configuration server=puppet-master
From https://localhost:8151/api/collections/brokers/pe:

           name: pe
    broker_type: puppet-pe
  configuration:
                   server: puppet-master
       policies: 0
        command: https://localhost:8151/api/collections/commands/1

[root@razor-server ~]# **razor create-tag --name 1cpu --rule '["=", ["num", ["fact", "processorcount"]], 1]'**
From https://localhost:8151/api/collections/tags/1cpu:

      name: 1cpu
      rule: ["=", ["num", ["fact", "processorcount"]], 1]
     nodes: 0
  policies: 0
   command: https://localhost:8151/api/collections/commands/2

[root@razor-server ~]# **razor create-tag --name 2cpu --rule '["=", ["num", ["fact", "processorcount"]], 2]'**
From https://localhost:8151/api/collections/tags/2cpu:

      name: 2cpu
      rule: ["=", ["num", ["fact", "processorcount"]], 2]
     nodes: 0
  policies: 0
   command: https://localhost:8151/api/collections/commands/3

[root@razor-server ~]# **razor create-tag --name virtual --rule '["=",  ["fact", "is_virtual"], true]'**
From https://localhost:8151/api/collections/tags/virtual:

      name: virtual
      rule: ["=", ["fact", "is_virtual"], true]
     nodes: 0
  policies: 0
   command: https://localhost:8151/api/collections/commands/4

[root@razor-server ~]# **razor create-tag --name small --rule '["<", ["num", ["fact", "memorysize_mb"]], 2000]'**
From https://localhost:8151/api/collections/tags/small:

      name: small
      rule: ["<", ["num", ["fact", "memorysize_mb"]], 2000]
     nodes: 0
  policies: 0
   command: https://localhost:8151/api/collections/commands/5

[root@razor-server ~]# **razor create-tag --name large --rule '[">=", ["num", ["fact", "memorysize_mb"]], 2000]'**
From https://localhost:8151/api/collections/tags/large:

      name: large
      rule: [">=", ["num", ["fact", "memorysize_mb"]], 2000]
     nodes: 0
  policies: 0
   command: https://localhost:8151/api/collections/commands/6

[root@razor-server ~]# **razor create-repo --name=centos-6.6 --task centos/6 --iso-url http://mirror.es.its.nyu.edu/centos/6.6/isos/x86_64/CentOS-6.6-x86_64-minimal.iso**
From https://localhost:8151/api/collections/repos/centos-6.6:

     name: centos-6.6
  iso_url: http://mirror.es.its.nyu.edu/centos/6.6/isos/x86_64/CentOS-6.6-x86_64-minimal.iso
      url: ---
     task: centos/6
  command: https://localhost:8151/api/collections/commands/7

[root@razor-server ~]# **razor create-policy --name awesome-web --repo centos-6.6 --broker pe --tag '[ "small", "1cpu" ]' --enabled --hostname 'awesomeweb${id}' --root-password secret --max-count 2 --task centos/6/custom --node-metadata role=awesome-web --node-metadata group=awesomesite**
From https://localhost:8151/api/collections/policies/awesome-web:

       name: awesome-web
       repo: centos-6.6
       task: centos/6/custom
     broker: pe
    enabled: true
  max_count: 2
       tags: 1cpu, small
      nodes: 0
    command: https://localhost:8151/api/collections/commands/8

[root@razor-server ~]# **razor create-policy --name awesome-lb --repo centos-6.6 --broker pe --tag '[ "small", "2cpu" ]' --enabled --hostname 'awesomesite' --root-password secret --max-count 1 --task centos/6/custom --node-metadata role=awesome-lb --node-metadata group=awesomesite**
From https://localhost:8151/api/collections/policies/awesome-lb:

       name: awesome-lb
       repo: centos-6.6
       task: centos/6/custom
     broker: pe
    enabled: true
  max_count: 1
       tags: 2cpu, small
      nodes: 0
    command: https://localhost:8151/api/collections/commands/9
