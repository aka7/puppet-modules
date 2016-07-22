# audit

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with audit](#setup)
    * [What audit affects](#what-audit-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with audit](#beginning-with-audit)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

confiugure and maintain auditd

## Module Description

confiugure and maintain auditd

## Setup

### What audit affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
manges following files
```
/etc/audit/auditd.conf  
/etc/audit/audit.rules
/etc/audisp/plugins.d/syslog.conf
```

### Setup Requirements **OPTIONAL**


### Beginning with audit


## Usage

default values
```
class {'auditd': }

```
Add custom rules
```
class {'auditd':
  auditd_rules_file_contents => "-w /etc/hosts -p wa -k hosts_file_change
-w /etc/passwd -p wa -k passwd_changes
-w /etc/selinux/ -p wa -k selinux_changes
",
}
``
## Reference

## Limitations

Only tested on redhat 6.7

## Development


## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
