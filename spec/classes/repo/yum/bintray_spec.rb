require 'spec_helper'

describe 'erlang::repo::yum::bintray' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      case facts[:os]['family']
      when 'RedHat'
        let(:facts) { facts }
        let(:params) { { version: '23' } }

        it { is_expected.to compile.with_all_deps }

        context 'with default parameters' do
          it do
            is_expected.to contain_yumrepo('erlang-bintray').
              with('ensure'  => 'present',
                   'baseurl' => "https://dl.bintray.com/rabbitmq-erlang/rpm/erlang/23/el/\$releasever",
                   'enabled' => '1',
                   'gpgcheck' => '0',
                   'repo_gpgcheck' => '0')
          end
        end
      end
    end
  end
end
