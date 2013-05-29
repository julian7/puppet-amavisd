require 'spec_helper'

describe 'amavisd::service' do
  context do
    let(:params) {{ensure: 'ensureit'}}
    it 'makes sure services are running' do
      %w[amavis clamav-freshclam clamav-daemon].each do |what|
        should contain_service(what).with(
          ensure: 'ensureit',
          hasstatus: true,
          hasrestart: true,
          enable: true,
          require: ['Class[Amavisd::Package]', 'Class[Amavisd::Files]']
        )
      end
    end
  end
end
