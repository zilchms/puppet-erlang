class erlang::repo::apt (
  String  $repo_ensure = $erlang::repo_ensure,
  Erlang::RepoSource $repo_source = $erlang::repo_source,

) inherits erlang {
  case $repo_source {
    'bintray': {
      contain erlang::repo::apt::bintray
    }
    'erlang_solutions': {
      contain erlang::repo::apt::erlang_solutions
    }
    default: {
      fail("Only 'bintray' and 'erlang_solutions' repo_sources are supported for Apt repos, the following is not supported: ${repo_source}")
    }
  }
}
