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
      should contain_file('/etc/amavis/conf.d/15-av_scanners').with_ensure('absent')
      should contain_file('/etc/amavis/conf.d/15-content_filter_mode').with_ensure('absent')
    end
  end

  context "(with mysql params)" do
    let(:params) {{dbistr: 'DBIstring', dbuser: 'dbuser', dbpass: 'dbpass'}}
    it do
      should contain_file('/etc/amavis/conf.d/50-sql').with(
        ensure: 'present',
        owner: 'root',
        group: 'root',
        mode: '0600',
        content: <<-'EOF')
use strict;
@lookup_sql_dsn =(['DBIstring', 'dbuser', 'dbpass']);
$sql_select_policy = 'SELECT domain FROM domains WHERE CONCAT("@",domain) IN (%k)';
$defang_virus  = 1;  # MIME-wrap passed infected mail
$defang_banned = 1;  # MIME-wrap passed mail containing banned name
1;
        EOF
    end
  end

  context "(with av checking enabled)" do
    let(:params) {{virus_checking: true}}
    it do
      should contain_file('/etc/amavis/conf.d/15-av_scanners').with(
        ensure: 'present',
        owner: 'root',
        group: 'root',
        mode: '0644')
      should contain_file('/etc/amavis/conf.d/15-content_filter_mode').with(
        ensure: 'present',
        owner: 'root',
        group: 'root',
        mode: '0644')
    end
  end

  context "(with spam checking enabled)" do
    let(:params) {{spam_checking: true}}
    it do
      should contain_file('/etc/amavis/conf.d/15-av_scanners').with_ensure('absent')
      should contain_file('/etc/amavis/conf.d/15-content_filter_mode').with(
        ensure: 'present',
        owner: 'root',
        group: 'root',
        mode: '0644')
    end
  end
end
