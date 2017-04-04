# ansible-example

This is an example to show you how to use Ansible and Serverspec with [ansible_spec_plus](https://github.com/consort-it/ansible_spec_plus) to test roles,
hosts and playbooks and how to keep track of your code with simple resource coverge (test coverage).

Basic installation instructions on how to connect Ansible and Serverspec can be found [here](https://github.com/volanja/ansible_spec).

To make it short:

1. ```gem install ansible_spec_plus```

2. ```asp-init```

3. Check *site.yml* file

4. Check *hosts* file

5. Check *.ansiblespec* file (and make sure that your master playbook and hosts files are correct)

## Dependencies and needed tools

1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

2. [Vagrant](https://www.vagrantup.com/downloads.html)

3. Vagrant plugins:

```
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-share
vagrant plugin install vagrant-vbguest
vagrant plugin install vai
```

## Clone this repository

```
git clone https://github.com/consort-it/ansible-example.git
```

## Start your SUT (system under test)

Asssumed everything is installed correctly, you can proceed with:

```
cd ansible-example
vagrant status
```

```
ansible-example master ● vagrant status
Current machine states:

demo                      not created (virtualbox)

The environment has not yet been created. Run `vagrant up` to
create the environment. If a machine is not created, only the
default provider will be shown. So if a provider is not listed,
then the machine is not created for that environment.
```

```
vagrant up demo
```

## Ensure your SUT is up and running

[http://10.100.100.200:9000](http://10.100.100.200:9000)

If you see 'UI For Docker', then your provisioning was successful.

## Provisioning

#### Vagrant style

In a Vagrant environment like this you would use a simple

```
vagrant provision demo
```

to start a provisioning run on your box.

#### Real world style

In a real world example, you would use

```
ansible-playbook demo.yml -i hosts --extra-vars "user=deploy"
```

where the deploy user has sudo access to your system. Hosts file should look like this:

```
[demo-hosts]
1.2.3.4
```

This also requires your playbook to include:

```
remote_user: '{{ user }}'
```

**Please note:** Both, Vagrant style and real world style hosts file syntax is supported.

## Testing

### Remote with SSH

```
bundle install
```

List available specs:

```
~ master ● asp list
asp rolespec common              # run role specs for common
asp rolespec demo                # run role specs for demo
asp rolespec docker              # run role specs for docker
asp hostspec demo                # run host specs for demo
asp playbookspec demo            # run playbook specs (host specs and role specs) for demo playbook
```

Run specs for role common:

```
~ master ● asp rolespec common

...

Total resources: 4
Touched resources: 4
Resource coverage: 100%
```

Run specs for role demo:

```
~ master ● asp rolespec demo

...

Total resources: 1
Touched resources: 1
Resource coverage: 100%
```

Run specs for role docker:

```
~ master ● asp rolespec docker

...

Total resources: 9
Touched resources: 1
Resource coverage: 11%

Uncovered resources:
- Package "python-pip"
- Package "docker-py"
- File "/etc/default/docker"
- Service "docker"
- File "/root/.docker"
- File "/root/.docker/config.json"
- File "/home/vagrant/.docker"
- File "/home/vagrant/.docker/config.json"
```

Run specs for host demo:

```
~ master ● asp hostspec demo

...

Total resources: 5
Touched resources: 5
Resource coverage: 100%
```

Run specs for playbook demo:

```
~ master ● asp playbookspec demo

...

Total resources: 19
Touched resources: 11
Resource coverage: 58%

Uncovered resources:
- Package "python-pip"
- Package "docker-py"
- File "/etc/default/docker"
- Service "docker"
- File "/root/.docker"
- File "/root/.docker/config.json"
- File "/home/vagrant/.docker"
- File "/home/vagrant/.docker/config.json"
```

### Locally within your Vagrant box

```
vagrant ssh demo
cd /vagrant
bundle install
```

ansible_spec_plus implements a switch to allow local test execution.

```
~ master ● asp -h
Ansible Spec Plus is an addon to 'ansible_spec' which enables you to run
specs for Ansible roles, hosts and/or playbooks separately. Furthermore
it provides you with a simple resource coverage summary.

Usage: asp COMMAND [OPTIONS]

Commands:
     list                                     # list all available specs
     [rolespec|hostspec|playbookspec] list    # list all available role/host/playbook specs

Options:
    -l, --local                      running specs on local machine
    -h, --help                       help
```

**Please note:** You may need sudo rights to run some specs. So don't forget to add 'sudo' before your asp command where you need it.

Run specs for role common:

```
~ master ● sudo asp rolespec common -l
```

Run specs for role demo:

```
~ master ● asp rolespec demo -l
```

Run specs for role docker:

```
~ master ● asp rolespec docker -l
```

Run specs for host demo:

```
~ master ● asp hostspec demo -l
```

Run specs for playbook demo:

```
~ master ● sudo asp playbookspec demo -l
```
