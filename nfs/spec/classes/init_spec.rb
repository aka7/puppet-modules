require 'spec_helper'
describe 'nfs' do

  context 'with defaults for all parameters' do
    it { should contain_class('nfs') }
  end
end
