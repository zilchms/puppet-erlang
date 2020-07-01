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

  case fact('os.family')
  when 'RedHat'
    context 'with repo source set to bintray' do
      let(:pp) do
        <<-EOS
        class { 'erlang': repo_source => 'bintray' }
        EOS
      end

      it_behaves_like 'an idempotent resource'

      describe package('erlang') do
        it { is_expected.to be_installed }
      end
    end

    context 'with repo source set to epel' do
      let(:pp) do
        <<-EOS
        class { 'erlang': repo_source => 'epel' }
        EOS
      end

      it_behaves_like 'an idempotent resource'

      describe package('erlang') do
        it { is_expected.to be_installed }
      end
    end

    context 'with repo source set to erlang_solutions' do
      let(:pp) do
        <<-EOS
        class { 'erlang': repo_source => 'erlang_solutions' }
        EOS
      end

      it_behaves_like 'an idempotent resource'

      describe package('erlang') do
        it { is_expected.to be_installed }
      end
    end

    context 'with repo source set to packagecloud' do
      let(:pp) do
        <<-EOS
        class { 'erlang': repo_source => 'packagecloud' }
        EOS
      end

      it_behaves_like 'an idempotent resource'

      describe package('erlang') do
        it { is_expected.to be_installed }
      end
    end

  when 'Debian'
    context 'with repo source set to bintray' do
      let(:pp) do
        <<-EOS
        class { 'erlang': repo_source => 'bintray' }
        EOS
      end

      it_behaves_like 'an idempotent resource'

      describe package('erlang') do
        it { is_expected.to be_installed }
      end
    end
  end
end
