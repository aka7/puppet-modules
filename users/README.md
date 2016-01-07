# users

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with users](#setup)
    * [What users affects](#what-users-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with users](#beginning-with-users)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

puppet module to add users, using virtual resource.

## Module Description

## Setup

configure all users as default list in foreman.  users::virtual::accounts: This will only define virtual users and won't acutally create the user in your node.
then use users class add all usernames you need creating in your node /hostgroup. This will realize the user listed in useranames. This is array of usernames. 

This can also be defined using hiera but this is only tested using foreman smartclass param.

### What users affects

### Setup Requirements **OPTIONAL**

### Beginning with users

## Usage

configure all virtual users in foreman / hiera or in a class

i.e in foreman, the yaml output looks liek this
````
users::virtual::accounts:
  user_data:
      admin:
        ensure: present
        uid: 666
        gid: 666
        password: xxxxxx 
        shell: /bin/bash
        comment: Admin Account - puppet managed
        manage_home: true
        home_dir: /home/admin
        create_group: true
        ssh_key_type: ssh-rsa
        ssh_key:
          isadmins:
            user: admin
            type: ssh-rsa
            key: xxxxx 
          akarim_key:
            user: admin
            type: ssh-rsa
            key: xxxxx
      foo:
        uid: 667
        gid: 667
        password: xxxxxx 
        shell: /bin/bash
        comment: foo Account - puppet managed
        manage_home: true
        home_dir: /home/foo
        create_group: true
````
in your node / hostgroup, include which users you want created. using users class.

Foreman yaml output below
````
users:
  usernames:
    - admin
````

Example without foreman, defined in a class, (you can use hiera here instead )

````

class common::users {
  $users = {
    'admin'        => { uid => 666,
      gid          => 666,
      comment      => 'admin Account - puppet managed'
      home_dir     => '/home/admin',
      create_group => true,
    },
    'foo'          => { uid => 667,
      gid          => 667,
      comment      => 'foo Account - puppet managed'
      home_dir     => '/home/foo',
      create_group => true,
    },
  }
  class { 'users::virtual::accounts': user_data => $users }
}
````
then in your node, include which users you want created. puppet will only create the users listed in user_list below. array of usernames.

````
node /mynode/{
  include common::users
  $user_list = ['admin']
  class { 'users': usernames => $user_list }
}
````
will create user admin in mynode

## Reference

This is a modication of torrancew-accounts module. which had lot of limitations, on what I wanted to achieve.  
for exmaple,
- I wanted to defined all users in one place, as virtual resource. so all users can be defined in one place in foreman.
- have a way to add muttiple ssh_keys

because of the virtual resource approach I didn't feel pull request will be appropiate.

## Limitations


## Development

## Release Notes/Contributors/Etc **Optional**

