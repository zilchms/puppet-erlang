require 'spec_helper'

describe 'erlang::repo::yum::packagecloud' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      case facts[:os]['family']
      when 'RedHat'
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }

        context 'with default parameters' do
          it do
            is_expected.to contain_yumrepo('erlang-packagecloud').
              with('ensure'  => 'present',
                   'baseurl' => "https://packagecloud.io/rabbitmq/erlang/el/#{facts[:os]['release']['major']}/$basearch",
                   'enabled' => '1',
                   'gpgcheck' => '0',
                   'repo_gpgcheck' => '1',
                   'gpgkey' => 'https://packagecloud.io/rabbitmq/erlang/gpgkey')
          end
        end
      end
    end
  end
end
