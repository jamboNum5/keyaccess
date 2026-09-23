# Keyaccess

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with keyaccess](#setup)
    * [Setup requirements](#setup-requirements)
    * [What keyaccess affects](#what-keyaccess-affects)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Module has a fact that reports the installed version of KeyAccess, while 
Puppet manifests run a comparison to ensure that version being installed 
matches 

## Setup

### Setup Requirements

- Download the required keyaccess debian package and move it to: `/keyaccess/files/KeyAccess.deb`
- Ensure that the ENC variable matches the version in the `KeyAcess.deb` file.

### What keyaccess affects

- Debian package is installed: `dpkg -l keyaccess`
- Config file is held at: `/usr/share/ka/ka.xml`

## Limitations

Ubuntu only, maybe other Debian distros.

## Development

TBC
