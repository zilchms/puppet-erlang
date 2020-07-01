# Erlang bintray yum repo
class erlang::repo::yum::bintray (
  String $ensure = $erlang::repo_ensure,
  String $baseurl = 'https://dl.bintray.com/rabbitmq-erlang/rpm'
) {
  yumrepo { 'erlang-bintray':
    ensure        => $ensure,
    baseurl       => $baseurl,
    enabled       => '1',
    gpgcheck      => '0',
    repo_gpgcheck => '1',
  }
}
