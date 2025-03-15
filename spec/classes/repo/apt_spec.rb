# frozen_string_literal: true

require 'spec_helper'

describe 'erlang::repo::apt' do # rubocop:disable RSpec/EmptyExampleGroup
  on_supported_os.each do |os, facts|
    case facts[:os]['family']
    when 'Debian'
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }

        context 'with source set to erlang_solutions' do
          let(:params) { { source: 'erlang_solutions' } }
          let(:release) { facts[:os]['distro']['codename'] }

          it do
            is_expected.to contain_apt__source('erlang-erlang_solutions').
              with('ensure' => 'present',
                   'location' => 'https://packages.erlang-solutions.com/debian',
                   'release' => release,
                   'repos' => 'contrib',
                   'key' => {
                     'id' => '434975BD900CCBE4F7EE1B1ED208507CA14F4FCA',
                     'source' => 'https://packages.erlang-solutions.com/debian/erlang_solutions.asc'
                   })
          end
        end

        context 'with source set to invalid' do
          let(:params) { { source: 'invalid' } }

          it { is_expected.to compile.and_raise_error(%r{parameter 'source' expects a match for}) }
        end
      end
    end
  end
end
