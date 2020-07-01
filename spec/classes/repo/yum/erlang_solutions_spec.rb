require 'spec_helper'

describe 'erlang::repo::yum::erlang_solutions' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      case facts[:os]['family']
      when 'RedHat'
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }

        context 'with default parameters' do
          it do
            is_expected.to contain_yumrepo('erlang-solutions').
              with('ensure'  => 'present',
                   'baseurl' => 'https://packages.erlang-solutions.com/rpm/centos/$releasever/$basearch',
                   'enabled' => '1',
                   'gpgcheck' => '1',
                   'gpgkey' => 'https://packages.erlang-solutions.com/rpm/erlang_solutions.asc')
          end
        end
      end
    end
  end
end
