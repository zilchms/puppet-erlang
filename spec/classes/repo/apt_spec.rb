require 'spec_helper'

describe 'erlang::repo::apt' do
  on_supported_os.each do |os, facts|
    case facts[:os]['family']
    when 'Debian'
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }

        context 'with default parameters' do
          it { is_expected.to contain_class('erlang::repo::apt::bintray') }
        end

        context 'with source set to bintray' do
          let(:params) { { source: 'bintray' } }

          it { is_expected.to contain_class('erlang::repo::apt::bintray') }
        end

        context 'with source set to erlang_solutions' do
          let(:params) { { source: 'erlang_solutions' } }

          it { is_expected.to contain_class('erlang::repo::apt::erlang_solutions') }
        end

        context 'with source set to invalid' do
          let(:params) { { source: 'invalid' } }

          it { is_expected.to compile.and_raise_error(%r{parameter 'source' expects a match for}) }
        end
      end
    end
  end
end
