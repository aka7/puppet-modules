# == Class: auditd
#
# Class to manage auditd rules
#
#
# Abdul Karim <abdul.karim@sky.uk>
#
# === Parameters
# TODO
#
class auditd (
  $auditd_file = '/etc/audit/auditd.conf',
  $auditd_file_contents = undef,
  $auditd_file_owner = 'root',
  $auditd_file_group = 'root',
  $auditd_file_mode = '0640',

  $audisp_syslog_file   = '/etc/audisp/plugins.d/syslog.conf',
  $audisp_syslog_file_contents = undef,
  $audisp_syslog_file_owner = 'root',
  $audisp_syslog_file_group = 'root',
  $audisp_syslog_file_mode =  '0640',

  $auditd_rules_file = '/etc/audit/audit.rules',
  $auditd_rules_file_contents = undef,
  $auditd_rules_file_owner = 'root',
  $auditd_rules_file_group = 'root',
  $auditd_rules_file_mode = '0640',
  $auditd_package = 'audit',

)
{
  validate_string($auditd_file, $auditd_file_contents,
    $auditd_file_owner, $auditd_file_group, $auditd_file_mode)
  validate_string($auditd_rules_file, $auditd_rules_file_contents,
    $auditd_rules_file_owner, $auditd_rules_file_group,
    $auditd_rules_file_mode)
  validate_string($audisp_syslog_file, $audisp_syslog_file_contents,
    $audisp_syslog_file_owner, $audisp_syslog_file_group,
    $audisp_syslog_file_mode,$auditd_package)
  if $::operatingsystem !~ /(RedHat|Debian)/ {
    fail("Module ${module_name} is not supported on ${::operatingsystem}")
  }

  $pkgname = $auditd_package
  package { $pkgname:
    ensure => installed
  }
  if $auditd_file_contents != undef{
    file { '$auditd_file':
      ensure  => 'file',
      content => delete($auditd_file_contents, ''),
      path    => $auditd_file,
      owner   => $auditd_file_owner,
      group   => $auditd_file_group,
      mode    => $auditd_file_mode,
    }
  }else{
    file { '$auditd_file':
      ensure => 'file',
      source => 'puppet:///modules/auditd/etc/auditd/auditd.conf',
      path   => $auditd_file,
      owner  => $auditd_file_owner,
      group  => $auditd_file_group,
      mode   => $auditd_file_mode,
    }
  }
  if $auditd_rules_file_contents != undef{
    file { '$auditd_rules_file':
      ensure  => 'file',
      content => delete($auditd_rules_file_contents, ''),
      path    => $auditd_rules_file,
      owner   => $auditd_rules_file_owner,
      group   => $auditd_rules_file_group,

      mode    => $auditd_rules_file_mode,
      notify  => Service['auditd']
    }
  }else{
    file { '$auditd_rules_file':
      ensure => 'file',
      source => 'puppet:///modules/auditd/etc/auditd/audit.rules',
      path   => $auditd_rules_file,
      owner  => $auditd_rules_file_owner,
      group  => $auditd_rules_file_group,
      mode   => $auditd_rules_file_mode,
      notify => Service['auditd']
    }
  }
  if $audisp_syslog_file_contents != undef{
    file { '$audisp_syslog_file':
      ensure  => 'file',
      content => delete($audisp_syslog_file_contents, ''),
      path    => $audisp_syslog_file,
      owner   => $audisp_syslog_file_owner,
      group   => $audisp_syslog_file_group,
      mode    => $audisp_syslog_file_mode,
      notify  => Service['auditd']
    }
  }else{
    file { '$audisp_syslog_file':
      ensure => 'file',
      source => 'puppet:///modules/auditd/etc/audisp/plugins.d/syslog.conf',
      path   => $audisp_syslog_file,
      owner  => $audisp_syslog_file_owner,
      group  => $audisp_syslog_file_group,
      mode   => $audisp_syslog_file_mode,
      notify => Service['auditd']
    }
  }
  file { '/sbin/audispd':
    mode  => '0750',
    owner => 'root',
    group => 'root',
  }
  # rhel7 audit.service fails to restart using default systemtctl command, bugzilla id 973697
  # workaround to use service restart
  if $::operatingsystem == 'RedHat' and $::operatingsystemmajrelease == 7 {
    service { 'auditd':
      ensure    => 'running',
      restart   => '/sbin/service auditd restart',
      enable    => true,
      require   => Package[$pkgname],
      subscribe => File[$auditd_file]
    }
  }else{
    service { 'auditd':
      ensure    => 'running',
      enable    => true,
      require   => Package[$pkgname],
      subscribe => File[$auditd_file]
    }
  }
}
