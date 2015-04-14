node default {
  # this makes puppet and vagrant shut up about the puppet group
  group { "puppet":
    ensure => "present",
  }

  # Set default paths
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

  # make sure the packages are up to date before beginning
  exec { "apt-get update":
    command => "apt-get update"
  }

  # because puppet command are not run sequentially, ensure that packages are
  # up to date before installing before installing packages, services, files, etc.
  Package { require => Exec["apt-get update"] }
  File { require => Exec["apt-get update"] }

  package {
      "build-essential": ensure => installed;
      "python3": ensure => installed;
      "python3-dev": ensure => installed;
      "python3-pip": ensure => installed;
  }
}
