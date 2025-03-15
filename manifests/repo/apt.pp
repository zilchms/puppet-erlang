# erlang apt repo
class erlang::repo::apt (
  String  $ensure = $erlang::repo_ensure,
  Erlang::RepoSource $source = $erlang::repo_source,
  String $location    = 'https://packages.erlang-solutions.com/debian',
  # trusty, xenial, bionic, etc
  String $release     = downcase($facts['os']['distro']['codename']),
  String $repos       = 'contrib',
  String $key         = '434975BD900CCBE4F7EE1B1ED208507CA14F4FCA',
  String $key_source  = 'https://packages.erlang-solutions.com/debian/erlang_solutions.asc',
  Optional[Variant[Numeric, String]] $pin = $erlang::package_apt_pin,
) inherits erlang {
  case $source {
    'erlang_solutions': {
      apt::source { 'erlang-erlang_solutions':
        ensure   => $ensure,
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
    default: {
      fail("Only 'erlang_solutions' repo_sources is supported for Apt repos, the following is not supported: ${source}")
    }
  }
}
