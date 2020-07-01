require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  case fact_on(host, 'os.family')
  when 'RedHat'
    if fact_on(host, 'os.selinux.enabled')
      # Make sure selinux is disabled so the tests work.
      on host, puppet('resource', 'exec', 'setenforce 0', 'path=/bin:/sbin:/usr/bin:/usr/sbin', 'onlyif=which setenforce && getenforce | grep Enforcing')
    end
  end
end

shared_examples 'an idempotent resource' do
  it 'applies with no errors' do
    apply_manifest(pp, catch_failures: true)
  end

  it 'applies a second time without changes' do
    apply_manifest(pp, catch_changes: true)
  end
end
