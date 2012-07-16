action :configure do

	log "Configuring Traffic IP Group #{new_resource.name}"
   nr = new_resource # Abbreviate new_resource
	cr = TrafficIPGroup.new(nr.name) # Read current resource from disk

	template nr.name do
      cookbook "stingray"
		source "trafficipgroup.erb"
		mode "0644"
		variables(
			:enabled => defined?(nr.enabled).class != NilClass ? nr.enabled : cr.enabled,
			:ipaddresses => defined?(nr.ipaddresses).class != NilClass ? nr.ipaddresses : cr.ipaddresses,
			:keeptogether => defined?(nr.keeptogether).class != NilClass ? nr.keeptogether : cr.keeptogether,
			:machines => defined?(nr.machines).class != NilClass ? nr.machines : cr.machines,
			:slaves => defined?(nr.slaves).class != NilClass ? nr.slaves : cr.slaves
		)
	end

end

action :delete do

	log "Deleting Traffic IP Group #{new_resource.name}"
	file "#{new_resource.name}" do
		action :delete
	end

end
