# solaris_project

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with solaris_project](#setup)
    * [What solaris_project affects](#what-solaris_project-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with solaris_project](#beginning-with-solaris_project)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

puppet provider to create and manage solaris project.

## Module Description
puppet provider to create and manage solaris project.

## Setup

### What solaris_project affects

/etc/project

### Setup Requirements **OPTIONAL**

The manifests is for providing mutltiple projects.

### Beginning with solaris_project

This module works with foreman smart class paramters.

## Usage

* Install mutiple projects
 	$proj_list = {
 	  'user.admin' => { 
 			projid  => 100,
 			name    => "user.admin",
			comment => "admin project settings",
			attribs => ["project.max-sem-nsems=(priv,128,deny)","project.max-sem-ids=(priv,100,deny)"]
		},
	 }
	 class { solaris_project::create_project: project_list => $proj_list }
	
* In Foreman
	set the type as yaml and provide details in parameters like so.
	
	  user.admin:
	  	projid: 100
	  	name: user.admin
	  	comment: 'Admin project settgins,
	  	attribs:
	  	  - project.max-sem-nsems=(priv,128,deny)
	  	  - project.max-sem-ids=(priv,100,deny)
		
## Reference

## Limitations

Testing on solaris 10 and 11 only

## Development

## Release Notes/Contributors/Etc **Optional**
