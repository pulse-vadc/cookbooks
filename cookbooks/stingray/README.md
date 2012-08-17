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

| ** Attribute ** | ** Description ** | ** Default Value **|
|_|_|
| stingray/path | The path where Stingray exists (or will be installed to) | /opt/riverbed |
| stingray/version | The version of Stingray to install or configure | 90 |
| stingray/arch | The binary architecture | x86_64 |
| stingray/tmpdir | The location used to store temporary files | /tmp |
| stingray/accept_license | Whether or not you accept the Riverbed
[EULAs](http://www.riverbed.com/license).
Setting this to **accept** will indicate that you have read, understood and
accepted the terms. | reject |
| stingray/admin_user | The name of an administrative user.| admin |
| stingray/java_enabled | Whether or not to enable support for Java&trade; Extentions | no |

The administrative password set during the creation, or the joining of a
cluster.

Whether or not you accept the term and conditions of
the [Riverbed End User License Agreement and Product Warranty
Statement](http://www.riverbed.com/us/company/license/)

##stingray/path

The path to the Stingray instance that you want
to install or configure.  This attribute is required by all recipes.

##stingray/tmpdir

The path to store temporary files during installation.

##stingray/java_enabled

Whether or not Java Extensions are enabled.  Set to
*no* by default, since it's use requires a JVM to be installed on the target
system.

##stingray/ec2

We need to do special things when launched into EC2, so use
this if you are launching instances into EC2.  


#Usage
