# erlang packagecloud apt repo
class erlang::repo::apt::packagecloud (
  String $repo_ensure = $erlang::repo_ensure,
  # debian, ubuntu, etc
  String $location    = "https://packagecloud.io/rabbitmq/erlang/${downcase($facts['os']['name'])}",
  # trusty, xenial, bionic, etc
  String $release     = downcase($facts['os']['distro']['codename']),
  String $repos       = 'main',
  String $key         = '2EBDE413D3CE5D35BCD15B7C71C63471DF309A0B',
  String $key_source  = 'https://packagecloud.io/rabbitmq/erlang/gpgkey',
  Optional[Variant[Numeric, String]] $pin = $erlang::package_apt_pin,
) inherits erlang {
  apt::source { 'erlang-bintray':
    ensure   => $repo_ensure,
    location => $location,
    release  => $release,
    repos    => $repos,
    key      => {
      'id'     => $key,
      'source' => $key_source,
    },
  }

  if $pin {
    apt::pin { 'erlang':
      packages => '*',
      priority => $pin,
      origin   => inline_template('<%= require \'uri\'; URI(@location).host %>'),
    }
  }
}
