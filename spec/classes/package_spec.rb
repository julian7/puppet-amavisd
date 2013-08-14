require 'spec_helper'

describe 'amavisd::package' do
  context do
    let(:params) { {ensure: 'ensure'} }
    it do
      %w[amavisd-new spamassassin clamav-daemon libdbi-perl].each do |what|
        should contain_package(what).with(ensure: 'ensure')
      end
    end
  end
end
