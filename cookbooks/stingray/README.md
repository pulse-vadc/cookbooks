# vim:  set textwidth=0

#Description
This cookbook contains an LWRP for installing and configuring Stingray Traffic
Manager using node attributes.  Currently, the only provider writes files
directly.  In future, someone may write another provider that uses the API,
CLI, or **zconf**.

#Copyright

Copyright (C) 2012, Riverbed Technology, Inc. All rights reserved.

#Requirements

 * Chef
 * Stingray Traffic Manager


#Resources

##stingray

#Providers

##default
Developed against version 9.0; should probably be made a symbolic link to the
latest version.

##stingray90

##stingray90r2

#Recipes


#Attributes

## default

| Attribute                 | Description | Default Value |
| ---------                 | ----------- | ------------- |
| `stingray/path`           | The path where Stingray exists (or will be installed to) | `/opt/riverbed` |
| `stingray/version`        | The version of Stingray to install or configure | `90` |
| `stingray/arch`           | The binary architecture | `x86_64` |
| `stingray/tmpdir`         | The location used to store temporary files | `/tmp` |
| `stingray/accept_license` | Whether or not you accept the Riverbed [EULAs](http://www.riverbed.com/license).  Setting this to **accept** will indicate that you have read, understood and accepted the terms. | `reject` |
| `stingray/admin_user`     | The name of an administrative user. | `admin` |
| `stingray/admin_pass`     | The password to use/set for either joining or creating a cluster. |
| `stingray/java_enabled`   | Whether or not to enable support for Java&trade; Extentions. | `no` |
| `stingray/ec2`            | We need to do special things when launched into EC2, so use this if you are launching instances into EC2. | `no` |

