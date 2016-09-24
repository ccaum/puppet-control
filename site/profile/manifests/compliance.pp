class profile::compliance (
  Array $purge_unamanaged_resource_types = []
) {

  class { 'os_hardening': }
}
