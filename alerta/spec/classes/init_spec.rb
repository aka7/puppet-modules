require 'spec_helper'
describe 'alerta' do

  context 'with defaults for all parameters' do
    it { should contain_class('alerta') }
  end
end
