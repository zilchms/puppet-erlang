# Class that manages the erlang repo
class erlang::repo {
  case $facts['os']['family'] {
    'Debian': {
      contain erlang::repo::apt
    }
    'RedHat': {
      contain erlang::repo::yum
    }
  }
}
