# ansible-example

This is an example to show you how to use Ansible and Serverspec with [ansible_spec_plus](https://github.com/consort-it/ansible_spec_plus) to test roles,
hosts and playbooks and how to keep track of your code with simple resource coverge (test coverage).

Basic installation instructions on how to connect Ansible and Serverspec can be found [here](https://github.com/volanja/ansible_spec).

To make it short:

1. ```gem install ansible_spec_plus```

2. ```ansiblespec-init```

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
ansible-playbook demo-playbook.yml -i hosts --extra-vars "user=deploy"
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

**Please note:** Vagrant style host syntax and real world style hosts syntax is supported.

## Testing

#### On your host

```
bundle install
```

#### Inside your Vagrant box

```
vagrant ssh demo
cd /vagrant
bundle install
```
