# frozen_string_literal: true

require 'spec_helper'

describe 'erlang::repo::yum' do # rubocop:disable RSpec/EmptyExampleGroup
  on_supported_os.each do |os, facts|
    case facts[:os]['family']
    when 'RedHat'
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }

        context 'with default parameters' do
          it { is_expected.to contain_class('erlang::repo::yum::packagecloud') }
        end

        context 'with source set to epel' do
          let(:params) { { source: 'epel' } }

          it { is_expected.to contain_class('erlang::repo::yum::epel') }
        end

        context 'with source set to erlang_solutions' do
          let(:params) { { source: 'erlang_solutions' } }

          it { is_expected.to contain_class('erlang::repo::yum::epel') }
          it { is_expected.to contain_class('erlang::repo::yum::erlang_solutions') }
        end

        context 'with source set to packagecloud' do
          let(:params) { { source: 'packagecloud' } }

          it { is_expected.to contain_class('erlang::repo::yum::packagecloud') }
        end

        context 'with source set to invalid' do
          let(:params) { { source: 'invalid' } }

          it { is_expected.to compile.and_raise_error(%r{parameter 'source' expects a match for}) }
        end
      end
    end
  end
end
