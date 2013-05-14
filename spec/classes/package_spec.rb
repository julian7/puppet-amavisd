require 'spec_helper'

describe 'amavisd::package' do
  context do
    let(:params) { {ensure: 'ensure'} }
    it { should contain_package('amavisd-new').with(ensure: 'ensure') }
  end
end
