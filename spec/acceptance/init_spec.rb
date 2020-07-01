require 'spec_helper_acceptance'

describe 'erlang init:' do
  case fact('os.family')
  when 'RedHat'
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
      describe yumrepo('erlang-packagecloud') do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
      end
    end

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
      describe yumrepo('erlang-bintray') do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
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
      describe yumrepo('epel') do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
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
      describe yumrepo('erlang-solutions') do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
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
      describe yumrepo('erlang-packagecloud') do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
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
