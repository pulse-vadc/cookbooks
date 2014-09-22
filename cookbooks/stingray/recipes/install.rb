#Cookbook Name:: stingray
# Recipe:: install
#
# Copyright 2012, Riverbed Technology, Inc.
#
# All rights reserved - Do Not Redistribute
#

stingray node["stingray"]["name"] do
	admin_pass node["stingray"]["admin_pass"]
	accept_license	node["stingray"]["accept_license"]
	license_key node["stingray"]["license_key"]
	tmpdir node["stingray"]["tmpdir"]
	path node["stingray"]["path"]
        version node["stingray"]["version"]
	action :install
end
