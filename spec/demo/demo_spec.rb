require 'spec_helper'

describe package('git') do
  it { should be_installed.by('apt') }
end

describe package('ruby2.0') do
  it { should be_installed.by('apt') }
end

describe package('ruby2.0-dev') do
  it { should be_installed.by('apt') }
end

describe package('zlib1g-dev') do
  it { should be_installed.by('apt') }
end

describe package('bundler') do
  it { should be_installed.by('gem') }
end

describe command('update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 50 --slave /usr/bin/irb irb /usr/bin/irb2.0 --slave /usr/bin/rake rake /usr/bin/rake2.0 --slave /usr/bin/gem gem /usr/bin/gem2.0 --slave /usr/bin/rdoc rdoc /usr/bin/rdoc2.0 --slave /usr/bin/testrb testrb /usr/bin/testrb2.0 --slave /usr/bin/erb erb /usr/bin/erb2.0 --slave /usr/bin/ri ri /usr/bin/ri2.0') do
  its(:exit_status) { should eq 0 }
end
