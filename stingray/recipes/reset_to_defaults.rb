#Cookbook Name:: stingray
# Recipe:: install
#
# Copyright 2012, Riverbed Technology, Inc.
#
# All rights reserved - Do Not Redistribute
#

stingray node["stingray"]["name"] do
	path	node["stingray"]["path"]
	action :reset_to_defaults
end
