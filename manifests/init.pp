# @summary Manages the Erlang repository and package installation
#
# @param package_apt_pin
#   Whether to pin the package to a particular source
class erlang (
  String  $package_name   = 'erlang',
  String  $package_ensure = 'installed',
  Optional[Variant[Numeric, String]] $package_apt_pin = undef,
  Boolean $manage_repo    = true,
  String  $repo_ensure    = 'present',
  Erlang::RepoSource $repo_source = 'packagecloud',
) {
  if $manage_repo {
    contain erlang::repo
    Class['erlang::repo'] -> Package[$package_name]
  }

  package { $package_name:
    ensure => $package_ensure,
  }
}
