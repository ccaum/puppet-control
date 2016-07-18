class profile::compliance (
  Array $purge_unamanaged_resource_types = []
) {

  # This module contains di cult to  nd RHEL packages such as sudosh2 # as well as SIMP speci c packages. We don’t need to include the
  # SIMP speci c packages since we’re leveraging an existing Puppet
  # Enterprise deployment
  yumrepo { 'simp-packages':
    ensure   => present,
    baseurl  => "http://dl.bintray.com/simp/5.1.X", 
    gpgcheck => 0,
    exclude  => [
      'mcollective.*',
      'puppet.*',
      'hiera.*',
      'puppet.*',
      'pupmod.*',
      'razor.*',
      'simp'
    ],
    before => [ Class['clamav','sudosh'] ],
  }

  include 'aide'
  include 'auditd'

  # Virus scanning. 
  include 'clamav'

  #Class[‘simplib’] expects this group to exist 
  group { 'puppet':
    ensure => present,
    before => Class['simplib']
  }
}
