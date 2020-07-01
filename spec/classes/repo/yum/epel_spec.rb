require 'spec_helper'

describe 'erlang::repo::yum::epel' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      case facts[:os]['family']
      when 'RedHat'
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('epel').that_comes_before('Package[erlang]') }
      end
    end
  end
end
