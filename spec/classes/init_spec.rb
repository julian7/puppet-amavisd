require 'spec_helper'

describe 'amavisd' do
  context do
    it { should contain_class('amavisd::package').with(ensure: 'present') }
    it { should contain_class('amavisd::service').with(ensure: 'running') }
  end

  context '(with ensure: latest)' do
    let(:params) { {ensure: 'latest'} }

    it { should contain_class('amavisd::package').with(ensure: 'latest') }
    it { should contain_class('amavisd::service').with(ensure: 'running') }
  end

  context '(with ensure: absent)' do
    let(:params) { {ensure: 'absent'} }

    it { should contain_class('amavisd::package').with(ensure: 'absent') }
    it { should contain_class('amavisd::service').with(ensure: 'absent') }
  end
end
