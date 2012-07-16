# Copyright 2012, Riverbed Technology, Inc.
#
# All rights reserved - Do Not Redistribute
#

# The name of our resource.
attribute :name,	:kind_of => String,	:name_attribute => true

# Default,modifiable attributes
attribute :version,     :kind_of => String,  :default => "90"
attribute :arch,        :kind_of => String,  :default => "x86_64"
attribute :java_enabled,:kind_of => String,  :default => "no"
attribute :tmpdir,      :kind_of => String,  :default => "/tmp"
attribute :path,        :kind_of => String,  :default => "/opt/riverbed"

# Required attributes - need these to provision the software.
attribute :accept_license,	:kind_of => String,  :required => true
attribute :admin_user,	:kind_of => String,  :required => true, :default => "admin"
attribute :admin_pass,	:kind_of => String,  :required => true
attribute :license_key,	:kind_of => String, :default => ""

# Optional attributes.
attribute :join_cluster_host,	:kind_of => String
attribute :join_cluster_port,	:kind_of => String

# AWS attributes.
attribute :ec2,   :kind_of => [FalseClass, TrueClass], :default => false

actions :install, :uninstall, :new_cluster, :join_cluster, :reset_to_defaults, :restart
