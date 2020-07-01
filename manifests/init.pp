# @summary Manages the Erlang repository and package installation
#
# @param package_apt_pin
#   Whether to pin the package to a particular source
#
# @param repo_version
#   Bintray repository sources for YUM require you to specify what major version
#   of Erlang you would like enabled. This should be a string like: '23'
class erlang (
  String  $package_name   = 'erlang',
  String  $package_ensure = 'installed',
  Optional[Variant[Numeric, String]] $package_apt_pin = undef,
  Boolean $manage_repo    = true,
  String  $repo_ensure    = 'present',
  Erlang::RepoSource $repo_source = 'packagecloud',
  Optional[String] $repo_version = undef,
) {
  if $manage_repo {
    contain erlang::repo
    Class['erlang::repo'] -> Package[$package_name]
  }

  package { $package_name:
    ensure => $package_ensure,
  }
}
