require 'spec_helper'

describe file('/root/.profile') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it 'contains the fix for a TTY error in Vagrant environments' do
    should contain "tty -s && mesg n"
  end
end

describe package('jq') do
  it { should be_installed }
end

describe package('language-pack-de') do
  it { should be_installed }
end

describe file('/etc/hosts') do
  it { should be_file }

  it 'contains host ip and hostname of the demo host' do
    should contain "10.100.100.200 demo"
  end
end

describe service('puppet') do
  it { should_not be_running }
end

describe service('chef-client') do
  it { should_not be_running }
end

describe package('software-properties-common') do
  it { should be_installed }
end
