require 'spec_helper_acceptance'

describe 'erlang init:' do
  context 'default class declaration' do
    let(:pp) do
      <<-EOS
      class { 'erlang': }
      EOS
    end

    it_behaves_like 'an idempotent resource'

    describe package('erlang') do
      it { is_expected.to be_installed }
    end
  end
end
