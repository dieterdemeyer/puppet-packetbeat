#!/usr/bin/env rspec

require 'spec_helper'

describe 'packetbeat' do
  let (:facts) { {
      :osfamily => 'RedHat'
  } }

  let (:params) { {
      :version => '0.2.0-1.el6'
  } }

  it { should contain_class 'packetbeat' }
end
