# @summary Manages the Erlang repository and package installation
class erlang (
  Boolean $manage_package = true,
  String  $package_name   = 'erlang',
  String  $package_ensure = 'installed',
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
