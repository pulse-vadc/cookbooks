# Stop all Stingray process
# Remove init scripts
# Delete the installation

# FIXME need to only nuke one installation.
execute "kill zeus.* processes" do
	command "pkill -9 zeus.*"
	ignore_failure true
end

execute "   delete *zeus initscripts" do
	command "find /etc/ -name *zeus -exec rm '{}' \\;"
	ignore_failure true
end

directory node["stingray"]["path"] do
	recursive true
	action :delete
	ignore_failure true
end
