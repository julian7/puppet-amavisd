require 'spec_helper'

describe 'amavisd::service' do
  context do
    let(:params) {{ensure: 'ensureit'}}
    it 'makes sure it is running' do
      should contain_service('amavis').with(
        ensure: 'ensureit',
        hasstatus: true,
        hasrestart: true,
        enable: true,
        require: 'Class[Amavis::Package]'
      )
    end
  end
end
