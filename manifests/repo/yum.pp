# erlang yum repo
class erlang::repo::yum (
  String  $repo_ensure = $erlang::repo_ensure,
  Erlang::RepoSource $repo_source = $erlang::repo_source,
) inherits erlang {
  case $repo_source {
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
      fail("Only 'bintray', 'packagecloud', 'epel' repo_source are supported for Yum repos, the following is not supported: ${repo_source}")
    }
  }
}
