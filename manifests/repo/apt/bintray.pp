# erlang bintray apt repo
class erlang::repo::apt::bintray (
  String $repo_ensure            = $erlang::repo_ensure,
  String $location               = 'https://dl.bintray.com/rabbitmq-erlang/debian',
  String $repos                  = 'erlang',
  String $key                    = '0A9AF2115F4687BD29803A206B73A36E6026DFCA',
  String $key_source             = 'https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc',

) inherits erlang {
  # trusty, xenial, bionic, etc
  $release = downcase($facts['os']['distro']['codename'])

  apt::source { 'erlang-bintray':
    ensure   => $repo_ensure,
    location => $location,
    repos    => $repos,
    key      => {
      'id'     => $key,
      'source' => $key_source,
    },
  }

  # TODO
  # $pin    = $rabbitmq::package_apt_pin
  # if $pin {
  #   apt::pin { 'erlang':
  #     packages => '*',
  #     priority => $pin,
  #     origin   => inline_template('<%= require \'uri\'; URI(@location).host %>'),
  #   }
  # }
}
