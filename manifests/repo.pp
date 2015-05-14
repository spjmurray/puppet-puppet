# == Class: puppet::repo
#
# Optionally manages the puppet labs repository.  You may prefer to have a
# centralized database in hiera if multiple modules define this and manage
# from there, or you want to use pinning etc.
#
class puppet::repo (
) {

  assert_private()

  if $puppet::repo_manage {

    include ::apt

    apt::source { 'puppetlabs':
      location   => $puppet::repo_location,
      release    => $puppet::repo_release,
      repos      => $puppet::repo_repos,
      key        => $puppet::repo_key,
      key_source => $puppet::repo_key_source,
    }

  }

}
