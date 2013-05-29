require 'spec_helper'

describe 'amavisd::files' do
  context do
    it do
      dirstats = {
        ensure: 'directory',
        owner: 'root',
        group: 'root',
        mode: '0755',
        recurse: true
      }
      should contain_file('/etc/amavis').with(dirstats.merge(
        purge: true
      ))
      should contain_file('/etc/amavis/en_US').with(dirstats)
      should contain_file('/etc/amavis/conf.d').with(dirstats)
      should contain_file('/etc/amavis/conf.d/50-sql').with_ensure('absent')
    end
  end

  context "(with mysql params)" do
    let(:params) {{dbistr: 'DBIstring', dbname: 'dbname', dbpass: 'dbpass'}}
    it do
      should contain_file('/etc/amavis/conf.d/50-sql').with(
        ensure: 'present',
        owner: 'root',
        group: 'root',
        mode: '0600',
        content: <<-'EOF')
use strict;
@lookup_sql_dsn =(['DBIstring', 'dbname', 'dbpass']);
$sql_select_policy = 'SELECT domain FROM domains WHERE CONCAT("@",domain) IN (%k)';
$defang_virus  = 1;  # MIME-wrap passed infected mail
$defang_banned = 1;  # MIME-wrap passed mail containing banned name
1;
        EOF
    end
  end
end
