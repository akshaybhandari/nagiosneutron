require 'spec_helper'
describe 'nagiosneutron' do

  context 'with defaults for all parameters' do
    it { should contain_class('nagiosneutron') }
  end
end
