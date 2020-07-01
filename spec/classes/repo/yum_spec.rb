require 'spec_helper'

describe 'erlang::repo::yum' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      case facts[:os]['family']
      when 'RedHat'
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }

        context 'with default parameters' do
          it { is_expected.to contain_class('erlang::repo::yum::packagecloud') }
        end

        context 'with repo_source set to bintray' do
          let(:params) { { repo_source: 'bintray' } }

          it { is_expected.to contain_class('erlang::repo::yum::bintray') }
        end

        context 'with repo_source set to epel' do
          let(:params) { { repo_source: 'epel' } }

          it { is_expected.to contain_class('epel').that_comes_before('Package[erlang]') }
        end

        context 'with repo_source set to erlang_solutions' do
          let(:params) { { repo_source: 'erlang_solutions' } }

          it { is_expected.to contain_class('erlang::repo::yum::erlang_solutions') }
        end

        context 'with repo_source set to packagecloud' do
          let(:params) { { repo_source: 'packagecloud' } }

          it { is_expected.to contain_class('erlang::repo::yum::packagecloud') }
        end

        context 'with repo_source set to invalid' do
          let(:params) { { repo_source: 'invalid' } }

          it { is_expected.to compile.and_raise_error(%r{parameter 'repo_source' expects a match for}) }
        end
      end
    end
  end
end
