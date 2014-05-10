#!/usr/bin/env rspec

require 'spec_helper'

describe 'packetbeat' do
  it { should contain_class 'packetbeat' }
end
