# Erlang packagecloud yum repo
class erlang::repo::yum::erlang_solutions (
  String $ensure  = $erlang::repo_ensure,
  String $baseurl = "https://packages.erlang-solutions.com/rpm/centos/\$releasever/\$basearch",
  String $gpgkey = 'https://packages.erlang-solutions.com/rpm/erlang_solutions.asc'
) {
  yumrepo { 'erlang-solutions':
    ensure        => $ensure,
    baseurl       => $baseurl,
    enabled       => '1',
    gpgcheck      => '1',
  }
}
