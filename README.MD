# cfgmgmt

This is a very basic configuration management tool(cfgmgmt) Currently, this tool can be used
to configure Nodes that run a simple PHP application. This tool tries to model what something like a more mature tool like Puppt would do but is written in bash

This was a fun challenge. I considered some options on how to structure this tool and my first pass was only a list of install commands running one after the other. A lil tril and error,  I decided to implement arrays in bash as this approach is probably a closer resemblence to the hash structure Puppet uses when managing resources(or atleast I think it does)


## Features:

1. Automates setup of a basic php stack
1. Install specific packages (Debian/Ubuntu only)
1. Remove specific packages (Debian/Ubuntu only)
1. Specify content and properties for files and directories
1. check for services that require a restart by leveraging `needrestart`


## How to Configure:

* To install a package, add the package name to the text file "install.txt" inside the "pkgs" directory. Each package name should be on it's own line without any whitespace.
* For removing an installed package, add the package names to the "uninstall.txt" file also inside the "pkgs" directory.
* To set properties and file content, we need key value pairs in the "properties.txt" file. Key value pairs must be separated by a Seperator "=" and each on it's own line. Again, trailing whitespace should be avoided like the plague

## **_Usage_**

* Git clone the repo

  ```bash
  git clone https://github.com/vishalud/basic-config-mgmt
  ```

* cwd into the directory

  ```bash
  cd basic-config-mgmt/
  ```

* Install dependency

  ```bash
  ./bootstrap.sh
  ```

* Run the script

  ```bash
  ./cfgmgmt.sh
  ```
