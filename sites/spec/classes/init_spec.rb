require 'spec_helper'
describe 'sites' do

  context 'with defaults for all parameters' do
    it { should contain_class('sites') }
  end
end
