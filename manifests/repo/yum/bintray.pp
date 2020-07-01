# Erlang bintray yum repo
class erlang::repo::yum::bintray (
  String $ensure = $erlang::repo::yum::ensure,
  String $version = $erlang::repo::yum::version,
  String $baseurl = "https://dl.bintray.com/rabbitmq-erlang/rpm/erlang/${version}/el/\$releasever",
) inherits erlang {
  yumrepo { 'erlang-bintray':
    ensure        => $ensure,
    name          => 'erlang-bintray',
    baseurl       => $baseurl,
    enabled       => '1',
    gpgcheck      => '0',
    repo_gpgcheck => '0',
  }
}
