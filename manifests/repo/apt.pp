# erlang apt repo
class erlang::repo::apt (
  String  $ensure = $erlang::repo_ensure,
  Erlang::RepoSource $source = $erlang::repo_source,
) inherits erlang {
  case $source {
    'bintray': {
      contain erlang::repo::apt::bintray
    }
    'erlang_solutions': {
      contain erlang::repo::apt::erlang_solutions
    }
    default: {
      fail("Only 'bintray' and 'erlang_solutions' repo_sources are supported for Apt repos, the following is not supported: ${source}")
    }
  }
}
