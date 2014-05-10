#!/usr/bin/env rspec

require 'spec_helper'

describe 'packetbeat' do
  let (:facts) { {
      :osfamily => 'RedHat'
  } }

  it { should contain_class 'packetbeat' }
end
