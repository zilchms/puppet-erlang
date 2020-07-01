class erlang::repo::apt (
  String  $repo_ensure = $erlang::repo_ensure,
  Erlang::RepoSource $repo_source = $erlang::repo_source,
) inherits erlang {
  case $repo_source {
    'bintray': {
      contain erlang::repo::apt::bintray
    }
    default: {
      fail("Only 'bintray' repo_source is supported for Apt repos, the following is not supported: ${repo_source}")
    }
  }
}
