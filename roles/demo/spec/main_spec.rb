require 'spec_helper'

describe docker_image('uifd/ui-for-docker:latest') do
  it { should exist }
end

describe docker_container('dockerui') do
  it { should exist }
  it { should have_volume('/var/run/docker.sock','/var/run/docker.sock') }
  its(['HostConfig.Privileged']) { should be true }
  its(['Config.Labels']) { should include "category" => "base" }
  its(['Config.ExposedPorts']) { should include /9000\/tcp/ }
end

describe port('9000') do
  it { should be_listening }
end
