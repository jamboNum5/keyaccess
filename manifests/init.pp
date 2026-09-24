# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include keyaccess
# @param keyaccess_version
#   The required version
# @param keyaccess_install
#   Whether to install or remove
# @param ka_hostname
#   location of the keyaccess server
class keyaccess (
  String  $keyaccess_version = '8.1.0.7',
  String  $ka_hostname = 'https://somewhere.com',
  Boolean $keyaccess_install = true
) {
  if ( $keyaccess_install == true) {
    include keyaccess::install
  } else { # Remove KeyAccess
    package { 'keyaccess' :
      ensure => 'absent',
    }
    file { 'keyaccess.service':
      ensure => absent,
      path   => '/etc/systemd/system/keyaccess.service',
      notify => Exec['daemon_reload'],
    }
    #require 'ufw'
    #ufw_rule { 'allow-keyaccess':
    #  ensure       => absent,
    #  action       => 'allow',
    #  to_ports_app => 19283,
    #  proto        => 'udp',
    #  to_addr      => '158.125.161.185',
    #}
  }
}
