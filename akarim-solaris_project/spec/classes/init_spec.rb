require 'spec_helper'
describe 'solaris_project' do

  context 'with defaults for all parameters' do
    it { should contain_class('solaris_project') }
  end
end
