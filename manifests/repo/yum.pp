# erlang yum repo
class erlang::repo::yum (
  String $ensure = $erlang::repo_ensure,
  Erlang::RepoSource $source = $erlang::repo_source,
  Optional[String] $version = $erlang::repo_version,
) inherits erlang {
  case $source {
    'bintray': {
      contain erlang::repo::yum::bintray
    }
    'epel': {
      # include epel instead of contain because lots of other stuff declares epel
      include epel
      # specifically declare dependency on epel repo
      Class['epel'] -> Package[$erlang::package_name]
    }
    'erlang_solutions': {
      contain erlang::repo::yum::erlang_solutions
    }
    'packagecloud': {
      contain erlang::repo::yum::packagecloud
    }
    default: {
      fail("Only 'bintray', 'packagecloud', 'epel' repo_source are supported for Yum repos, the following is not supported: ${source}")
    }
  }
}
