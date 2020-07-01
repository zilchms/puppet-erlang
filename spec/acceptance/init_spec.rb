require 'spec_helper_acceptance'

describe 'erlang init:' do
  case fact('os.family')
  when 'RedHat'
    default_repo_source = 'packagecloud'
    repo_source_list = %w[bintray erlang_solutions packagecloud]
  when 'Debian'
    default_repo_source = 'bintray'
    repo_source_list = %w[bintray erlang_solutions]
  end

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
      describe yumrepo("erlang-#{default_repo_source}") do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
      end
    end

    context 'removing package and default repo_source' do
      let(:pp) do
        <<-EOS
        class { 'erlang':
          package_ensure => 'absent',
          repo_ensure => 'absent',
        }
        EOS
      end

      it_behaves_like 'an idempotent resource'

      describe package('erlang') do
        it { is_expected.not_to be_installed }
      end
      describe yumrepo("erlang-#{default_repo_source}") do
        it { is_expected.not_to exist }
      end
    end

    repo_source_list.each do |repo_source|
      context "with repo source set to #{repo_source}" do
        let(:pp) do
          <<-EOS
          class { 'erlang': repo_source => '#{repo_source}' }
          EOS
        end

        it_behaves_like 'an idempotent resource'

        describe package('erlang') do
          it { is_expected.to be_installed }
        end
        describe yumrepo("erlang-#{repo_source}") do
          it { is_expected.to exist }
          it { is_expected.to be_enabled }
        end
      end

      context "removing package and repo source: #{repo_source}" do
        let(:pp) do
          <<-EOS
          class { 'erlang':
            package_ensure => 'absent',
            repo_source => '#{repo_source}',
            repo_ensure => 'absent',
          }
          EOS
        end

        it_behaves_like 'an idempotent resource'

        describe package('erlang') do
          it { is_expected.not_to be_installed }
        end
        describe yumrepo("erlang-#{default_repo_source}") do
          it { is_expected.not_to exist }
        end
      end
    end

    # epel is special in that it enables the epel repo not the erlang-epel repo
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

    context 'removing package and repo source: epel' do
      let(:pp) do
        <<-EOS
        class { 'erlang':
          package_ensure => 'absent',
          repo_source => 'epel',
          repo_ensure => 'absent',
        }
        EOS
      end

      it_behaves_like 'an idempotent resource'

      describe package('erlang') do
        it { is_expected.not_to be_installed }
      end
      describe yumrepo('epel') do
        it { is_expected.not_to exist }
      end
    end
  when 'Debian'
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

    repo_source_list.each do |repo_source|
      context "with repo source set to #{repo_source}" do
        let(:pp) do
          <<-EOS
          class { 'erlang': repo_source => '#{repo_source}' }
          EOS
        end

        it_behaves_like 'an idempotent resource'

        describe package('erlang') do
          it { is_expected.to be_installed }
        end
      end

      context "removing package and repo source: #{repo_source}" do
        let(:pp) do
          <<-EOS
          class { 'erlang':
            package_ensure => 'absent',
            repo_source => '#{repo_source}',
            repo_ensure => 'absent',
          }
          EOS
        end

        it_behaves_like 'an idempotent resource'

        describe package('erlang') do
          it { is_expected.not_to be_installed }
        end
      end
    end
  end
end
