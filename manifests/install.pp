# @summary A short summary of the purpose of this class
#
# Handle the installation outside of apt because Sassafrass is awkward
# and requires an environment variable to install.
# 
# KeyAccess Doc: https://www.sassafras.com/hrl/8.1/k2clientlinux.html
# 
# @example
#   include keyaccess::install
class keyaccess::install {
  require 'ufw'

  if ( $facts['keyaccess_version'] != $keyaccess::keyaccess_version) {
    notify { 'Installing Keyaccess' :
      message => $keyaccess::keyaccess_version,
    }
    # Place install file on machine if Keyaccess isn't present or the 
    # incorrect version.
    file { 'keyaccess_deb' :
      ensure => 'file',
      source => 'puppet:///modules/keyaccess/KeyAccess.deb',
      path   => '/tmp/KeyAccess.deb',
    }
  }
  # Install with dpkg with env variable
  exec { 'keyaccess_install' :
    command     => '/usr/bin/dpkg -i /tmp/KeyAccess.deb',
    #require     => File['keyaccess_deb'],
    unless      => '/usr/bin/dpkg -l keyaccess',
    environment => "KA_SERVERHOST=${keyaccess::ka_hostname}",
  }

  # Require Firewall Rule for 19283
  ufw_rule { 'allow-keyaccess':
    action       => 'allow',
    to_ports_app => 19283,
    proto        => 'udp',
    to_addr      => '158.125.161.185',
  }

  # Ensure Service is running
  service { 'keyaccess':
    ensure => 'running',
    enable => true,
  }

  file { '/usr/share/ka/ka.xml':
    ensure  => file,
    #source => 'puppet:///modules/keyaccess/ka/ka.xml',
    content => template('keyaccess/ka.xml.erb'),
    notify  => Service['keyaccess'],
  }

  # Remove legacy incorrect systemd file, fallback to default: 
  # /etc/systemd/system/multi-user.target.wants/keyaccess.service
  #file { 'keyaccess.service.rm':
  #  ensure => 'file',
  #  path   => '/etc/systemd/system/keyaccess.service',
  #  notify => Exec['daemon_reload'],
  #}
}
